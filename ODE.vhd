library ieee;
use ieee.std_logic_1164;
use ieee.numeric_std.all;

Entity ODE is
	Generic
	(
		nScan : natural := 10;
		nBitAddress: natural := 16
	);
	Port
	(
		clk    : in  std_logic;
		rst    : in  std_logic;
		ctrl   : in  std_logic;
		PPOs   : in  std_logic_vector(nScan -1 downto 0)
		ODE_out: out std_logic;
	);

end ODE;

Architecture beh of comparator is
	Component comparator is
		Port
		(
			A    : in  std_logic_vector(7 downto 0);
			B    : in  std_logic_vector(7 downto 0);
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

	Component ROM is
		Generic
		(
			nBitAddress: natural : 16;
		);
		Port(
		    address : in  std_logic_vector(nBitAddress -1 downto 0);
		    dout    : out std_logic_vector(7 downto 0);
		);
	end Component;

	Component memAddressCounter is 
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
	end Component;

	signal misrOut, romOut : std_logic_vector(7 downto 0);
	signal romMemAddress   : std_logic_vector(nBitAddress -1 downto 0);

begin

	misr_U : misr Port Map(clok => clk, reset => rst, input => PPOs, q => misrOut);
	
	cmp_U :  comparator Port Map(A => misrOut, B => romOut, cmpRs => ODE_out);

	addrCnt: memAddressCounter Generic Map( N => 10)
								  Port Map(clk => clk, rst => rst, cen => ctrl, q => romMemAddress);
	
	memory : ROM Generic Map(nBitAddress => nBitAddress)
					Port Map(address => romMemAddress, dout => romOut);
end Architecture;
