library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
	Generic
	(
		nBitAddress: natural : 16;
	);
    Port(
        address : in  std_logic_vector(nBitAddress -1 downto 0);
        dout    : out std_logic_vector(7 downto 0);
    );
end entity;

architecture RTL of ROM is
    type MEMORY_16_4 is array (0 to (2**(nBitAddress -2)) -1) of std_logic_vector(7 downto 0);
    constant ROM_16_4 : MEMORY_16_4 := (
	
    );
begin
    main : process(address)
    begin
        dout <= ROM_16_4(to_integer(unsigned(address)));
    end process main;

end architecture RTL;
