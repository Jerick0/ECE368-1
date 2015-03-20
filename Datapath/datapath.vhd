----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:53:58 03/19/2015 
-- Design Name: 
-- Module Name:    datapath - structural 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity datapath is
	generic(	num_bits			: integer:=16;			-- number of bits to a word
				instruct_size	: integer:=16;			-- size of an instruction
				immediate_L		: integer:=8;
				immediate_S		: integer:=4;
				ccr_size			: integer:=4;
				addr_size		: integer:= 4;			-- register bank addressing size
				opcode_size		: integer:= 4);		-- number of bits to an op code
	
	port(	-- general inputs
			clk					: in std_logic;												-- system clock
			rst					: in std_logic;												-- system reset
			
			-- fetch inputs
			
			-- decode inputs
			d_im_mux_sel		: in std_logic;												-- immediate value mux selector
			
			-- operand access inputs
			o_opA_mux_sel		: in std_logic_vector(2 downto 0);						-- operand a mux selector
			o_opB_mux_sel		: in std_logic_vector(2 downto 0);						-- operand b mux selector
			
			-- execute inputs
			e_opcode				: in std_logic_vector(opcode_size-1 downto 0);		-- op code used to select which
			e_sw_enable			: in std_logic_vector(0 downto 0);						-- enables a store word instruction
			
			-- write back inputs
			wb_data_mux_sel	: in std_logic;												-- selects between load and alu result to store to register bank
			wb_sd_enable		: in std_logic_vector(0 downto 0);						-- enables store data to the register bank
			wb_reg_addr			: in std_logic_vector(addr_size-1 downto 0);
			
			-- outputs
			instruction_fetch	: out std_logic_vector(instruct_size-1 downto 0);
			wb_result			: out std_logic_vector(num_bits-1 downto 0);
			store_result		: out std_logic_vector(num_bits-1 downto 0);
			store_offset		: out std_logic_vector(immediate_L-1 downto 0));
			
end datapath;

architecture structural of datapath is
	-- signals between fetch and decode
	signal opC_tmp	: std_logic_vector(addr_size-1 downto 0);
	signal reg_a	: std_logic_vector(addr_size-1 downto 0);
	signal reg_b	: std_logic_vector(addr_size-1 downto 0);
	signal im_S		: std_logic_vector(immediate_S-1 downto 0);
	signal im_L		: std_logic_vector(immediate_L-1 downto 0);
	
	-- signals bewteen decode and operand access
	signal result_reg_a		: std_logic_vector(num_bits-1 downto 0);
	signal result_reg_b		: std_logic_vector(num_bits-1 downto 0);
	signal result_im			: std_logic_vector(num_bits-1 downto 0);
	signal result_wbPlusOne	: std_logic_vector(num_bits-1 downto 0);
	
	-- signals forwarded to operand access
	--			should be four total forwarded results
	-- 		must include result_wbPlusOne and wb_data
	signal rr_ex	: std_logic_vector(num_bits-1 downto 0);
	signal lw_ex	: std_logic_vector(num_bits-1 downto 0);
	
	-- signals between operand access and execute
	signal operand_a	: std_logic_vector(num_bits-1 downto 0);
	signal operand_b	: std_logic_vector(num_bits-1 downto 0);
	
	-- signals between execute and writeback
	signal alu_out		: std_logic_vector(num_bits-1 downto 0);
	signal load_out	: std_logic_vector(num_bits-1 downto 0);
	signal ccr_tmp		: std_logic_vector(ccr_size-1 downto 0);
	
	-- signals between write back and decode
	--			Also needs to go to operand access
	signal wb_data	: std_logic_vector(num_bits-1 downto 0);

begin
	-- output signals
	wb_result 		<= wb_data;
	store_result	<= operand_a;
	store_offset	<= operand_b(immediate_L-1 downto 0);

	---------------------------------------------------------------
	-- fetch unit
	im_L	<= reg_b & im_S;		-- signal concat after fetch into decode
	
	fetch_unit: entity work.fetch
		port map(	clk				=> clk,
						rst				=> rst,
						imm				=> im_S,
						rb					=> reg_b,
						ra					=> reg_a,
						opcode			=> opC_tmp,
						inst				=> instruction_fetch);
	
	---------------------------------------------------------------
	-- decode unit
	decode_unit: entity work.decode
		port map(	addr_reg_a		=> reg_a,
						addr_reg_b		=> reg_b,
						immediate		=> im_L,
						store_addr		=> wb_reg_addr,
						store_data		=> wb_data,
						reg_a				=> result_reg_a,
						reg_b				=> result_reg_b,
						immediate_out	=> result_im,
						wbPlusOne		=> result_wbPlusOne,
						store_enable	=> wb_sd_enable,
						sel				=> d_im_mux_sel,
						rst				=> rst,
						clk				=> clk);
	
	---------------------------------------------------------------
	-- operand access unit
	opAccess_unit: entity work.opacc
		port map(	decode_reg		=> result_im,
						reg_b				=> result_reg_b,
						reg_a				=> result_reg_a,
						load_ex_f		=> lw_ex,
						wb_f				=> wb_data,
						rr_ex_f			=> rr_ex,
						wbplus1_f		=> result_wbPlusOne,
						cntl_a			=> o_opA_mux_sel,
						cntl_b			=> o_opB_mux_sel,
						clk				=> clk,
						op_a				=> operand_a,
						op_b				=> operand_b);
	
	---------------------------------------------------------------
	-- execute unit
	execute_unit: entity work.execute
		port map(	op_a				=> operand_a,
						op_b				=> operand_b,
						result			=> alu_out,
						result_forward	=> rr_ex,
						load				=> load_out,
						load_forward	=> lw_ex,
						ccr				=> ccr_tmp,
						op_code			=> e_opcode,
						store_en			=> e_sw_enable,
						rst				=> rst,
						clk				=> clk);						
	
	---------------------------------------------------------------
	-- write back unit
	writeback_unit: entity work.write_back
		port map(	alu_result		=> alu_out,
						load_result		=> load_out,
						writeback_out	=> wb_data,
						clk				=> clk,
						sel				=> wb_data_mux_sel);
	
end structural;

