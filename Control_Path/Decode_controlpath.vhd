----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:33:05 03/19/2015 
-- Design Name: 
-- Module Name:    Decode_controlpath - Behavioral 
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

-- Instruction - Bit Reference
-- Bits 15 - 12: Opcode
-- Bits 11 -  8: Register A
-- Bits  7 -  4: Register B
-- Bits  3 -  0: Immediate

-- MUX
--  0 -> 4-bit Immediate
--  1 -> 8-bit Immediate

entity Decode_controlpath is
    Port ( D_inst : in  STD_LOGIC_VECTOR(15 downto 0); --Decode Instruction
           in_mux_sel : out  STD_LOGIC);
end Decode_controlpath;

architecture Behavioral of Decode_controlpath is
begin
process(D_inst)
begin
	if((D_inst(15 downto 12) = "0111") or (D_inst(15 downto 12) = "1000")) then in_mux_sel <= '0'; -- Selects 4-bit Immediate
	else in_mux_sel <= '0'; -- Otherwise selects 8-bit Immediate
	end if;
end process;
end Behavioral;

