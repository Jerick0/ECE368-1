----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Chris Souza/ Josh Erick
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

    Port ( O_inst, EXEC, WB, WBPLUS1 	: in  STD_LOGIC_VECTOR (15 downto 0); -- Relevant Instructions from Instruction Register Bank
           PC								 	: in  STD_LOGIC_VECTOR (4 downto 0);
			  CLK									: in	STD_LOGIC;
			  notCLK								: in 	STD_LOGIC;
			  O_instout							: out STD_LOGIC_VECTOR (15 downto 0);
			  CNTLA_out, CNTLB_out 		 	: out STD_LOGIC_VECTOR (2 downto 0); -- Control Lines for Operand Access Multiplexers
				RST								: in STD_LOGIC);
end Opp_Acc_Control;

architecture Behavioral of Opp_Acc_Control is

signal OR_inst : STD_LOGIC_VECTOR(15 downto 0);
signal OF_inst : STD_LOGIC_VECTOr(15 downto 0);
signal delay_pc: std_logic_vector(4 downto 0);
begin

O_R		: entity work.GP_register
			Port Map ( 	CLK 	=> CLK,
							D   	=> O_inst,
							Q	 	=> OR_inst,
							Rst	=> RST
							);
							
O_F		: entity work.GP_register
			Port Map (	CLK 	=> NotCLK,
							D		=> OR_inst,
							Q		=> OF_INST,
							RST	=> RST
							);
							
O_instout <= OF_inst;
 
PC_Delay	: entity work.GP_register
			generic map( num_bits => 5)
			port map	(	clk	=>notclk,
							D		=> PC,
							Q		=> delay_PC,
							rst	=> rst);
