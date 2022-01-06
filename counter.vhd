library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity Counter is 
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
end Counter;

Architecture bhv of Counter is

begin

	countPrc: process(clk, upd, upV, cen)
	variable cnt : natural;
	begin

		if clk'event and clk = '1' then
			if upd = '1' then
				cnt :=  to_integer(upV);
			
			elsif cen = '1' then
				cnt := cnt-1;
			end if;
		end if;
		--q <= std_logic_vector(to_unsigned(cnt, q'length));	
		q <= to_unsigned(cnt, q'length);

	end process;		
end Architecture;
