----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:24:01 03/19/2015 
-- Design Name: 
-- Module Name:    Instruction_bank - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruction_bank is
		port( fetch_instruction : in STD_LOGIC_VECTOR(15 downto 0);
				D_inst				: out STD_LOGIC_VECTOR(15 downto 0);
				O_inst				: out STD_LOGIC_VECTOR(15 downto 0);
				E_inst				: out STD_LOGIC_VECTOR(15 downto 0);
				W_inst				: out STD_LOGIC_VECTOR(15 downto 0);				
				
end Instruction_bank;

architecture Behavioral of Instruction_bank is

begin



end Behavioral;

