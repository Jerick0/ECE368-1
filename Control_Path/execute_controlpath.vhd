----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:55:52 03/20/2015 
-- Design Name: 
-- Module Name:    execute_controlpath - Behavioral 
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

entity execute_controlpath is
    Port ( E_inst : in  STD_LOGIC_Vector(15 downto 0);
           opcode : out  STD_LOGIC_Vector(3 downto 0);
           enable_SW : out  STD_LOGIC_Vector(0 downto 0)
			  );
end execute_controlpath;

architecture Behavioral of execute_controlpath is

begin
	
	opcode <= E_inst(15 downto 12);
	
	enable_SW <= (others=>'1') when E_inst(15 downto 12) = "1010"
					else (others=>'0');
				
			
	
end Behavioral;

