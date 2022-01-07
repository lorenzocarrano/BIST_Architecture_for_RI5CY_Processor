library ieee;
use ieee.std_logic_1164;
use ieee.numeric_std.all;

Entity comparator is
	Port
	(
		A    : in  std_logic;
		B    : in  std_logic;
		cmpRs: out std_logic;
	);

end comparator;

Architecture beh of comparator is

begin
	
	cmpRs <= not (A xor B);

end Architecture;
