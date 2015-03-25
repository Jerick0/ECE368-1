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

entity instruction_bank is
	generic(	instruct_size		: integer:=16;			-- size of one instruction
				num_instruct		: integer:=20);		-- number of instructions
	
	port(	-- inputs
			instruction		: in std_logic_vector(instruct_size-1 downto 0);
			scroll			: in std_logic;
			clk				: in std_logic;
			
			-- outputs
			LED 		: out STD_LOGIC_VECTOR (4 downto 0);
			SEG 		: out STD_LOGIC_VECTOR (6 downto 0);
			DP  		: out STD_LOGIC;
			AN  		: out STD_LOGIC_VECTOR (3 downto 0));
			
end instruction_bank;

architecture behavioral of instruction_bank is

begin


end behavioral;

