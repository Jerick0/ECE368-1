----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:22:04 02/11/2015 
-- Design Name: 
-- Module Name:    Arith - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

-- arithmetic unit of alu
-- this arithmetic unit uses signed numbers
entity Arith is
	generic( DATAPATH	: integer :=16);
	
	port(	A		: in std_logic_vector(DATAPATH-1 downto 0);		-- First input
			B		: in std_logic_vector(DATAPATH-1 downto 0);		-- Second input
			OP		: in std_logic_vector(2 downto 0);		-- Op Code
			CCR		: out std_logic_vector(3 downto 0);		-- Condition code register
			RESULT	: out std_logic_vector(DATAPATH-1 downto 0));	-- Result of operation
end Arith;

architecture Behavioral of Arith is

	signal a1, b1	: std_logic_vector(DATAPATH downto 0);	-- wire for A and B
	signal tmp 		: std_logic_vector(DATAPATH downto 0);	-- store the result of operation
		-- These must be 9 bits long to check for overflow and carry
	
begin
	-- Need to connect ports to signals because they are unstable by themselves
	a1 <= '0' & A;
	b1 <= '0' & B;

	with OP select tmp <=
		a1 - b1 when "001",		-- Subtract
		a1 + b1 when others;		-- Add and Add Immediate
	
	-- checks sign bit: if 1, the flag is thrown
	CCR(3) <= tmp(DATAPATH-1);	

	-- checks to see if the result is zero
	CCR(2) <= '1' when tmp(DATAPATH-1 downto 0) = x"00" else '0';	
					  
	-- checks to see over there is overflow
	-- if both numbers are positive and the result is negative
	-- if both numbesr are negative and the result is positive
	-- explanation found at this link - http://www.cs.umd.edu/class/sum2003/cmsc311/Notes/Comb/overflow.html
	CCR(1) <= tmp(DATAPATH) xor tmp(DATAPATH-1);
	
	-- checks to see if there is a carry out
	-- if there is 1 in the additional spot of the temporary results
	CCR(0) <= tmp(DATAPATH);

	RESULT <= tmp(DATAPATH-1 downto 0);
end Behavioral;

