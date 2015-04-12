--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:52:21 03/25/2015
-- Design Name:   
-- Module Name:   C:/Users/Christopher/Documents/GitHub/ECE368/Planning/Test_Benches/execute_dp_tb.vhd
-- Project Name:  execute_test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: execute_test
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
 
ENTITY execute_dp_tb IS
END execute_dp_tb;
 
ARCHITECTURE behavior OF execute_dp_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT execute_test
    PORT(
         clk : IN  std_logic;
         op_a : IN  std_logic_vector(15 downto 0);
         op_b : IN  std_logic_vector(15 downto 0);
         op_code : IN  std_logic_vector(3 downto 0);
         store_en : IN  std_logic_vector(0 downto 0);
         ccr : OUT  std_logic_vector(3 downto 0);
         load : OUT  std_logic_vector(15 downto 0);
         load_forward : OUT  std_logic_vector(15 downto 0);
         result : OUT  std_logic_vector(15 downto 0);
         result_forward : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal op_a : std_logic_vector(15 downto 0) := (others => '0');
   signal op_b : std_logic_vector(15 downto 0) := (others => '0');
   signal op_code : std_logic_vector(3 downto 0) := (others => '0');
   signal store_en : std_logic_vector(0 downto 0) := (others => '0');

 	--Outputs
   signal ccr : std_logic_vector(3 downto 0);
   signal load : std_logic_vector(15 downto 0);
   signal load_forward : std_logic_vector(15 downto 0);
   signal result : std_logic_vector(15 downto 0);
   signal result_forward : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: execute_test PORT MAP (
          clk => clk,
          op_a => op_a,
          op_b => op_b,
          op_code => op_code,
          store_en => store_en,
          ccr => ccr,
          load => load,
          load_forward => load_forward,
          result => result,
          result_forward => result_forward
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
		
		op_a		<= x"AA55";
		op_b		<= x"00A5";
		
		wait for clk_period;
		op_code	<= x"1";
		
		wait for clk_period;
		op_code	<= x"2";
		
		wait for clk_period;
		op_code	<= x"3";
		
		wait for clk_period;
		op_code	<= x"4";
		
		wait for clk_period;
		op_code	<= x"5";
		
		wait for clk_period;
		op_code	<= x"6";
		
		wait for clk_period;
		op_code	<= x"7";
		
		wait for clk_period;
		op_code	<= x"8";
		
		wait for clk_period;
		op_code	<= x"9";
		
		wait for clk_period;
		op_code		<= x"A";
		store_en(0)	<= '1';
		
		wait for clk_period;
		store_en(0)	<= '0';
		op_code		<= x"9";
		
      wait;
   end process;

END;
