----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:35:48 03/19/2015 
-- Design Name: 
-- Module Name:    control_toplayer - Structural 
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

entity control_toplayer is
    Port ( instruction_fetch 		: in  STD_LOGIC_Vector(15 downto 0);
					PC						: in STD_LOGIC_VECTOR(13 downto 0);
					CLK 					: in  STD_LOGIC;
					Rst 					: in  STD_LOGIC;
					e_opcode 			: out  STD_LOGIC_Vector(3 downto 0);
					e_sw_enable 		: out  STD_LOGIC_vector(0 downto 0);
					o_opA_muxsel		: out  STD_LOGIC_vector(2 downto 0);
					o_opB_muxsel 		: out  STD_LOGIC_Vector(2 downto 0);
					WB_reg_addr 		: out  STD_LOGIC_Vector(3 downto 0);
					WB_sd_enable 		: out  STD_LOGIC_Vector(0 downto 0);
					d_in_mux_sel 		: out  STD_LOGIC;
					wb_datamux_sel 	: out  STD_LOGIC;
					instruction_wb 	: out  STD_LOGIC_VECTOR(3 downto 0)
					);
end control_toplayer;

architecture Structural of control_toplayer is
--Clock signals

signal NotCLK						: STD_LOGIC;

--instruction paths
signal fetch_instruction 		: STD_LOGIC_VECTOR(15 downto 0);
signal D_RtoD_F					: STD_LOGIC_VECTOR(15 downto 0);
signal D_FtoO_R					: STD_LOGIC_VECTOR(15 downto 0);
signal O_RtoO_F			 		: STD_LOGIC_VECTOR(15 downto 0);
signal O_FtoE_R					: STD_LOGIC_VECTOR(15 downto 0);
signal E_RtoE_F					: STD_LOGIC_VECTOR(15 downto 0);
signal E_FtoW_R					: STD_LOGIC_VECTOR(15 downto 0);
signal W_RtoW_F					: STD_LOGIC_VECTOR(15 downto 0);
signal W_FtoW1_R					: STD_LOGIC_VECTOR(15 downto 0);	


--forwarding paths
signal Exec					 			: STD_LOGIC_VECTOR(15 downto 0);
signal WB 								: STD_LOGIC_VECTOR(15 downto 0);
signal WBPlus1							: STD_LOGIC_VECTOR(15 downto 0);

begin
notclk <= not clk;
EXEC <= E_FtoW_R;
WB <= W_ftoW1_R;


instruction_WB<= WB(15 downto 12);


Decode_state: entity work.Decode_controlpath
			port map(		CLK				=> CLK,
								NOTCLK			=>	NotCLK,
								D_inst 			=> instruction_fetch,
								D_instout		=> D_FtoO_R,
								in_mux_sel 		=> d_in_mux_sel,
								Rst				=> rst
								);
								
Oppa_state: entity work.Opp_Acc_Control
			port map(		CLK				=> CLK,
								NOTCLK			=>	NotCLK,
								O_inst 			=> D_FtoO_R,
								O_instout		=> O_FtoE_R,
								CNTLA_out 		=> o_opA_muxsel,
								CNTLB_out 		=> o_opB_muxsel,
								EXEC 				=> Exec,
								WB					=> WB,
								WBPlus1			=> WBPlus1,
								PC					=> PC,
								RST				=> rst
								);
								
execute_state: entity work.execute_controlpath
			port map(		CLK				=> CLK,
								NOTCLK			=>	NotCLK,
								E_inst 			=> O_FtoE_R,
								E_instout		=> E_FtoW_R,
								opcode 			=> e_opcode,
								enable_SW 		=> e_sw_enable,
								rst				=> rst
								);

WB_state: entity work.WB_controlpath
			port map(		CLK				=> CLK,
								NOTCLK			=>	NotCLK,
								WB_inst			=> E_FtoW_R,
								WB_instout		=> W_FtoW1_R,
								Reg_Aval			=> WB_reg_addr,
								En_StoreData 	=> WB_sd_enable,
								WB_mux			=> wb_datamux_sel,
								rst				=> rst
								);
								
WBPlus1_state: entity work.GP_register
			Port Map ( 	CLK 	=> notCLK,
							D   	=> W_FtoW1_R,
							Q	 	=> WBPLus1,
							Rst	=> Rst
							);	
								




end Structural;