--process (CLK)
process(O_inst, EXEC, WB, WBPLUS1)
	begin
	--if (CLK'event and CLK ='1')then
		if(delay_PC = "00010") then -- First Time an Instruction Enters Operand Access	
			CNTLA_out <= "000";
			if ((OF_inst(15 downto 12) = "0101") or (OF_inst(15 downto 12) = "0110") or (OF_inst(15 downto 12) = "0111") or (OF_inst(15 downto 12) = "1000") or 
			(OF_inst(15 downto 12) = "1001") or (OF_inst(15 downto 12) = "1010")) then CNTLB_out <= "000"; -- Selects Immediate
			else CNTLB_out <= "001";
			end if;
		elsif(delay_PC = "00011")  then -- 2nd Time an Instruction Enters Operand Access
			--MUX A
			if ((EXEC(15 downto 12) = "1001") and (OF_inst(11 downto 8) = EXEC(11 downto 8)) and (EXEC(15 downto 12) /= "1010")) then CNTLA_out <= "001"; -- Selects Load Word Execute
				
			elsif ((OF_inst(11 downto 8) = EXEC(11 downto 8)) and (EXEC(15 downto 12) /= "1010")) then CNTLA_out <= "011"; -- Selects Register Register Execute
			
			else CNTLA_out <= "000"; -- Selects Register A
			end if;
			--MUX B
			if ((OF_inst(15 downto 12) = "0101") or (OF_inst(15 downto 12) = "0110") or (OF_inst(15 downto 12) = "0111") or (OF_inst(15 downto 12) = "1000") or 
			(OF_inst(15 downto 12) = "1001") or (OF_inst(15 downto 12) = "1010")) then CNTLB_out <= "000"; -- Selects Immediate
			
			elsif ((EXEC(15 downto 12) = "1001") and (OF_inst(7 downto 4) = EXEC(11 downto 8)) and (EXEC(15 downto 12) /= "1010")) then CNTLB_out <= "010"; -- Selects Load Word Execute
				
			elsif ((OF_inst(7 downto 4) = EXEC(11 downto 8))and (EXEC(15 downto 12) /= "1010")) then CNTLB_out <= "100"; -- Selects Register Register Execut
			
			else CNTLB_out <= "001";
			end if;
		elsif(delay_PC = "00100") 	then --Third Time an Instruction Enters Operand Access
			--MUX A
			if (((EXEC(15 downto 12) = "1001") and (OF_inst(11 downto 8) = EXEC(11 downto 8))) and (EXEC(15 downto 12) /= "1010")) then CNTLA_out <= "001"; -- Selects Load Word Execute
				
			elsif ((OF_inst(11 downto 8) = EXEC(11 downto 8)) and (EXEC(15 downto 12) /= "1010")) then CNTLA_out <= "011"; -- Selects Register Register Execute
			
			elsif ((OF_inst(11 downto 8) = WB(11 downto 8)) and (WB(15 downto 12) /= "1010"))  then CNTLA_out <= "010"; -- Selects Write Back
			
			else CNTLA_out <= "000"; -- Selects Register A
			end if;
			--MUX B
			if ((OF_inst(15 downto 12) = "0101") or (OF_inst(15 downto 12) = "0110") or (OF_inst(15 downto 12) = "0111") or (OF_inst(15 downto 12) = "1000") or 
			(OF_inst(15 downto 12) = "1001") or (OF_inst(15 downto 12) = "1010")) then CNTLB_out <= "000"; -- Selects Immediate
			
			elsif ((EXEC(15 downto 12) = "1001" and OF_inst(7 downto 4) = EXEC(11 downto 8)) and (EXEC(15 downto 12) /= "1010")) then CNTLB_out <= "010"; -- Selects Load Word Execute
				
			elsif ((OF_inst(7 downto 4) = EXEC(11 downto 8)) and (EXEC(15 downto 12) /= "1010")) then CNTLB_out <= "100"; -- Selects Register Register Execut
			
			-- changed line to WB instead of WBPlus1 and CNTLB_out from "101"
			elsif ((OF_inst(7 downto 4) = WB(11 downto 8)) and (WB(15 downto 12) /= "1010")) then CNTLB_out <= "011"; -- Selects Write Back + 1
			
			else CNTLB_out <= "001";
			end if;
		else -- For all other instructions, like when the machine is running normally
		--MUX A - Control Logic
			if (((EXEC(15 downto 12) = "1001") and (OF_inst(11 downto 8) = EXEC(11 downto 8))) and (EXEC(15 downto 12) /= "1010")) then CNTLA_out <= "001"; -- Selects Load Word Execute
				
			elsif ((OF_inst(11 downto 8) = EXEC(11 downto 8)) and (EXEC(15 downto 12) /= "1010"))  then CNTLA_out <= "011"; -- Selects Register Register Execute
				
			elsif ((OF_inst(11 downto 8) = WB(11 downto 8)) and (WB(15 downto 12) /= "1010")) then CNTLA_out <= "010"; -- Selects Write Back
			
			elsif ((OF_inst(11 downto 8) = WBPLUS1(11 downto 8))  and (WBPLUS1(15 downto 12) /= "1010"))  then CNTLA_out <= "100"; -- Selects Write Back + 1
			
			else CNTLA_out <= "000"; -- Selects Register A
				
			end if;
			-- MUX B - Control Logic
			if ((OF_inst(15 downto 12) = "0101") or (OF_inst(15 downto 12) = "0110") or (OF_inst(15 downto 12) = "0111") or (OF_inst(15 downto 12) = "1000") or 
			(OF_inst(15 downto 12) = "1001") or (OF_inst(15 downto 12) = "1010")) then CNTLB_out <= "000"; -- Selects Immediate
			
			elsif ((EXEC(15 downto 12) = "1001" and OF_inst(7 downto 4) = EXEC(11 downto 8)) and (EXEC(15 downto 12) /= "1010")) then CNTLB_out <= "010"; -- Selects Load Word Execute
				
			elsif ((OF_inst(7 downto 4) = EXEC(11 downto 8))  and (EXEC(15 downto 12) /= "1010")) then CNTLB_out <= "100"; -- Selects Register Register Execute
				
			elsif ((OF_inst(7 downto 4) = WB(11 downto 8)) and (WB(15 downto 12) /= "1010")) then CNTLB_out <= "011"; -- Selects Write Back
			
			elsif ((OF_inst(7 downto 4) = WBPLUS1(11 downto 8))  and (WBPLUS1(15 downto 12) /= "1010")) then CNTLB_out <= "101"; -- Selects Write Back + 1
			
			else CNTLB_out <= "001"; -- Selects Register B
			end if;
		end if;
	--end if;
end process;
end Behavioral;

