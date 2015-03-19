----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:19:58 03/18/2015 
-- Design Name: 
-- Module Name:    reg4bit - Behavioral 
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

entity reg4bit is
    Port ( IN : in  STD_LOGIC_VECTOR (3 downto 0);
			  EN : in  STD_LOGIC;
			  RST : in STD_LOGIC;
			  OUT : out STD_LOGIC_VECTOR (3 downto 0));
end reg4bit;

architecture Behavioral of reg4bit is


begin
	process(CLK, RST)
	begin
		if(RST = '1') then
			OUT <= '0000';
		elsif(CLK'event and CLK = '0') then
			OUT <= IN;
		end if
	end process;
end Behavioral;

