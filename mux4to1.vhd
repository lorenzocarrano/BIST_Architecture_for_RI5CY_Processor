library ieee;
use ieee.std_logic_1164;
use ieee.numeric_std.all;

Entity mux4to1 is
	Generic
	(
		Nbit : natural := 8;
	);
	Port
	(
		A    : in   std_logic_vector(Nbit -1 downto 0);
		B    : in   std_logic_vector(Nbit -1 downto 0);
		C    : in   std_logic_vector(Nbit -1 downto 0);
		D    : in   std_logic_vector(Nbit -1 downto 0);
		sel  : in   std_logic_vector(1 downto 0);
		Y    : out  std_logic_vector(Nbit -1 downto 0);
	);

end mux4to1;

Architecture beh of mux4to1 is

begin
	
	Output_selection: process(A, B, C, D, sel)
	begin
		case(sel) is

			when "00"   => Y <= A;
			
			when "01"   => Y <= B;

			when "10"   => Y <= C;

			--when "11" => Y <= D;
			
			when others => Y <= D;

		end case;
	end process;

end Architecture;
