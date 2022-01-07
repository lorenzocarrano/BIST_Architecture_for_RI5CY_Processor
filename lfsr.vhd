library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity lfsr is
	Port
	(
		clock: in std_logic;
		reset: in std_logic;
		seed : in std_logic_vector(7 downto 0)
		q    : out std_logic_vector(7 downto 0)
	);

end lfsr;



Architecture arch of lfsr is

	type RegIO is array(0 to 7) of std_logic;
	signal RegIn, RegOut : regIO;

	Component FD is

		    Port 
			(		        D:      In      std_logic;
		                    CK:     In      std_logic;
		                    RESET:  In      std_logic;
		                    SEED: 	In std_logic;
		                    Q:      Out     std_logic
			);

	end Component;
begin
	--polynomial: 1 + x^2 + x^3 + x^4 + x^8
	RegIn(0)  <= RegOut(7);
	Regin(1)  <= RegOut(0);
	Regin(2)  <= RegOut(7) xor RegOut(1);
	Regin(3)  <= RegOut(7) xor RegOut(2);	
	Regin(4)  <= RegOut(7) xor RegOut(3);
	Regin(5)  <= RegOut(4);
	Regin(6)  <= RegOut(5);
	Regin(7)  <= RegOut(6);
	
	reg: FD Port Map(D => RegIn(0),
					 CK => clock,
					 RESET => reset,
					 SEED => '1',
					 Q => RegOut(0)
			);

	polynomial_impl: for i in 1 to 7 generate
		reg: FD Port Map(D => RegIn(i),
						 CK => clock,
						 RESET => reset,
						 SEED => '0',
						 Q => RegOut(i)
				);
	end generate;

	--phase shifter inline implementation
	q(0) <= RegOut(0) xor RegOut(5);
	q(1) <= RegOut(1) xor RegOut(4);
	q(2) <= RegOut(2) xor RegOut(0);
	q(3) <= RegOut(3) xor RegOut(7);
	q(4) <= RegOut(4) xor RegOut(3);
	q(5) <= RegOut(5) xor RegOut(1);
	q(6) <= RegOut(6) xor RegOut(2);
	q(7) <= RegOut(7) xor RegOut(6);


end Architecture;

