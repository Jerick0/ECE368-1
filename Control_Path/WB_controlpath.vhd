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
           En_StoreData : out  STD_LOGIC;
           WB_mux : out  STD_LOGIC
			  );
end WB_controlpath;

architecture Behavioral of WB_controlpath is

begin


end Behavioral;

