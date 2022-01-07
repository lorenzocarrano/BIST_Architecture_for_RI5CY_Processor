library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
   
Entity bistControllerTB is
end bistControllerTB;

Architecture tst of bistControllerTB is

	Component bistController is
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
		TPG_ctrl  : out std_logic_vector(1 downto 0);
		ODE_ctrl  : out std_logic;
		G_NGn     : out std_logic; --go/nogo  out
		N_Tn      : out std_logic --test/normal mode
	);  
end Component;

	signal START, clk, rst, ODE_out : std_logic;
	signal cntScan, cntUpScan       : std_logic_vector(8  downto 0);
	signal cntPattern, cntUpPatt    : std_logic_vector(15 downto 0);
	signal cntPattEn, validity, clk_out, ODE_Ctlr, G_NGn, N_Tn : std_logic;
	signal TPG_ctrl : std_logic_vector(1 downto 0);

begin

	UUT: bistController Generic Map(scanLength => 10, nPatterns => 2)
						   Port Map(clock      => clk, 
									reset      => rst,
									START      => START,
									ODE_out    => ODE_out,
									cntScan    => cntScan,
									cntUpScan  => cntUpScan
									cntPattern => cntPattern,
									cntUpPatt  => cntUpPatt,
									cntPattEn  => cntPattEn,
									validity   => validity,
									clk_out    => clk_out,
									ODE_Ctlr   => ODE_Ctlr,
									G_NGn      => G_NGn,
									TPG_ctrl   => TPG_ctrl,
									N_Tn       => N_Tn							
						   );
	rst <= '0', '1' after 20 ns;
	
	START <= '0', 
			 '1' after 25 ns, 
			 '0' after 30 ns;
	
	cntScan    <= "000001010";
	cntPattern <= "0000000000000010";

	ODE_out    <= '1'; --assuming test is ok
	
	clkGen: process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;

end Architecture;
