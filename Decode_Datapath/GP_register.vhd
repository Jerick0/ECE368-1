----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:22:38 03/17/2015 
-- Design Name: 
-- Module Name:    GP_register - Behavioral 
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

entity GP_register is
	generic(	num_bits		: integer:=16);
	
   port ( CLK 	: in  STD_LOGIC;
          RST 	: in  STD_LOGIC;
          D 	: in  STD_LOGIC_VECTOR(num_bits-1 downto 0);
          Q 	: out  STD_LOGIC_VECTOR(num_bits-1 downto 0));
end GP_register;

architecture Behavioral of GP_register is

begin

	Process(CLK, RST)
	begin
		if(RST = '1') then
			Q <= (others =>'0');
		elsif (CLK'event and CLK = '1') then
			Q <= D;
		end if;
	end process;
end Behavioral;

