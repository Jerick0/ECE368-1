----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:53:24 03/20/2015 
-- Design Name: 
-- Module Name:    instruction_bank - behavioral 
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

entity result_bank is
	generic(	num_bits			: integer:=16;			-- size of one word
				num_instruct	: integer:=20);		-- number of instructions
	
	port(	-- inputs
			result			: in std_logic_vector(num_bits-1 downto 0);	-- result to store
			read_ptr			: in std_logic;										-- read pointer
			clk				: in std_logic;
			
			-- outputs
			ss_result 		: out STD_LOGIC_VECTOR(num_bits-1 downto 0));
			
end result_bank;

architecture behavioral of result_bank is
	signal write_addr		: integer range 0 to num_instruct-1;					-- address to write results to
	signal read_addr		: integer range 0 to num_intsruct-1;					-- address to read results from
	
	type ram_type is array(0 to num_instruct-1) of std_logic_vector(num_bits-1 downto 0);
	signal ram				: ram_type;
	
	signal valid			: integer;
	
begin


end behavioral;

