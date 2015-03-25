----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:10:36 03/24/2015 
-- Design Name: 
-- Module Name:    system_reset - behavioral 
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity system_reset is
	port(	clk	:	in std_logic;
			rst	:	out std_logic);
end system_reset;

architecture behavioral of system_reset is
	signal count	: std_logic_vector(0 to 5) := (others => '0');
	
begin
	process (clk)
	begin
		if(clk'event and clk = '1') then
			if(count < "10101") then
				count <= count + 1;
				rst <= '1';
			else
				rst <= '0';
			end if;
		end if;
	end process;
	
end behavioral;

