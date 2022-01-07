library ieee;
use ieee.std_logic_1164;
use ieee.numeric_std.all;

Entity TPG is
	Generic
	(
		NbitMux: natural := 8;
		Npatterns : natural := 10;
		NbitRomAddress: natural := 8
	);
	Port
	(
		clk    : in  std_logic;
		rst    : in  std_logic;
		ctrl   : in  std_logic_vector(2 downto 0);
		PIs   : in  std_logic_vector(nScan -1 downto 0)
		TPG_out: out std_logic_vector(NbitMux -1 downto 0);
	);

end TPG;

Architecture beh of TPG is
	
	Component mux4to1 is
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

	end Component;
	
	Component lfsr is
		Port
		(
			clock: in std_logic;
			reset: in std_logic;
			seed : in std_logic_vector(7 downto 0)
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


	signal lfsrSeed : std_logic_vector(7 downto 0);
	signal lfsrOut, romOut : std_logic_vector(7 downto 0);
	signal romAddress : std_logic_vector(nBitRomAddress -1 downto 0);
	
begin

	lfsr_U : lfsr    Port Map(clock => clk, reset => rst, seed => romOut, q => lfsrOut);

	mux    : mux4to1 Generic Map(Nbit => NbitMux)
					   Port Map(A => (others => '0'), B => (others => '1'), C => lfsrOut, D => PIs, sel => ctrl(1 downto 0), Y => TPG_out);
	
	addrCnt: memAddressCounter Generic Map(N => NbitRomAddress)
								  Port Map(clk => clk, rst => rst, cen => ctrl(2), q => romAddress);
									
	seedMem: ROM Generic Map(nBitRomAddress => 16)
					Port Map(address => romAddress, dout => lfsrSeed);

end Architecture;
