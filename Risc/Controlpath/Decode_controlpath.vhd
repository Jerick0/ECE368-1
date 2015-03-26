----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Josh Erick
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
				D_instout	: out STD_LOGIC_VECTOR(15 downto 0);
				CLK			: in STD_LOGIC;
				NOTCLK		: in STD_LOGIC;
           in_mux_sel : out  STD_LOGIC;
			  Rst				: in STD_LOGIC);	
end Decode_controlpath;

architecture Behavioral of Decode_controlpath is
Signal DR_inst		: STD_LOGIC_VECTOR(15 downto 0);
Signal DF_inst		:  STD_LOGIC_VECTOR(15 downto 0);

begin

D_R		: entity work.GP_register
			Port Map ( 	CLK 	=> NotCLK,
							D   	=> D_inst,
							Q	 	=> DR_inst,
							Rst	=> RST							);
							
D_F		: entity work.GP_register
			Port Map (	CLK 	=> CLK,
							D		=> DR_inst,
							Q		=> DF_inst,
							RST	=> Rst
							);
D_instout <= DF_inst;

process(CLK)
begin
	if(CLK'event and CLK='0') then
		if((DR_inst(15 downto 12) = "0111") or (DR_inst(15 downto 12) = "1000")) then in_mux_sel <= '0'; -- Selects 4-bit Immediate
		else in_mux_sel <= '1'; -- Otherwise selects 8-bit Immediate
		end if;
	end if;
			
end process;
end Behavioral;

