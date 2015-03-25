--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:02:39 03/25/2015
-- Design Name:   
-- Module Name:   C:/Users/Christopher/Documents/GitHub/ECE368/Planning/Test_Benches/Datapath_TBs/datapath_tb.vhd
-- Project Name:  datapath
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: datapath_test
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
--USE ieee.numeric_std.ALL;
 
ENTITY datapath_tb IS
END datapath_tb;
 
ARCHITECTURE behavior OF datapath_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT datapath_test
    PORT(
         clk : IN  std_logic;
         d_im_mux_sel : IN  std_logic;
         o_opA_mux_sel : IN  std_logic_vector(2 downto 0);
         o_opB_mux_sel : IN  std_logic_vector(2 downto 0);
         e_opcode : IN  std_logic_vector(3 downto 0);
         e_sw_enable : IN  std_logic_vector(0 downto 0);
         wb_data_mux_sel : IN  std_logic;
         wb_sd_enable : IN  std_logic_vector(0 downto 0);
         wb_reg_addr : IN  std_logic_vector(3 downto 0);
         pc : OUT  std_logic_vector(4 downto 0);
         instruction_fetch : OUT  std_logic_vector(15 downto 0);
         wb_result : OUT  std_logic_vector(15 downto 0);
         ccr_result : OUT  std_logic_vector(3 downto 0);
         store_result : OUT  std_logic_vector(15 downto 0);
         store_offset : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal d_im_mux_sel : std_logic := '0';
   signal o_opA_mux_sel : std_logic_vector(2 downto 0) := (others => '0');
   signal o_opB_mux_sel : std_logic_vector(2 downto 0) := (others => '0');
   signal e_opcode : std_logic_vector(3 downto 0) := (others => '0');
   signal e_sw_enable : std_logic_vector(0 downto 0) := (others => '0');
   signal wb_data_mux_sel : std_logic := '0';
   signal wb_sd_enable : std_logic_vector(0 downto 0) := (others => '0');
   signal wb_reg_addr : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal pc : std_logic_vector(4 downto 0);
   signal instruction_fetch : std_logic_vector(15 downto 0);
   signal wb_result : std_logic_vector(15 downto 0);
   signal ccr_result : std_logic_vector(3 downto 0);
   signal store_result : std_logic_vector(15 downto 0);
   signal store_offset : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: datapath_test PORT MAP (
          clk => clk,
          d_im_mux_sel => d_im_mux_sel,
          o_opA_mux_sel => o_opA_mux_sel,
          o_opB_mux_sel => o_opB_mux_sel,
          e_opcode => e_opcode,
          e_sw_enable => e_sw_enable,
          wb_data_mux_sel => wb_data_mux_sel,
          wb_sd_enable => wb_sd_enable,
          wb_reg_addr => wb_reg_addr,
          pc => pc,
          instruction_fetch => instruction_fetch,
          wb_result => wb_result,
          ccr_result => ccr_result,
          store_result => store_result,
          store_offset => store_offset
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for clk_period*21;
		
		-- 1 clock cycle----------------------------------
		wait for clk_period;
		d_im_mux_sel	<= '1'; -- 5002
		wait for clk_period/2;
		
		-- 2 clock cycle----------------------------------
		wait for clk_period/2;
		d_im_mux_sel	<= '1'; -- 5101
		
		wait for clk_period/2;
		o_opA_mux_sel	<= "000"; -- 5002
		o_opB_mux_sel	<= "000"; -- 5002

		-- 3 clock cycle----------------------------------
		wait for clk_period/2;
		e_opcode			<= x"5"; -- 5002
		d_im_mux_sel	<= '1';	-- A10F
		
		wait for clk_period/2;
		e_sw_enable(0)	<= '0'; -- 5002
		o_opA_mux_sel	<= "000"; -- 5101
		o_opB_mux_sel	<= "000"; -- 5101
		
		-- 4 clock cycle----------------------------------
		wait for clk_period/2;
		wb_data_mux_sel<= '0'; -- 5002
		e_opcode			<= x"5"; -- 5101
		
		wait for clk_period/2;
		wb_reg_addr		<= x"0"; -- 5002
		wb_sd_enable(0)<= '1'; -- 5002
		e_sw_enable(0)	<= '0'; -- 5101
		o_opA_mux_sel	<= "000"; -- A10F
		o_opB_mux_sel	<= "000"; -- A10F
		
		-- 5 clock cycle----------------------------------
		wait for clk_period/2;
		wb_data_mux_sel<= '0'; -- 5101
		
		wait for clk_period/2;
		wb_reg_addr		<= x"1"; -- 5101
		wb_sd_enable(0)<= '1'; -- 5101
      wait;
   end process;

END;
