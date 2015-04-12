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
    Port ( F_inst : in  STD_LOGIC_VECTOR(15 downto 0);
           PC_mux out : out  STD_LOGIC_vector(2 downto 0);
           Stack_out : out  STD_LOGIC_vector(2 downto 0));
end Fetch_state;

architecture Behavioral of Fetch_state is

begin
	If F_inst(15 downto 12)= x"D" then									--Jump and Link
--			PC_mux <= ?? immidiate value;
--	else 	PC_mux <=??; incrimented value
--			current PC goes to stack
   else if F_inst(15 downto 12) = x"E" then 							--Return
--			PC_mux <= ?? stack-pointer minus 1


	end if;



end Behavioral;

