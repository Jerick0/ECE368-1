---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Daniel Noyes
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Button Controller
-- Project Name:   Button Controller
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description: Switch Controller
--  Maintain input from the four buttons on Nexys
--  Built in debouncer for buttons
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity buttoncontrol is
    Port ( CLK    : in  STD_LOGIC;
           B_O  	: in  STD_LOGIC;
           DEB		: out STD_LOGIC);
end buttoncontrol;

architecture Structural of buttoncontrol is

begin

    ----- Structural Components: -----
    BTN: entity work.debounce
    port map( CLK    => CLK,
              INPUT  => B_O,
              OUTPUT => DEB);    
    ----- End Structural Components -----

end Structural;
