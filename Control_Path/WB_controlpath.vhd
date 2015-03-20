----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:58:09 03/20/2015 
-- Design Name: 
-- Module Name:    WB_controlpath - Behavioral 
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

entity WB_controlpath is
    Port ( WB_inst : in  STD_LOGIC_Vector(15 downto 0);
           Reg_Aval : out  STD_LOGIC_Vector(3 downto 0);
           En_StoreData : out  STD_LOGIC_Vector(0 downto 0);
           WB_mux : out  STD_LOGIC
			  );
end WB_controlpath;

architecture Behavioral of WB_controlpath is

begin

	Reg_Aval <= WB_inst(11 downto 8);
	
	En_StoreData <= (others => '0') when WB_inst(15 downto 12) = "1010"
							else (others => '1');
	
	WB_mux <= '1' when WB_inst(15 downto 12) = "1001"
						else '0';




end Behavioral;

