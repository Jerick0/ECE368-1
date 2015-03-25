----------------------------------------------------------------------------------
-- Company: University of Massachsusetts - Dartmouth
-- Engineer: Christopher J. Souza/ Chris Camara	
-- 
-- Create Date:    14:11:33 03/18/2015 
-- Design Name: 
-- Module Name:    Fetch - Structural 
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
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Fetch is
	Port ( CLK,RST : in STD_LOGIC; --Clock and Reset
			 IMM: OUT STD_LOGIC_VECTOR (3 downto 0); --Immediate operand
			 RB: OUT STD_LOGIC_VECTOR (3 downto 0); -- Register B Address
			 RA: OUT STD_LOGIC_VECTOR (3 downto 0); -- Register A Address
			 ProgC : OUT STD_LOGIC_VECTOR (13 downto 0);
			 INST : OUT STD_LOGIC_VECTOR (15 downto 0)); -- Instruction
end Fetch;

architecture Structural of Fetch is

	signal INSTR: STD_LOGIC_VECTOR (15 downto 0) := (others => '0'); -- Wires connecting Instruction Memory to Instruction Register
	signal PC_INDEX, INC_PC  : STD_LOGIC_VECTOR (13 downto 0) := (others => '0');
	
begin
	INST <= INSTR; --Instruction output
	ProgC <= PC_INDEX; -- Program Counter Output
	
	PC: entity work.GP_register -- Program Counter Register
	generic map (num_bits => 14)
	port map( CLK => CLK,
				 RST => RST,
				 D => INC_PC,
				 Q => PC_INDEX);
				 
 	INC: entity work.Incrementer -- Incrementer
 	port map( D => PC_INDEX,
				 Q => INC_PC);
	
	INSTR_MEM: entity work.Instruction_Memory -- Block ROM for Instruction Memory
	port map( clka => CLK,
				 addra => PC_INDEX,
				 douta => INSTR);
				 
	INSTRUCTION: entity work.GP_register -- Instruction Register
	generic map( num_bits => 12)
	port map( CLK => CLK,
				 RST => RST,
				 D => INSTR (11 downto 0),
				 Q(11 downto 8) => RA,
				 Q(7 downto 4) => RB,
				 Q(3 downto 0) => IMM);
				 
end Structural;

