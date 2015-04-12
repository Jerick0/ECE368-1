----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Chris Camara
-- 
-- Create Date:    18:36:03 03/18/2015 
-- Design Name: 
-- Module Name:    write_back - structural 
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

entity write_back is
	generic(	num_bits		: integer:=16;
				addr_size	: integer:=8);
	
	port(	-- inputs
			alu_result		: in std_logic_vector(num_bits-1 downto 0);	-- result from the alu
			load_result		: in std_logic_vector(num_bits-1 downto 0);	-- result from a load operation
			store_data		: in std_logic_vector(num_bits-1 downto 0);
			store_addr		: in std_logic_vector(addr_size-1 downto 0);
			
			-- outputs
			writeback_out	: out std_logic_vector(num_bits-1 downto 0);	-- output to write to register bank
			store_data_out	: out std_logic_vector(num_bits-1 downto 0);
			store_addr_out	: out std_logic_vector(addr_size-1 downto 0);
			
			-- control
			clk				: in std_logic;			-- system clock
			rst				: in std_logic;
			sel				: in std_logic);			-- select line
end write_back;

architecture structural of write_back is
	signal o				: std_logic_vector(num_bits-1 downto 0);		-- wire to output
	signal input_alu	: std_logic_vector(num_bits-1 downto 0);		-- input wire from alu
	signal input_load	: std_logic_vector(num_bits-1	downto 0);		-- input wire from load
	signal notClk		: std_logic;
	
begin
	writeback_out 	<= o;
	input_alu		<= alu_result;
	input_load		<= load_result;
	notClk			<= not clk;
	
	writeback_mux: entity work.mux2to1
		port map( 	clk	=> clk,
						in_1	=> input_alu,
						in_2	=> input_load,
						o		=> o,
						sel	=> sel,
						rst	=> rst);
	
	store_data_reg: entity work.GP_register
		port map(	clk	=> notclk,
						rst	=> rst,
						D		=> store_data,
						Q		=> store_data_out);
						
	store_addr_reg: entity work.GP_register
		generic map(num_bits	=> 8)
		port map(	clk		=> notclk,
						rst		=> rst,
						D			=> store_addr,
						Q			=> store_addr_out);
						
end structural;

