----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:35:19 03/18/2015 
-- Design Name: 
-- Module Name:    mux_7to1 - Behavioral 
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

entity mux_7to1 is
    Port ( A 		: in  STD_LOGIC_Vector(15 downto 0);
           B 		: in  STD_LOGIC_Vector(15 downto 0);
           C 		: in  STD_LOGIC_Vector(15 downto 0);
           D 		: in  STD_LOGIC_Vector(15 downto 0);
           E 		: in  STD_LOGIC_Vector(15 downto 0);
           F 		: in  STD_LOGIC_Vector(15 downto 0);
           G 		: in  STD_LOGIC_Vector(15 downto 0);
           SEL 	: in  STD_LOGIC_Vector(2 downto 0);
			  EN 		: in 	STD_LOGIC;
           OUTP 	: out  STD_LOGIC_Vector(15 downto 0)
			  );
end mux_7to1;

architecture Combinational of mux_7to1 is

begin
	process(EN) 
	begin
 
			if (EN'event and en='1') then
		
				case SEL is
					when "000" =>OUTP<=A;		
					when "001" =>OUTP<=B;		
					when "010" =>OUTP<=C;
					when "011" =>OUTP<=D;
					when "100" =>OUTP<=E;
					when "101" =>OUTP<=F;
					when "110" =>OUTP<=G;
					when others =>OUTP<=A;								
					END CASE;
				
			end if;
	end process;
 end COMBINATIONAL;





