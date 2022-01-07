library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
   
Entity misrTB is
end Entity;

Architecture tst of misrTB is

	Component comparator is
	Port
	(
		A    : in  std_logic;
		B    : in  std_logic;
		cmpRs: out std_logic;
	);

	end Component;

	signal A, B : std_logic;
	signal cmpRs: std_logic;

begin

	UUT: comparator Port Map(A => A, B => B, cmpRs => cmpRs);

	
	clkGen: process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;

end Architecture;
