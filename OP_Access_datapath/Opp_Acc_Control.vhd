----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:46:06 03/18/2015 
-- Design Name: 
-- Module Name:    Opp_Acc_Control - Behavioral 
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

-- MUXA
-- 000 -> Register A (Register Bank Value)
-- 001 -> Load Word Execute
-- 010 -> Write Back
-- 011 -> Register Register Execute
-- 100 -> Write Back + 1
-- 101 -> Unused
-- 110 -> Unused
-- 111 -> Unused

-- MUXB
-- 000 -> Immediate
-- 001 -> Register B (Register Bank Value)
-- 010 -> Load Word Execute 
-- 011 -> Write Back 
-- 100 -> Register Register Execute
-- 101 -> Write Back + 1
-- 110 -> Unused
-- 111 -> Unused

-- Instruction - Bit Reference
-- Bits 15 - 12: Opcode
-- Bits 11 -  8: Register A
-- Bits  7 -  4: Register B
-- Bits  3 -  0: Immediate

entity Opp_Acc_Control is
    Port ( OP_ACC, EXEC, WB, WBPLUS1 : in  STD_LOGIC_VECTOR (15 downto 0); -- Relevant Instructions from Instruction Register Bank
           CNTLA_out, CNTLB_out : out  STD_LOGIC_VECTOR (2 downto 0)); -- Control Lines for Operand Access Multiplexers
end Opp_Acc_Control;

architecture Behavioral of Opp_Acc_Control is

begin
	--MUX A - Control Logic
	if ((OP_ACC(11 downto 8) = EXEC(11 downto 8)) and (EXEC(15 downto 12) = '1001')) then CNTRLA_out <= '001'; -- Selects Load Word Execute
		
		elsif ((OP_ACC(11 downto 8) = WB(11 downto 8)) then CNTLA_out <= '011'; -- Selects Register Register Execute
		
		elsif ((OP_ACC(11 downto 8) = WB(11 downto 8))) then CNTLA_out <= '010'; -- Selects Write Back
	
		elsif (OP_ACC(11 downto 8) = WBPLUS1(11 downto 8) then CNTLA_out <= '100'; -- Selects Write Back + 1
	
		else CNTLB_out <= '000'; -- Selects Register B
		
	end
	-- MUX B - Control Logic
	if ((OP_ACC(15 downto 12) = '0101') | (OP_ACC(15 downto 12) = '0110') | (OP_ACC(15 downto 12) = '0111') | (OP_ACC(15 downto 12) = '1000') | 
	(OP_ACC(15 downto 12) = '1001') | (OP_ACC(15 downto 12) = '1010')) then CNTLB_out <= '000'; -- Selects Immediate
	
		elsif ((EXEC(15 downto 12) = '1001') and (OP_ACC(7 downto 4) = EXEC(11 downto 8))) then CNTLB_out <= '010'; -- Selects Load Word Execute
		
		elsif ((OP_ACC(7 downto 4) = WB(11 downto 8)) then CNTLB_out <= '100'; -- Selects Register Register Execute
		
		elsif ((OP_ACC(7 downto 4) = WB(11 downto 8))) then CNTLB_out <= '011'; -- Selects Write Back
	
		elsif (OP_ACC(7 downto 4) = WBPLUS1(11 downto 8) then CNTLB_out <= '101'; -- Selects Write Back + 1
	
		else CNTLB_out <= '001'; -- Selects Register B
	end

end Behavioral;

