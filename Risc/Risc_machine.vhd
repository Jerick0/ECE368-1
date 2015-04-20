----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Chris Camara
-- 
-- Create Date:    21:41:07 03/21/2015 
-- Design Name: 
-- Module Name:    Risc_machine - Behavioral 
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
use work.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Risc_machine is
    Port ( CLK : in  STD_LOGIC;
           Store_Result : out  STD_LOGIC_VECTOR(15 downto 0);
           WB_Result : out  STD_LOGIC_VECTOR(15 downto 0);
           OPCODE : out  STD_LOGIC_VECTOR(3 downto 0);
           ST_offset : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end Risc_machine;

architecture Behavioral of Risc_machine is

signal EXEC_OP : STD_LOGIC_VECTOR(3 downto 0):=(others => '0');
signal EXEC_SW_EN : STD_LOGIC_VECTOR(0 downto 0):=(others => '0');
signal CNTLA	: STD_LOGIC_VECTOR(2 downto 0):=(others => '0');
signal CNTLB	: STD_LOGIC_VECTOR(2 downto 0):=(others => '0');
signal WB_REG_ADD : STD_LOGIC_VECTOR(3 downto 0):=(others => '0');
signal WB_ST_DATA_EN : STD_LOGIC_VECTOR(0 downto 0):=(others => '0');
signal D_MUX_SEL : STD_LOGIC:='0';
signal WB_DATA_MUX : STD_LOGIC:='0';
signal INST_FETCH_BITCH : STD_LOGIC_VECTOR(15 downto 0):=(others => '0');
signal PC : STD_LOGIC_VECTOR(12 downto 0):=(others => '0');
signal RST_LINE : STD_LOGIC:='0';

signal tmp_store_result	: std_logic_vector(15 downto 0) :=(others => '0');
signal tmp_wb_result		: std_logic_vector(15 downto 0) :=(others => '0');
signal tmp_st_offset		: std_logic_vector(7 downto 0)  :=(others => '0');

begin

store_result	<= tmp_store_result;
wb_result		<= tmp_wb_result;
st_offset		<= tmp_st_offset;

R_U : entity work.system_reset
	port map(	clk						=> clk,
					pc							=> pc,
					rst						=> rst_line);

C_U : entity work.control_toplayer
	Port map( instruction_fetch   	=> INST_FETCH_BITCH,
					PC							=>	PC,
					CLK						=> CLK,
					RST						=> '0',--RST_LINE,
					E_OPCODE					=> EXEC_OP,
					E_SW_ENABLE				=> EXEC_SW_EN,
					O_OPA_MUXSEL			=> CNTLA,
					O_OPB_MUXSEL			=> CNTLB,
					WB_REG_ADDR				=> WB_REG_ADD,
					WB_SD_ENABLE			=> WB_ST_DATA_EN,
					D_IN_MUX_SEL			=> D_MUX_SEL,
					WB_DATAMUX_SEL			=> WB_DATA_MUX,
					instruction_WB			=> OPCODE
					);
					
DP_U : entity work.datapath
		POrt Map ( CLK 					=> CLK,
						RST					=> RST_LINE,
						D_IM_MUX_SEL		=> D_MUX_SEL,
						O_OPA_MUX_SEL		=> CNTLA,
						O_OPB_MUX_SEL		=> CNTLB,
						E_OPCODE				=> EXEC_OP,
						E_SW_ENABLE			=> EXEC_SW_EN,
						WB_DATA_MUX_SEL	=> WB_DATA_MUX,
						WB_SD_ENABLE		=> WB_ST_DATA_EN,
						WB_REG_ADDR			=> WB_REG_ADD,
						PC						=> PC,
						instruction_FETCH	=> INST_FETCH_BITCH,
						WB_RESULT			=> tmp_wb_result,
						--put ccr in when needed
						STORE_RESULT		=> tmp_store_result,
						STORE_OFFSET		=> tmp_ST_offset
						);


end Behavioral;

