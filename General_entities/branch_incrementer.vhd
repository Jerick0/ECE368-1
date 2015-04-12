----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:37:36 04/12/2015 
-- Design Name: 
-- Module Name:    branch_incrementer - behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity branch_incrementer is
	generic(	pc_size			: integer := 13;
				immediate_size	: integer := 8);
				
	port(		-- inputs
				pc_in				: in std_logic_vector(pc_size-1 downto 0);
				immediate		: in std_logic_vector(immediate_size-1 downto 0);
				
				-- outputs
				pc_out			: out std_logic_vector(pc_size-1 downto 0));
end branch_incrementer;

architecture behavioral of branch_incrementer is
	signal pc_in_s			: std_logic_vector(pc_size-1 downto 0) := (others => '0');
	signal immediate_s	: std_logic_vector(pc_size-1 downto 0) := (others => '0');
	signal pc_out_s		: std_logic_vector(pc_size-1 downto 0) := (others => '0');
	signal ground			: std_logic_vector((pc_size-immediate_size)-1 downto 0);
	
begin
	ground		<= (others => '0');
	pc_in_s		<= pc_in;
	immediate_s	<= ground & immediate;
	pc_out		<= pc_out_s;

	pc_out_s		<= pc_in_s + immediate_s;
end behavioral;

