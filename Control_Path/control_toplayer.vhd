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
    Port ( instruction_fetch : in  STD_LOGIC_Vector(15 downto 0);
           CLK : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           e_opcode : out  STD_LOGIC_Vector(3 downto 0);
           e_sw_enable : out  STD_LOGIC_vector(0 downto 0);
           o_opA_muxsel : out  STD_LOGIC_vector(2 downto 0);
           o_opB_muxsel : out  STD_LOGIC;
           WB_reg_addr : out  STD_LOGIC_Vector(3 downto 0);
           WB_sd_enable : out  STD_LOGIC_Vector(0 downto 0);
           d_in_mux_sel : out  STD_LOGIC;
           wb_datamux_sel : out  STD_LOGIC;
           instruction_wb : out  STD_LOGIC);
end control_toplayer;

architecture Structural of control_toplayer is

signal fetch_instruction : STD_LOGIC_VECTOR(15 downto 0);
signal D_inst				 : STD_LOGIC_VECTOR(15 downto 0);
signal O_inst				 : STD_LOGIC_VECTOR(15 downto 0);
signal E_inst				 : STD_LOGIC_VECTOR(15 downto 0);
signal W_inst				 : STD_LOGIC_VECTOR(15 downto 0);

begin
Decode_state: entity work.Decode_controlpath
			port map(		D_inst 		=> D_inst,
								in_mux_sel 	=> d_in_mux_sel
								);
								
Oppa_state: entity work.Opp_Acc_Control
			port map(		O_inst 		=> O_inst,
								CNTLA_out 	=> o_opA_muxsel,
								CNTLB_out 	=> o_opB_muxsel
								);
								
execute_state: entity work.execute_controlpath
			port map(		E_inst 		=> E_inst,
								opcode 		=> e_opcode,
								enable_SW 	=> e_sw_enable
								);
								
WB_state: entity work.WB_controlpath
			port map(		WB_inst		=> W_inst,
								Reg_Aval		=> WB_reg_addr,
								En_StoreData => WB_sd_enable,
								WB_mux		=> wb_datamux_sel
								);
								
inst_bank: entity work.Instruction_bank
			port map(		fetch_instruction => instruction_fetch,
								D_inst		=> D_inst,
								O_inst		=> O_inst,
								E_inst		=> E_inst,
								W_inst		=> W_inst
								);
								




end Structural;

