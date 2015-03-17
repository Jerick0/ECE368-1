----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:32:31 02/12/2015 
-- Design Name: 
-- Module Name:    MUX_ALU - COMBINATIONAL 
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
use work.RISCCONSTANTS_PKG.all;

entity MUX_ALU is
	port(	OP				: in std_logic_vector(3 downto 0);		-- Op code
			ARITH			: in std_logic_vector(DATAPATH-1 downto 0);		-- output of arithmetic unit
			LOGIC			: in std_logic_vector(DATAPATH-1 downto 0);		-- output of logic unit
			SHIFT			: in std_logic_vector(DATAPATH-1 downto 0);		-- output of shift unit
			-- MEMORY
			CCR_ARITH	: in std_logic_vector(3 downto 0);		-- ccr from arithmetic unit
			CCR_LOGIC	: in std_logic_vector(3 downto 0);		-- ccr from logic unit
			CCR_SHIFT	: in std_logic_vector(3 downto 0);		-- ccr from shift unit
			ALU_OUT		: out std_logic_vector(DATAPATH-1 downto 0);		-- output result from alu
			CCR_OUT		: out std_logic_vector(3 downto 0));	-- output ccr from alu
end MUX_ALU;

architecture COMBINATIONAL of MUX_ALU is

begin
	with OP select ALU_OUT <=
		ARITH when "0000" | "0001" | "0101",	-- Add, Sub, Add Immediate
		LOGIC when "0010" | "0011" | "0110",	-- And, Or, And Immediate
		SHIFT when others;							-- Shift left and right and catch all
		
	with OP select CCR_OUT <=
		CCR_ARITH when "0000" | "0001" | "0101",	-- Add, Sub, Add Immediate
		CCR_LOGIC when "0010" | "0011" | "0110",	-- And, Or, And Immediate
		CCR_SHIFT when others;							-- Shift left and right and catch all

end COMBINATIONAL;

