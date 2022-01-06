library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
   
Entity lfsrTB2 is
end Entity;

Architecture tst of lfsrTB2 is

	Component lfsr is
		Port
		(
			clock: in std_logic;
			reset: in std_logic;
			q    : out std_logic_vector(7 downto 0)
		);

	end Component;

	signal clk, rst : std_logic;
	signal q  : std_logic_vector(7 downto 0);

begin

	UUT: lfsr Port Map(clock => clk, reset => rst, q => q);
	rst <= '0', '1' after 20 ns;
	
	clkGen: process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;

end Architecture;
