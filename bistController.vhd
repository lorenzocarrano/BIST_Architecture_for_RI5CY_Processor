--One-Hot Finite State Machine
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


Entity bistController is
	Generic
	(
		scanLength: natural:= 379;	
		nPatterns : natural:= 5000
	);
	Port
	( 
		START     : in std_logic;
		clock     : in std_logic;
		reset     : in std_logic; --active low
		ODE_out   : in std_logic; --go/nogo  in
		--counters signals
		cntScan   : in  unsigned(8 downto 0);
		cntPattern: in  unsigned(15 downto 0); 
		cntUpdScan: out std_logic;		 
		cntUpdPatt: out std_logic;	
		cntUpScan : out unsigned(8 downto 0);		 
		cntUpPatt : out unsigned(15 downto 0);
		cntPattEn : out std_logic;	 
		------------------
		validity  : out std_logic;
		clk_Out   : out std_logic;
		TPG_ctrl  : out std_logic_vector(2 downto 0);
		ODE_ctrl  : out std_logic_vector(1 downto 0);
		G_NGn     : out std_logic; --go/nogo  out
		N_Tn      : out std_logic --test/normal mode
	);  
end bistController;
	  
Architecture FSM of bistController is

	TYPE State_type IS (idle, fill00, fill01, fill10, fill11, chainCheck00, chainCheck01, chainCheck10, chainCheck11, scanIn, scanInOut, capture, testPassed, testFailed);
	SIGNAL current_state, next_State : State_type;
	

	BEGIN

	clk_Out <= clock;

FSM_transitions:	
		
		PROCESS (clock, reset)
		
			BEGIN 
		
				IF reset = '0' THEN next_State <= idle;
					
					ELSIF (clock'EVENT AND clock = '1') THEN
					
						CASE current_state IS
						
							WHEN idle => 
										IF (START = '0') THEN next_State <= idle;
											
										ELSE next_State <= fill00;
											
										END IF;
										
							WHEN fill00 => 
										
										IF (cntScan /= "000000000") THEN next_State <= fill01;
										
										ELSE next_State  <= chainCheck00;
												
										END IF;
							WHEN fill01 => 
										
										IF (cntScan /= "000000000") THEN next_State <= fill10;
										
										ELSE next_State  <= chainCheck00;
											
										END IF;
							WHEN fill10 => 
										
										IF (cntScan /= "000000000") THEN next_State <= fill11;
										
										ELSE next_State  <= chainCheck00;
												
										END IF;
							WHEN fill11 => 
										
										IF (cntScan /= "000000000") THEN next_State <= fill00;
										
										ELSE next_State  <= chainCheck00;
												
										END IF;
							
							WHEN chainCheck00 => 
										
										IF (ODE_out = '1') THEN next_State <= chainCheck01;
										
										ELSE next_State  <= testFailed;
												
										END IF;
										
										
							WHEN chainCheck01 => 
										
										IF (ODE_out = '1') THEN next_State <= chainCheck10;
										
										ELSE next_State  <= testFailed;
												
										END IF;
										
										
							WHEN chainCheck10 => 
										
										IF (ODE_out = '1') THEN next_State <= chainCheck11;
										
										ELSE next_State <= testFailed;
												
										END IF;
										
										
							WHEN chainCheck11 => 
										
										IF (ODE_out = '1') THEN next_State <= scanIn;
										
										ELSE next_State  <= testFailed;
												
										END IF;
										
										
							WHEN scanIn => 
										
										IF (cntScan /= "000000000") THEN next_State <= scanIn;
										
										ELSE next_State  <= capture;
												
										END IF;
							
							WHEN scanInOut => 

										IF (ODE_out = '0') THEN next_State <= testFailed;
										
										ELSIF cntScan /= "000000000" THEN next_State <= scanInOut;
										
										ELSE next_State  <= capture;
												
										END IF;

							
							WHEN capture => 
										
										IF (cntPattern = "0000000000000000") THEN next_State <= testPassed;
										
										ELSE next_State  <= scanInOut;
												
										END IF;
							
							WHEN testPassed => 
										
										next_State <= idle;

							--WHEN testFailed => 
							WHEN others =>
										
										next_State <= idle;
										
					END CASE;
				
				END IF;
			
			END PROCESS;
			
state_update: PROCESS (clock)

	begin
		if clock'event and clock = '1' then
			current_State <= next_State;
		end if;
	end process;

		
	
FSM_outputs : PROCESS(current_state)

	BEGIN
		
		N_Tn		<= '1';
		cntPattEn	<= '0';
		cntUpdScan 	<= '0'; 
		cntUpdPatt 	<= '0'; 
		TPG_ctrl	<= "011"; 
		ODE_ctrl	<= "11";
		validity	<= '0';
		
		
		CASE current_state IS
				
			WHEN idle =>
								
									cntUpdScan	<= '1'; 
									cntUpdPatt 	<= '1'; 
									cntUpScan 	<= to_unsigned(scanLength,9);
									cntUpPatt 	<= to_unsigned(nPatterns,16);
			WHEN fill00 =>
									
									N_Tn 		<= '0';
									TPG_ctrl(1 downto 0)	
												<= "00"; 
			WHEN fill01 =>
									
									N_Tn 		<= '0';
									TPG_ctrl(1 downto 0)	
												<= "00"; 
			WHEN fill10 =>
									
									N_Tn 		<= '0';
									TPG_ctrl(1 downto 0)	
												<= "01"; 
			WHEN fill11 =>
									
									N_Tn 		<= '0';
									TPG_ctrl(1 downto 0)	
												<= "01"; 
									
			WHEN chainCheck00 =>
									
									N_Tn 		<= '0';
									ODE_ctrl	<= "00"; 
			WHEN chainCheck01 =>
									
									N_Tn 		<= '0';
									ODE_ctrl	<= "00"; 
			WHEN chainCheck10 =>
									
									N_Tn 		<= '0';
									ODE_ctrl	<= "01"; 
			WHEN chainCheck11 =>
									
									N_Tn 		<= '0';
									ODE_ctrl	<= "01"; 
									cntUpdScan 	<= '1'; 
									cntUpScan 	<= to_unsigned(scanLength,9);
			WHEN scanIn =>
									
									N_Tn 		<= '0';
									TPG_ctrl(1 downto 0)	
												<= "10";
			WHEN scanInOut =>
									
									N_Tn 		<= '0';
									ODE_ctrl	<= "10"; 
									TPG_ctrl(1 downto 0)	
												<= "10";
			WHEN capture =>
									
									ODE_ctrl	<= "10"; 
									cntPattEn	<= '0';
									cntUpScan 	<= to_unsigned(scanLength,9);
									TPG_ctrl(2) <= '1';

			WHEN testPassed =>
			
									G_NGn		<= '1';
									validity	<= '1';
									
			WHEN testFailed =>
			
									G_NGn		<= '0';
									validity	<= '1';
								
			when others =>
				
			
		
		END CASE;	
				
	END PROCESS;
 
END architecture;
