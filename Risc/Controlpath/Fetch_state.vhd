----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:00:13 04/04/2015 
-- Design Name: 
-- Module Name:    Fetch_state - Behavioral 
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

entity Fetch_state is
    Port ( F_inst 					: 	in  STD_LOGIC_VECTOR(15 downto 0);
			  CLK							: 	in 	STD_LOGIC;
				--should_I_merge			:	in	STD_LOGIC;
				--push_notPop				:	out std_logic;
				--push_notPop_branch	:	out std_logic;
				--enable					:	out std_logic;
				--enable_branch			:	out std_logic;
				--merge						:	out std_logic;
				--enable_merge			:	out std_logic;
				sel						:	out std_logic_vector(1 downto 0)
				--sel_branch				:	out std_logic_vector(2 downto 0)
				);
            
end Fetch_state;

architecture Behavioral of Fetch_state is

begin
Process (CLK)
Begin
	If F_inst(15 downto 12)= x"D" then									--Jump and Link
		sel <= "01"; --immidiate value;
	else 	sel <="00"; --incrimented value;									--current PC goes to stack
	end if;
	
	
--	If F_inst(15 downto 12) = x"E" then 								--Return
--			push_notPop <= '0'; 													--stack-pointer minus 1
--	end if;
--	
--	
--	If F_inst(15 downto 12)= x"F" then									--Branch
--			sel_branch <= "100"; --branch mux;									--immediate to branch mux
--			
--	
--	end if;

End Process;

end Behavioral;

