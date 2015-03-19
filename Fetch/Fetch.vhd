----------------------------------------------------------------------------------
-- Company: University of Massachsusetts - Dartmouth
-- Engineer: Christopher J. Souza	
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
use work.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Fetch is
	Port ( CLK,RST : in STD_LOGIC;
			 IMM: OUT STD_LOGIC_VECTOR (3 downto 0);
			 RB: OUT STD_LOGIC_VECTOR (3 downto 0);
			 RA: OUT STD_LOGIC_VECTOR (3 downto 0);
			 OPCODE: OUT STD_LOGIC_VECTOR (3 downto 0));
end Fetch;

architecture Structural of Fetch is

	signal INSTR: STD_LOGIC_VECTOR (15 downto 0);
	signal PC_INDEX, INC_PC  : STD_LOGIC_VECTOR (13 downto 0);
	
begin
	PC: entity work.GP_register
	generic map (num_bits => 14)
	port map( CLK => CLK,
				 RST => RST,
				 D => INC_PC,
				 Q => PC_INDEX);
				 
	INC: entity work.Incrementer
	port map( D => PC_INDEX,
				 Q => INC_PC);
	
	INSTR_MEM: entity work.Instruction_Memory
	port map( clka => CLK,
				 addra => PC_INDEX,
				 douta => INSTR);
				 
	INSTRUCTION: entity work.GP_register
	port map( CLK => CLK,
				 RST => RST,
				 D => INSTR,
				 Q(15 downto 12)=> OPCODE,
				 Q(11 downto 8) => RA,
				 Q(7 downto 4) => RB,
				 Q(3 downto 0) => IMM);
				 
end Structural;

