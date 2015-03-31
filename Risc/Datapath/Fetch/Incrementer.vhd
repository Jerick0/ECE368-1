----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:29:07 03/18/2015 
-- Design Name: 
-- Module Name:    Incrementer - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Incrementer is

	port( D : in STD_LOGIC_VECTOR(4 downto 0);
			Q : out STD_LOGIC_VECTOR(4 downto 0));
end Incrementer;

architecture Behavioral of Incrementer is
begin
	Q <= std_logic_vector(unsigned(D) + 1);
end Behavioral;

