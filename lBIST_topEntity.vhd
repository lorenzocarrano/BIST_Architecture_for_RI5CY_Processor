library ieee;
use ieee.std_logic_1164;
use ieee.numeric_std.all;

Entity lBist_topEntity is
	Generic
	(
		NbitMux: natural := 8;
		Npatterns : natural := 10
		NbitRomAddress: natural := 8;
	);
	Port
	(
		clk    : in  std_logic;
		rst    : in  std_logic;
		ctrl   : in  std_logic_vector(2 downto 0);
		PIs   : in  std_logic_vector(nScan -1 downto 0)
		TPG_out: out std_logic_vector(NbitMux -1 downto 0);
	);

end lBist_topEntity;

Architecture beh of lBist_topEntity is

	Component TPG is
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
	end Component;

	Component ODE is
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

	end Component;

	Component bistController is
		Generic
		(
			scanLength: natural:= 379;	
			nPatterns : natural:= 5000
		);
		Port
		( 
			START     : in std_logic;
			clock     : in std_logic;
			reset     : in std_logic; --active low
			ODE_out   : in std_logic; --go/nogo  in
			--counters signals
			cntScan   : in  unsigned(8 downto 0);
			cntPattern: in  unsigned(15 downto 0); 
			cntUpdScan: out std_logic;		 
			cntUpdPatt: out std_logic;	
			cntUpScan : out unsigned(8 downto 0);		 
			cntUpPatt : out unsigned(15 downto 0);
			cntPattEn : out std_logic;	 
			------------------
			validity  : out std_logic;
			clk_Out   : out std_logic;
			TPG_ctrl  : out std_logic_vector(2 downto 0);
			ODE_ctrl  : out std_logic;
			G_NGn     : out std_logic; --go/nogo  out
			N_Tn      : out std_logic --test/normal mode
		);  
	end Component;
	
begin

	

end Architecture;
