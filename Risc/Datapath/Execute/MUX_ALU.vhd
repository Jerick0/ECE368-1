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

entity MUX_ALU is
	generic( DATAPATH	: integer :=16);
	
	port(	OP				: in std_logic_vector(3 downto 0);					-- Op code
			ARITH			: in std_logic_vector(DATAPATH-1 downto 0);		-- output of arithmetic unit
			LOGIC			: in std_logic_vector(DATAPATH-1 downto 0);		-- output of logic unit
			SHIFT			: in std_logic_vector(DATAPATH-1 downto 0);		-- output of shift unit
			EN				: in std_logic;											-- Enable for mux
			regb			: in std_logic_vector(DataPath-1 downto 0);		-- register b for move command
			CCR_ARITH	: in std_logic_vector(3 downto 0);					-- ccr from arithmetic unit
			CCR_LOGIC	: in std_logic_vector(3 downto 0);					-- ccr from logic unit
			CCR_SHIFT	: in std_logic_vector(3 downto 0);					-- ccr from shift unit
			ALU_OUT		: out std_logic_vector(DATAPATH-1 downto 0);		-- output result from alu
			CCR_OUT		: out std_logic_vector(3 downto 0));				-- output ccr from alu
end MUX_ALU;

architecture COMBINATIONAL of MUX_ALU is

begin
	process(EN) begin

		if (EN'event and en='1') then
		
			case OP is
				when "0000" | "0001" | "0101" =>ALU_OUT<=ARITH;		-- Add, Sub, Add Immediate
				when "0010" | "0011" | "0110" =>ALU_OUT<=LOGIC;		-- And, Or, And Immediate
				when "0111" | "1000" =>ALU_OUT<=SHIFT;	 				-- Shift left and right 
				when others =>ALU_OUT<= regB;								-- Move and catch-all
				END CASE;
				
			case OP is
				when "0000" | "0001" | "0101" =>CCR_OUT<=CCR_ARITH;		-- Add, Sub, Add Immediate
				when "0010" | "0011" | "0110" =>CCR_OUT<=CCR_LOGIC;		-- And, Or, And Immediate
				when "0111" | "1000" =>CCR_OUT<= CCR_SHIFT;					-- Shift left and right
				when others =>CCR_OUT<=(others=>'0');							-- Move and catch-all
				END Case;
			end if;
	end process;
end COMBINATIONAL;

