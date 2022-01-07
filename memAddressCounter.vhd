library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity memAddressCounter is 
	Generic
	(
		N : positive := 9
	);
	Port
	(
		clk: in  std_logic;
		rst: in  std_logic;
		cen: in  std_logic; --count enable
		q  : out unsigned(N-1 downto 0)
		--eoc: out std_logic
	);
end memAddressCounter;

Architecture bhv of memAddressCounter is

begin

	countPrc: process(clk, rst, cen)
	variable cnt : natural;
	begin
		--up counter
		if clk'event and clk = '1' then
			if rst = '0' then
				cnt :=  0;
			
			elsif cen = '1' then
				cnt := cnt+1;
			end if;
		end if;
		--q <= std_logic_vector(to_unsigned(cnt, q'length));	
		q <= to_unsigned(cnt, q'length);

	end process;		
end Architecture;
