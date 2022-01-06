library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
   
Entity counterTB is
end Entity;

Architecture tst of counterTB is

	Component Counter is 
		Generic
		(
			N : positive := 9
		);
		Port
		(
			clk: in  std_logic;
			cen: in  std_logic; --count enable
			upd: in  std_logic; --upload
			upV: in  unsigned(N-1 downto 0);
			q  : out unsigned(N-1 downto 0)
			--eoc: out std_logic
		);
	end Component;

	signal clk, upd, cen : std_logic;
	signal q, upV  : unsigned(8 downto 0);

begin

	UUT: Counter Generic Map (N => 9)
					Port Map (clk => clk, upd => upd, q => q, cen => cen, upV => upV);
	
	upd <= '0', '1' after 20 ns, '0' after 200 ns;
	cen <= '0', '1' after 50 ns;
	upV <= "000001010";

	clkGen: process
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	end process;

end Architecture;
