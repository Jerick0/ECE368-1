----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Josh Erick
-- 
-- Create Date:    16:58:09 03/20/2015 
-- Design Name: 
-- Module Name:    WB_controlpath - Behavioral 
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

entity WB_controlpath is
    Port ( WB_inst : in  STD_LOGIC_Vector(15 downto 0);
			  WB_instout : out  STD_LOGIC_Vector(15 downto 0);
           Reg_Aval : out  STD_LOGIC_Vector(3 downto 0);
           En_StoreData : out  STD_LOGIC_Vector(0 downto 0);
           WB_mux : out  STD_LOGIC;
			  CLK		:	in STD_LOGIC;
			  NotCLK	: 	in STD_LOGIC;
			  rst		: in STD_LOGIC
			  );
end WB_controlpath;

architecture Behavioral of WB_controlpath is
Signal WR_inst : STD_LOGIC_VECTOR( 15 downto 0);
Signal WF_inst : STD_LOGIC_VECTOR(15 downto 0);

begin

W_R		: entity work.GP_register
			Port Map ( 	CLK 	=> notCLK,
							D   	=> WB_inst,
							Q	 	=> WR_inst,
							Rst	=> rst
							);
							
W_F		: entity work.GP_register
			Port Map (	CLK 	=> CLK,
							D		=> WR_inst,
							Q		=> WF_inst,
							RST	=> rst
							);
							


Process(CLK)
Begin
		if (CLK'event and CLK='0')then
		
			
			
			if WR_inst(15 downto 12) = "1001" then WB_mux <= '1';
			else WB_mux <='0';
			end if;
		end if;
end process;

Process(CLK)
Begin
		if (CLK'event and CLK='1')then
			if WF_inst(15 downto 12) = "1010" then En_StoreData <= (others => '0');
				else EN_StoreData <=(others => '1');
				end if;
				Reg_Aval <= WR_inst(11 downto 8);
				WB_instout <= WR_inst;
		end if;
end process;




end Behavioral;

