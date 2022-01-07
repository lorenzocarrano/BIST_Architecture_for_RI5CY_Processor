library ieee;
use ieee.std_logic_1164;
use ieee.numeric_std.all;

Entity ODE is
	Port
	(
		A    : in  std_logic;
		B    : in  std_logic;
		cmpRs: out std_logic;
	);

end ODE;

Architecture beh of comparator is
	Component comparator is
	Port
	(
		A    : in  std_logic;
		B    : in  std_logic;
		cmpRs: out std_logic;
	);
	end Component;
	Component misr is
	Port
	(
		clock: in std_logic;
		reset: in std_logic;
		input: in std_logic_vector(7 downto 0);
		q    : out std_logic_vector(7 downto 0)
	);

	end Component;

begin
	
	cmpRs <= not (A xor B);

end Architecture;
