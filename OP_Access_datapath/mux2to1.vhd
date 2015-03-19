----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:32:54 03/18/2015 
-- Design Name: 
-- Module Name:    mux2to1 - behavioral 
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

entity mux2to1 is
	generic(	num_bits		: integer:=16);
	
	port(	CLK 		: in  	STD_LOGIC;
			
			IN_1		: in		std_logic_vector(num_bits-1 downto 0);
			IN_2		: in 		std_logic_vector(num_bits-1 downto 0);
			O	 		: out  	STD_LOGIC_VECTOR(num_bits-1 downto 0);
			SEL 		: in 		std_logic_Vector(1 downto 0)
			);
			
end mux2to1;

architecture behavioral of mux2to1 is

begin

	Process(CLK)
		begin
		if (CLK'event and CLK='1') then
		 
				case SEL is
					when "00" =>O<=IN_1;
					when "10" =>O<=IN_2;
					when others =>O<=(others=>'0');
					
				end case;
		end if;

	end process;
end behavioral;

