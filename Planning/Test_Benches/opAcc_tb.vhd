--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:31:56 03/25/2015
-- Design Name:   
-- Module Name:   C:/Users/Christopher/Documents/GitHub/ECE368/Planning/Test_Benches/opacc_tb.vhd
-- Project Name:  opAcc_test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Opacc
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
 
ENTITY opacc_tb IS
END opacc_tb;
 
ARCHITECTURE behavior OF opacc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Opacc
    PORT(
         Decode_Reg : IN  std_logic_vector(15 downto 0);
         Reg_B : IN  std_logic_vector(15 downto 0);
         Reg_A : IN  std_logic_vector(15 downto 0);
         Load_EX_F : IN  std_logic_vector(15 downto 0);
         WB_F : IN  std_logic_vector(15 downto 0);
         RR_EX_F : IN  std_logic_vector(15 downto 0);
         WBplus1_F : IN  std_logic_vector(15 downto 0);
         Cntl_A : IN  std_logic_vector(2 downto 0);
         Cntl_B : IN  std_logic_vector(2 downto 0);
         CLK : IN  std_logic;
         OP_A : OUT  std_logic_vector(15 downto 0);
         OP_B : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Decode_Reg : std_logic_vector(15 downto 0) := (others => '0');
   signal Reg_B : std_logic_vector(15 downto 0) := (others => '0');
   signal Reg_A : std_logic_vector(15 downto 0) := (others => '0');
   signal Load_EX_F : std_logic_vector(15 downto 0) := (others => '0');
   signal WB_F : std_logic_vector(15 downto 0) := (others => '0');
   signal RR_EX_F : std_logic_vector(15 downto 0) := (others => '0');
   signal WBplus1_F : std_logic_vector(15 downto 0) := (others => '0');
   signal Cntl_A : std_logic_vector(2 downto 0) := (others => '0');
   signal Cntl_B : std_logic_vector(2 downto 0) := (others => '0');
   signal CLK : std_logic := '0';

 	--Outputs
   signal OP_A : std_logic_vector(15 downto 0);
   signal OP_B : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Opacc PORT MAP (
          Decode_Reg => Decode_Reg,
          Reg_B => Reg_B,
          Reg_A => Reg_A,
          Load_EX_F => Load_EX_F,
          WB_F => WB_F,
          RR_EX_F => RR_EX_F,
          WBplus1_F => WBplus1_F,
          Cntl_A => Cntl_A,
          Cntl_B => Cntl_B,
          CLK => CLK,
          OP_A => OP_A,
          OP_B => OP_B
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for clk_period*21;	

      -- load all the inputs with signals
		decode_reg		<= x"1111";
		load_ex_f		<= x"2222";
		reg_a				<= x"3333";
		reg_b				<= x"4444";
		rr_ex_f			<= x"5555";
		wbplus1_f		<= x"6666";
		wb_f				<= x"7777";
		
		-- select different outputs
		wait for clk_period/2;
		cntl_a			<= "001";
		cntl_b			<= "001";
		
		wait for clk_period;
		cntl_a			<= "010";
		cntl_b			<= "010";
		
		wait for clk_period;
		cntl_a			<= "011";
		cntl_b			<= "011";
		
		wait for clk_period;
		cntl_a			<= "100";
		cntl_b			<= "100";
		
		wait for clk_period;
		cntl_a			<= "101";
		cntl_b			<= "101";
		
		wait for clk_period;
		cntl_b			<= "110";
		
		wait for clk_period;
      wait;
   end process;

END;
