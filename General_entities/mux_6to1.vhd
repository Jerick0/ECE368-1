----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Josh Erick
-- 
-- Create Date:    15:35:19 03/18/2015 
-- Design Name: 
-- Module Name:    mux_6to1 - Behavioral 
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

entity mux_6to1 is
    Port ( A 		: in  STD_LOGIC_Vector(15 downto 0);
           B 		: in  STD_LOGIC_Vector(15 downto 0);
           C 		: in  STD_LOGIC_Vector(15 downto 0);
           D 		: in  STD_LOGIC_Vector(15 downto 0);
           E 		: in  STD_LOGIC_Vector(15 downto 0);
           F 		: in  STD_LOGIC_Vector(15 downto 0);          
			  SEL 	: in  STD_LOGIC_Vector(2 downto 0);
			  CLK 	: in 	STD_LOGIC;
           O 	: out  STD_LOGIC_Vector(15 downto 0)
			  );
end mux_6to1;

architecture Combinational of mux_6to1 is

begin
	process(CLK) 
	begin
 
			if (CLK'event and CLK='1') then
		
				case SEL is
					when "000" =>O<=A;		
					when "001" =>O<=B;		
					when "010" =>O<=C;
					when "011" =>O<=D;
					when "100" =>O<=E;
					when "101" =>O<=F;
					when others =>O<=B;								
					END CASE;
				
			end if;
	end process;
 end COMBINATIONAL;





