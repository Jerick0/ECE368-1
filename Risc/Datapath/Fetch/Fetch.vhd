----------------------------------------------------------------------------------
-- Company: University of Massachsusetts - Dartmouth
-- Engineer: Christopher J. Souza/ Chris Camara	
-- 
-- Create Date:    14:11:33 03/18/2015 
-- Design Name: 
-- Module Name:    Fetch - Structural 
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
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Fetch is
	generic	(	inst_size			: integer := 16;
					inst_addr_size		: integer := 13);
					
	port		(	CLK,RST 			: in STD_LOGIC; --Clock and Reset
					IMM				: OUT STD_LOGIC_VECTOR (3 downto 0); --Immediate operand
					RB					: OUT STD_LOGIC_VECTOR (3 downto 0); -- Register B Address
					RA					: OUT STD_LOGIC_VECTOR (3 downto 0); -- Register A Address
					ProgC 			: OUT STD_LOGIC_VECTOR (inst_addr_size-1 downto 0);
					INST 				: OUT STD_LOGIC_VECTOR (inst_size-1 downto 0);
					IMM_branch		: OUT STD_LOGIC_VECTOR (3 downto 0); --Immediate operand
					RB_branch		: OUT STD_LOGIC_VECTOR (3 downto 0); -- Register B Address
					RA_branch		: OUT STD_LOGIC_VECTOR (3 downto 0); -- Register A Address
					INST_branch 	: OUT STD_LOGIC_VECTOR (inst_size-1 downto 0);-- Instruction
					push_notPop				:	in std_logic;
					push_notPop_branch	:	in std_logic;
					enable					:	in std_logic;
					enable_branch			:	in std_logic;
					merge						:	in std_logic;
					enable_merge			:	in std_logic;
					sel						:	in std_logic_vector(1 downto 0); 
					sel_branch				:	in std_logic_vector(2 downto 0));
end Fetch;

architecture Structural of Fetch is

	signal INSTR				: STD_LOGIC_VECTOR (inst_size-1 downto 0) := (others => '0'); -- Wires connecting Instruction Memory to Instruction Register
	signal INSTR_BRANCH		: STD_LOGIC_VECTOR (inst_size-1 downto 0) := (others => '0');
	signal PC_INDEX 			:	STD_LOGIC_VECTOR(inst_addr_size-1 downto 0):= (others => '0');
	signal INC_PC 				: STD_LOGIC_VECTOR (inst_addr_size-1 downto 0) := (others => '0');
	signal PC_INDEX_BRANCH, INC_PC_BRANCH	: STD_LOGIC_VECTOR(inst_addr_size-1 downto 0) := (others => '0');
	signal mux_pc, mux_pc_branch	:	STD_LOGIC_VECTOR(inst_addr_size-1 downto 0);
	signal stack_out			: std_logic_vector(inst_size-1 downto 0)	:= (others => '0');
	signal stack_out_branch	: std_logic_vector(inst_size-1 downto 0)	:= (others => '0');
	
	signal push_notPop_s			:	std_logic;
	signal push_notPop_branch_s:	std_logic;
	signal enable_s				:	std_logic;
	signal enable_branch_s		:	std_logic;
	signal merge_s					:	std_logic;
	signal enable_merge_s		:	std_logic;
	
	signal sel_s					:	std_logic_vector(1 downto 0);
	signal sel_branch_s			:	std_logic_vector(2 downto 0);
	signal JAL_s					: 	std_logic_vector(inst_addr_size-1 downto 0);
	signal JAL_branch_s			:	std_logic_vector(inst_addr_size-1 downto 0);
	signal branch_addr			:	std_logic_vector(inst_addr_size-1 downto 0);
	
