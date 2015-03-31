----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Chris Camara
-- 
-- Create Date:    14:28:25 03/19/2015 
-- Design Name: 
-- Module Name:    decode - structural 
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

entity decode is
	generic( num_bits		: integer:=16;		-- number of bits in a word
				addr_size	: integer:=4;		-- addressing size of register bank
				immediate_L	: integer:=8;		-- 8 bit immediate value, used for addressing data memory/andi & addi instrucitons
				immediate_S	: integer:=4);		-- 4 bit immediate value, used for shifting
	
	port(	-- inputs for decode
			addr_reg_a		: in std_logic_vector(addr_size-1 downto 0);		-- register bank address for operand a
			addr_reg_b		: in std_logic_vector(addr_size-1 downto 0);		-- register bank address for operand b
			immediate		: in std_logic_vector(immediate_L-1 downto 0);	-- immediate 8 bit value to be taken in, break up into separate immediate values
			
			-- inputs for writeback (the trailing edge of write back occurs in decode block)
			--			inputs for write back will occur on falling edge of clock
			store_addr		: in std_logic_vector(addr_size-1 downto 0);		-- address to store data into register bank from write back
			store_data		: in std_logic_vector(num_bits-1 downto 0);		-- the data to be stored into register bank from writeback
			
			-- outputs
			reg_a				: out std_logic_vector(num_bits-1 downto 0);		-- value read from register bank for operand a
			reg_b				: out std_logic_vector(num_bits-1 downto 0);		-- value read from register bank for operand b
			immediate_out	: out std_logic_vector(num_bits-1 downto 0);		-- immediate value needed for opcode (or garbage value)
			wbPlusOne		: out std_logic_vector(num_bits-1 downto 0);		-- forwarded value provided to operand access
			
			-- control signals
			store_enable	: in std_logic_vector(0 downto 0);					-- enable a store (disabled on a store word instruction
			sel				: in std_logic;											-- selector for decode mux of immediate values
			rst				: in std_logic;											-- reset line
			clk				: in std_logic);											-- system clock
end decode;

architecture structural of decode is
	-- immediate values
	signal immediate_8	: std_logic_vector(immediate_L-1 downto 0) := (others => '0');		-- eight bit immediate value from input immediate
	signal immediate_4	: std_logic_vector(immediate_L-1 downto 0) := (others => '0');		-- four bit immediate value from input
	signal im_mux			: std_logic_vector(immediate_L-1 downto 0) := (others => '0');		-- output of immediate mux to immediate register

	-- register bank outputs
	signal reg_a_tmp		: std_logic_vector(num_bits-1 downto 0) := (others => '0');			-- value read out of register bank to store in register A
	signal reg_b_tmp		: std_logic_vector(num_bits-1 downto 0) := (others => '0');			-- value read out of register bank to store in register B

begin
	-- connect immediate values to grab different possibilities
	immediate_8 <= immediate;
	immediate_4 <= "0000" & immediate(immediate_S-1 downto 0);			-- switched order of small immediate values
	immediate_out(num_bits-1 downto immediate_L)	<= "00000000";
	
	register_bank: entity work.reg_bank
		port map(	reg_a_addr		=> addr_reg_a,
						reg_b_addr		=> addr_reg_b,
						write_addr		=> store_addr,
						data_in			=> store_data,
						reg_a				=> reg_a_tmp,
						reg_b				=> reg_b_tmp,
						w_en				=> store_enable,
						clk				=> clk,
						rst				=> rst);
	
	decode_mux:	entity work.mux2to1
		generic map(num_bits			=> immediate_L)
		port map(	clk				=> clk,
						in_1				=> immediate_4,		-- switched immediate values around to match control path logic
						in_2				=> immediate_8,
						o					=> im_mux,
						sel				=> sel,
						rst				=> rst);
	
	register_mux: entity work.GP_register
		generic map(num_bits			=> immediate_L)
		port map(	clk				=> clk,
						rst				=> rst,
						D					=> im_mux,
						Q					=> immediate_out(immediate_L-1 downto 0));
	
	register_a: entity work.GP_register
		port map(	clk				=> clk,
						rst				=> rst,
						D					=> reg_a_tmp,
						Q					=> reg_a);
						
	register_b: entity work.GP_register
		port map(	clk				=> clk,
						rst				=> rst,
						D					=> reg_b_tmp,
						Q					=> reg_b);
						
	register_wbp1:	entity work.GP_register
		port map(	clk				=> clk,
						rst				=> rst,
						D					=> store_data,
						Q					=> wbPlusOne);
end structural;

