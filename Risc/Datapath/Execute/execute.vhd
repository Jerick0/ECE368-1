----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:25:41 03/18/2015 
-- Design Name: 
-- Module Name:    execute - structural 
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

entity execute is
	generic(	addr_size	: integer:=8;			-- size of addressable memory
				num_bits		: integer:=16;			-- size of data
				num_ccr		: integer:= 4;			-- size of condition control register
				num_opcode	: integer:= 4);		-- size of op code
	
	port(	-- inputs
			op_a			: in std_logic_vector(num_bits-1 downto 0);	-- operand A
			op_b			: in std_logic_vector(num_bits-1 downto 0);	-- operand B
			
			-- outputs
			result			: out std_logic_vector(num_bits-1 downto 0);	-- result from ALU
			result_forward	: out std_logic_vector(num_bits-1 downto 0);	-- forwarded half clock cycle faster than result
			load				: out std_logic_vector(num_bits-1 downto 0);	-- result from a load operation
			load_forward	: out std_logic_vector(num_bits-1 downto 0);	-- forwarded half clock cycle faster than load
			ccr				: out std_logic_vector(num_ccr-1 downto 0);	-- ccr output
			
			-- control signals
			op_code		: in std_logic_vector(num_opcode-1 downto 0);	-- op code
			store_en		: in std_logic_vector(0 downto 0);					-- enable a store operation (enable ram to a write)
			rst			: in std_logic;											-- reset line
			clk			: in std_logic);											-- clock used to enable mux
			
end execute;

architecture structural of execute is
	signal operand_a	: std_logic_vector(num_bits-1 downto 0);		-- operand B input
	signal operand_b	: std_logic_vector(num_bits-1 downto 0);		-- operand A input
	signal data_out	: std_logic_vector(num_bits-1 downto 0);		-- data out of data memory
	signal ccr_out		: std_logic_vector(num_ccr-1 downto 0);		-- ccr output from ALU
	signal result_out	: std_logic_vector(num_bits-1 downto 0);		-- output from ALU
	signal read_clock	: std_logic;											-- rising edge read clock
	signal write_clock: std_logic;											-- falling edge write clock
	
begin
	operand_a		<= op_a;
	operand_b		<= op_b;
	load_forward	<= data_out;
	result_forward	<= result_out;
	write_clock 	<= not clk;						-- invert for block ram
	read_clock		<= clk;							

	alu_unit: entity work.alu
		port map( 	RA			=> operand_a,
						RB			=> operand_b,
						opcode	=> op_code,
						en			=> clk,
						ccr		=> ccr_out,
						alu_out	=> result_out);
	
	result_reg: entity work.GP_register
		port map(	clk		=> clk,
						rst		=> rst,
						D			=> result_out,
						Q			=> result);
	
	ccr_reg: entity work.GP_register
		generic map( num_bits => 4)
		port map(	clk		=> clk,
						rst		=> rst,
						D			=> ccr_out,
						Q			=> ccr);
	
	load_reg: entity work.GP_register
		port map(	clk		=> clk,
						rst		=> rst,
						D			=> data_out,
						Q			=> load);
	
	data_memory: entity work.data_mem
		port map(	clka		=> write_clock,
						wea		=> store_en,
						addra		=> operand_b(addr_size-1 downto 0),
						dina		=> operand_a,
						clkb		=> read_clock,
						addrb		=> operand_b(addr_size-1 downto 0),
						doutb		=> data_out);

end structural;

