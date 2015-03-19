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
				opcode_size		: integer:= 4);		-- number of bits to an op code
	
	port(	-- general inputs
			clk					: std_logic;												-- system clock
	
			-- fetch inputs
			
			-- decode inputs
			d_im_mux_sel		: std_logic;												-- immediate value mux selector
			
			-- operand access inputs
			o_opA_mux_sel		: std_logic_vector(2 downto 0);						-- operand a mux selector
			o_opB_mux_sel		: std_logic_vector(2 downto 0);						-- operand b mux selector
			
			-- execute inputs
			e_opcode				: std_logic_vector(opcode_size-1 downto 0);		-- op code used to select which
			e_sw_enable			: std_logic_vector(0 downto 0);						-- enables a store word instruction
			
			-- write back inputs
			wb_data_mux_sel	: std_logic;												-- selects between load and alu result to store to register bank
			wb_sd_enable		: std_logic_vector(0 downto 0);						-- enables store data to the register bank
			
			-- outputs
			instruction_fetch	: std_logic_vector(instruct_size-1 downto 0);
			wb_result			: std_logic_vector(num_bits-1 downto 0);
			store_result		: std_logic_vector(num_bits-1 downto 0));
			
end datapath;

architecture structural of datapath is

begin


end structural;

