Component riscv_core_scan is
	Port(
		boot_addr_i : in std_logic_vector(31 downto 0);
		core_id_i : in std_logic_vector(3 downto 0);
		cluster_id_i : in std_logic_vector(5 downto 0);
		instr_addr_o : out std_logic_vector(31 downto 0);
		instr_rdata_i : in std_logic_vector(127 downto 0);
		data_be_o : out std_logic_vector(3 downto 0);
		data_addr_o : out std_logic_vector(31 downto 0);
		data_wdata_o : out std_logic_vector(31 downto 0);
		data_rdata_i : in std_logic_vector(31 downto 0);
		apu_master_operands_o : out std_logic_vector(95 downto 0);
		apu_master_op_o : out std_logic_vector(31 downto 0);
		apu_master_type_o : out std_logic_vector(1 to 2);
		apu_master_flags_o : out std_logic_vector(14 downto 0);
		apu_master_result_i : in std_logic_vector(31 downto 0);
		apu_master_flags_i : in std_logic_vector(4 downto 0);
		irq_id_i : in std_logic_vector(4 downto 0);
		irq_id_o : out std_logic_vector(4 downto 0);
		ext_perf_counters_i : in std_logic_vector(1 to 2);

		clk_i : in std_logic;
		rst_ni : in std_logic;
		lock_en_i : in std_logic;
		test_en_i : in std_logic; 
		fregfile_disable_i : in std_logic; 
		instr_gnt_i : in std_logic;
			 instr_rvalid_i : in std_logic;
		ata_gnt_i : in std_logic; 
		data_rvalid_i, 
		apu_master_gnt_i : in std_logic;
			 apu_master_valid_i : in std_logic; 
		irq_i, irq_sec_i : in std_logic;
		debug_req_i : in std_logic;
		fetch_enable_i : in std_logic;
			 test_si1 : in std_logic;
		test_si2 : in std_logic;
		test_si3 : in std_logic;
		test_si4 : in std_logic; 
		test_si5 : in std_logic; 
		test_si6 : in std_logic; 
		test_si7 : in std_logic;
		
		test_si8 : in std_logic; 
		test_mode : in std_logic;

		 instr_req_o, data_req_o, data_we_o, apu_master_req_o,
		 apu_master_ready_o, irq_ack_o, sec_lvl_o, core_busy_o, test_so1,
		 test_so2, test_so3, test_so4, test_so5, test_so6, test_so7, test_so8 : out std_logic
	);
end Component;
