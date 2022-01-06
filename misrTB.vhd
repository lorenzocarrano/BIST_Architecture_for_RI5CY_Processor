library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
   
Entity misrTB is
end Entity;

Architecture tst of misrTB is

	Component misr is
	Port
	(
		clock: in std_logic;
		reset: in std_logic;
		input: in std_logic_vector(7 downto 0);
		q    : out std_logic_vector(7 downto 0)
	);

	end Component;

	signal clk, rst : std_logic;
	signal q  : std_logic_vector(7 downto 0);

begin

	UUT: misr Port Map(clock => clk, reset => rst, q => q, input => "10010100");
	rst <= '0', '1' after 20 ns;
	
	clkGen: process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;

end Architecture;
