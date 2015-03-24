----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:01:23 03/21/2015 
-- Design Name: 
-- Module Name:    rst_logic - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rst_logic is
    Port ( CLK 	: in  STD_LOGIC;
           OPCODE : in  STD_LOGIC_VECTOR (3 downto 0);
			  RESTART: out	STD_LOGIC;
           MO 		: out STD_LOGIC);
end rst_logic;

architecture Behavioral of rst_logic is

begin

	PROCESS(CLK)
	begin
	
		if(CLK'event and CLK = '1') then
			if(OPCODE = X"F") then
				RESTART <= '1';
				MO <= '0';
			elsif(OPCODE = X"A") then
				MO <= '1';
			else
				MO <= '0';
			end if;
		end if;
		
	end process;
			
end Behavioral;