----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:55:52 03/20/2015 
-- Design Name: 
-- Module Name:    execute_controlpath - Behavioral 
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

entity execute_controlpath is
    Port ( E_inst 		: in  STD_LOGIC_Vector(15 downto 0);
			  E_instout 	: out  STD_LOGIC_Vector(15 downto 0);
           opcode 		: out  STD_LOGIC_Vector(3 downto 0);
           enable_SW 	: out  STD_LOGIC_Vector(0 downto 0);
			  CLK				:	in STD_LOGIC;
			  NotCLK			: 	in STD_LOGIC
			 
			  );
end execute_controlpath;

architecture Behavioral of execute_controlpath is
signal ER_inst : STD_LOGIC_VECTOR(15 downto 0);
signal EF_inst : STD_LOGIC_VECTOR(15 downto 0);

begin
E_R		: entity work.GP_register
			Port Map ( 	CLK 	=> CLK,
							D   	=> E_inst,
							Q	 	=> ER_inst,
							Rst	=> '0'
							);
							
E_F		: entity work.GP_register
			Port Map (	CLK 	=> NotCLK,
							D		=> ER_inst,
							Q		=> EF_inst,
							RST	=> '0'
							);
E_instout <= EF_inst;


Process(CLK)
begin
	if(CLK'event and CLK='1')then
	
			opcode <= ER_inst(15 downto 12);
	end if;
end process;

Process(CLK)
begin
	if(CLK'event and CLK='0')then
		
		if EF_inst(15 downto 12) = "1010" then enable_SW <= (others=>'1');
						 else enable_SW <=(others=>'0');
		
		end if;
	end if;
end process;
				
			
	
end Behavioral;

