--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:01:23 03/24/2015
-- Design Name:   
-- Module Name:   D:/ECE368/Project Path/Control_UnitTB/Control_unit_TB.vhd
-- Project Name:  Control_UnitTB
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: control_toplayer
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY Control_unit_TB IS
END Control_unit_TB;
 
ARCHITECTURE behavior OF Control_unit_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT control_toplayer
    PORT(
         instruction_fetch : IN  std_logic_vector(15 downto 0);
         PC : IN  std_logic_vector(13 downto 0);
         CLK : IN  std_logic;
         Rst : IN  std_logic;
         e_opcode : OUT  std_logic_vector(3 downto 0);
         e_sw_enable : OUT  std_logic_vector(0 downto 0);
         o_opA_muxsel : OUT  std_logic_vector(2 downto 0);
         o_opB_muxsel : OUT  std_logic_vector(2 downto 0);
         WB_reg_addr : OUT  std_logic_vector(3 downto 0);
         WB_sd_enable : OUT  std_logic_vector(0 downto 0);
         d_in_mux_sel : OUT  std_logic;
         wb_datamux_sel : OUT  std_logic;
         instruction_wb : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal instruction_fetch : std_logic_vector(15 downto 0) := (others => '0');
   signal PC : std_logic_vector(13 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal Rst : std_logic := '0';

 	--Outputs
   signal e_opcode : std_logic_vector(3 downto 0);
   signal e_sw_enable : std_logic_vector(0 downto 0);
   signal o_opA_muxsel : std_logic_vector(2 downto 0);
   signal o_opB_muxsel : std_logic_vector(2 downto 0);
   signal WB_reg_addr : std_logic_vector(3 downto 0);
   signal WB_sd_enable : std_logic_vector(0 downto 0);
   signal d_in_mux_sel : std_logic;
   signal wb_datamux_sel : std_logic;
   signal instruction_wb : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: control_toplayer PORT MAP (
          instruction_fetch => instruction_fetch,
          PC => PC,
          CLK => CLK,
          Rst => Rst,
          e_opcode => e_opcode,
          e_sw_enable => e_sw_enable,
          o_opA_muxsel => o_opA_muxsel,
          o_opB_muxsel => o_opB_muxsel,
          WB_reg_addr => WB_reg_addr,
          WB_sd_enable => WB_sd_enable,
          d_in_mux_sel => d_in_mux_sel,
          wb_datamux_sel => wb_datamux_sel,
          instruction_wb => instruction_wb
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
		PC <= STD_LOGIC_vector( unsigned(PC)+1);
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 
		
		instruction_fetch <= "0000000100010000";
		wait for CLK_period;
		instruction_fetch <= "0001000100010000";
		wait for CLK_period;
		instruction_fetch <= "0000000100010000";
		wait for CLK_period;
		instruction_fetch <= "0011000100010000";
		wait for CLK_period;
		instruction_fetch <= "0010000100010000";
		wait for CLK_period;
		instruction_fetch <= "0100000100010000";
		wait for CLK_period;
		instruction_fetch <= "0101000100010000";
		wait for CLK_period;
		instruction_fetch <= "0110000100010000";
		wait for CLK_period;
		instruction_fetch <= "0111000100010000";
		wait for CLK_period;
		instruction_fetch <= "1000000100010000";
		wait for CLK_period;
		instruction_fetch <= "1001000100010000";
		wait for CLK_period;
		instruction_fetch <= "1010000100010000";
		wait for CLK_period;
		instruction_fetch <= "1011000100010000";
		wait for CLK_period;	
		instruction_fetch <= "1100000100010000";
		wait for CLK_period;	
		instruction_fetch <= "1101000100010000";
		wait for CLK_period;
		instruction_fetch <= "1111000100010000";
		wait for CLK_period;
      wait;
   end process;

END;