begin
	INST 			<= INSTR; --Instruction output
	INST_BRANCH <= INSTR_BRANCH;
	ProgC 		<= PC_INDEX; -- Program Counter Output
	push_notPop_s			<= push_notPop;
	push_notPop_branch_s <= push_notPop_branch;
	enable_s				   <= enable;
	enable_branch_s		<= enable_branch;
	merge_s					<= merge;
	enable_merge_s		   <= enable_merge;
	sel_s						<= sel;
	sel_branch_s			<= sel_branch;
	
	JAL_s						<= '0' & INSTR(11 downto 0);
	JAL_branch_s			<= '0' & INSTR_BRANCH(11 downto 0);
	
	PC: entity work.GP_register -- Program Counter Register
	generic map (	num_bits => inst_addr_size)
	port map		( 	CLK 		=> CLK,
						RST 		=> RST,
						D 			=> MUX_PC,
						Q 			=> PC_INDEX);
						
	PC_BRANCH: entity work.GP_register -- Branch Program Counter Register
	generic map (	num_bits => inst_addr_size)
	port map		( 	CLK 		=> CLK,
						RST 		=> RST,
						D 			=> MUX_PC_BRANCH,
						Q 			=> PC_INDEX_BRANCH);
				 
 	INC: entity work.Incrementer -- Incrementer
	generic map (	inst_addr_size => inst_addr_size)
 	port map		(	D 					=> PC_INDEX,
						Q 					=> INC_PC);
	
	INC_branch: entity work.Incrementer -- Branch Incrementer
	generic map (	inst_addr_size => inst_addr_size)
 	port map		(	D 					=> PC_INDEX_BRANCH,
						Q 					=> INC_PC_BRANCH);
	
	INSTR_MEM: entity work.Instruction_Memory -- Block RAM for Instruction Memory
	port map(clka		=> CLK,
				wea(0) 	=> '0',
				addra		=> PC_INDEX,
				dina		=> (others => '0'),
				douta 	=> INSTR,
				clkb 		=> CLK,
				web(0) 	=> '0',
				addrb 	=> PC_INDEX_BRANCH,
				dinb 		=> (others => '0'),
				doutb		=>	INSTR_BRANCH);
				 
	INSTRUCTION: entity work.GP_register -- Instruction Register
	generic map	( 	num_bits 		=> 12)
	port map		( 	CLK 				=> CLK,
						RST 				=> RST,
						D 					=> INSTR (11 downto 0),
						Q(11 downto 8) => RA,
						Q(7 downto 4) 	=> RB,
						Q(3 downto 0) 	=> IMM);
	
	INSTRUCTION_BRANCH: entity work.GP_register -- BRANCH Instruction Register
	generic map	( 	num_bits 		=> 12)
	port map		( 	CLK 				=> CLK,
						RST 				=> RST,
						D 					=> INSTR_BRANCH (11 downto 0),
						Q(11 downto 8) => RA_BRANCH,
						Q(7 downto 4) 	=> RB_BRANCH,
						Q(3 downto 0) 	=> IMM_BRANCH);
	
	Branch_Inc: entity work.branch_incrementer	-- adds the immediate value to the pc for branching
	port map		(  pc_in		=> PC_INDEX_BRANCH,
						immediate=> INSTR_BRANCH(7 downto 0),
						pc_out	=> branch_addr);
	
	stack_fetch: entity work.stack		-- fetch stack
	port map		(	addr_in				=> INC_PC,
						addr_in_branch		=> INC_PC_BRANCH,
						addr_out				=> stack_out,
						addr_out_branch	=> stack_out_branch,
						clk					=> clk,
						rst					=> rst,
						push_notPop			=> push_notPop_s,
						push_notPop_branch=> push_notPop_branch_s,
						enable				=> enable_s,
						enable_branch		=> enable_branch_s,
						merge					=> merge_s,
						enable_merge		=> enable_merge_s);
						
	main_mux: entity work.mux_4to1
	generic map	( num_bits	=> inst_addr_size)
	port map		(	A		=>	INC_PC,
						B		=> JAL_s,
						C		=> stack_out,
						D		=> mux_pc_branch,
						SEL	=> sel_s,
						o		=> mux_pc,
						rst	=> rst);
	branch_mux: entity work.mux_5to1
	generic map	(	num_bits	=> inst_addr_size)
	port map		(	A		=> INC_PC_BRANCH,
						B		=> JAL_BRANCH_s,
						C		=> stack_out_branch,
						D		=> mux_pc,
						E		=> branch_addr,
						SEL	=> sel_branch_s,
						OUTP	=> mux_pc_branch,
						rst	=> rst);
	
end Structural;

