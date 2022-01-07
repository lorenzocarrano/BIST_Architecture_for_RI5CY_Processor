library ieee;
use ieee.std_logic_1164;
use ieee.numeric_std.all;

Entity comparator is
	Port
	(
		A    : in  std_logic_vector(7 downto 0);
		B    : in  std_logic_vector(7 downto 0);
		cmpRs: out std_logic;
	);

end comparator;

Architecture beh of comparator is

begin
	comparation_process: process(A, B)
	begin
		if A = B then
			cmpRes <= '1';
		else 
			cmpRes <= '0';
		end if;
	end process;
end Architecture;
