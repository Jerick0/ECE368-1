----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:45:19 02/12/2015 
-- Design Name: 
-- Module Name:    Logic - Behavioral 
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
use IEEE.STD_LOGIC_SIGNED.ALL;

entity Logic is
	generic( DATAPATH	: integer :=16);
	
	port(	A			: in std_logic_vector(DATAPATH-1 downto 0);		-- First input
			B			: in std_logic_vector(DATAPATH-1 downto 0);		-- Second input
			OP			: in std_logic_vector(2 downto 0);		-- Op Code
			CCR		: out std_logic_vector(3 downto 0);		-- Condition code register
			RESULT	: out std_logic_vector(DATAPATH-1 downto 0));	-- Result of operation
end Logic;

architecture Behavioral of Logic is
	signal a1, b1	: std_logic_vector(DATAPATH-1 downto 0);	-- wire for A and B
	signal tmp 		: std_logic_vector(DATAPATH-1 downto 0);	-- wire for result
	
begin
	-- Need to connect A and B to wires
	a1 <= A;
	b1 <= B;
	
	with OP select tmp <=	
		a1 or  b1 when "011",		-- OR
		a1 and b1 when others;		-- AND or AND immediate
	
	-- checks sign bit: if 1, the flag is thrown
	CCR(3) <= tmp(DATAPATH-1);	

	-- checks to see if the result is zero
	CCR(2) <= '1' when tmp = x"00" else '0';
	
	-- reset overflow and carry flags
	CCR(1 downto 0) <= (others => '0');
	
	RESULT <= tmp;
end Behavioral;

