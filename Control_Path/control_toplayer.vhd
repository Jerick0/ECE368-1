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
    Port ( instruction fetch : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           e_opcode : out  STD_LOGIC;
           e_sw_enable : out  STD_LOGIC;
           o-opA_muxsel : out  STD_LOGIC;
           o_opB_muxsel : out  STD_LOGIC;
           WB_reg_addr : out  STD_LOGIC;
           WB_sd_enable : out  STD_LOGIC;
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





end Structural;

