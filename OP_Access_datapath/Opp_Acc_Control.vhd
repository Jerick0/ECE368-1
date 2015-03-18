----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:46:06 03/18/2015 
-- Design Name: 
-- Module Name:    Opp_Acc_Control - Behavioral 
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

entity Opp_Acc_Control is
    Port ( State_Instruction : in  STD_LOGIC;
           CNTLA_out : out  STD_LOGIC;
           CNTLB_out : out  STD_LOGIC);
end Opp_Acc_Control;

architecture Behavioral of Opp_Acc_Control is

begin


end Behavioral;

