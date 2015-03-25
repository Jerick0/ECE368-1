----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:37:18 03/24/2015 
-- Design Name: 
-- Module Name:    datapath_tb - structural 
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

entity datapath_tb is
	port(	clk					: in std_logic;
			d_im_mux_sel		: in std_logic;
			o_opA_mux_sel		: in std_logic_vector(2 downto 0);
			o_opB_mux_sel		: in std_logic_vector(2 downto 0);
			e_opcode				: in std_logic_vector(3 downto 0);
			e_sw_enable			: in std_logic_vector(0 downto 0);
			wb_data_mux_sel	: in std_logic;
			wb_sd_enable		: in std_logic_vector(0 downto 0);
			wb_reg_addr			: in std_logic_vector(3 downto 0);
			pc						: out std_logic_vector(13 downto 0);
			instruction_fetch	: out std_logic_vector(15 downto 0);
			wb_result			: out std_logic_vector(15 downto 0);
			ccr_result			: out std_logic_vector(3 downto 0);
			store_result		: out std_logic_vector(15 downto 0);
			store_offset		: out std_logic_vector(7 downto 0));
end datapath_tb;

architecture structural of datapath_tb is
	signal rst_line	: std_logic;
begin
	rst_unit: entity work.system_reset
		port map(	clk	=> clk,
						rst	=> rst_line);
						
	datapath_unit: entity work.datapath
		port map(	clk					=> clk,
						rst					=> rst_line,
						d_im_mux_sel		=> d_im_mux_sel,
						o_opA_mux_sel		=> o_opA_mux_sel,
						o_opB_mux_sel		=> o_opB_mux_sel,
						e_opcode				=> e_opcode,
						e_sw_enable			=> e_sw_enable,
						wb_data_mux_sel	=> wb_data_mux_sel,
						wb_sd_enable		=> wb_sd_enable,
						wb_reg_addr			=> wb_reg_addr,
						pc						=> pc,
						instruction_fetch	=> instruction_fetch,
						wb_result			=> wb_result,
						ccr_result			=> ccr_result,
						store_result		=> store_result,
						store_offset		=> store_offset);

end structural;

