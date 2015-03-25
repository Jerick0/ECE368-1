--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:21:06 03/24/2015
-- Design Name:   
-- Module Name:   C:/Users/Logan Doonan/Documents/Xilinx/ECE-368_Lab3/User_interface/tb_seg.vhd
-- Project Name:  User_interface
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SSegDriver
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
 
ENTITY tb_seg IS
END tb_seg;
 
ARCHITECTURE behavior OF tb_seg IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SSegDriver
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         EN : IN  std_logic;
         SEG_0 : IN  std_logic_vector(3 downto 0);
         SEG_1 : IN  std_logic_vector(3 downto 0);
         SEG_2 : IN  std_logic_vector(3 downto 0);
         SEG_3 : IN  std_logic_vector(3 downto 0);
         DP_CTRL : IN  std_logic_vector(3 downto 0);
         COL_EN : IN  std_logic;
         SEG_OUT : OUT  std_logic_vector(6 downto 0);
         DP_OUT : OUT  std_logic;
         AN_OUT : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal EN : std_logic := '1';
   signal SEG_0 : std_logic_vector(3 downto 0) := (others => '0');
   signal SEG_1 : std_logic_vector(3 downto 0) := (others => '0');
   signal SEG_2 : std_logic_vector(3 downto 0) := (others => '0');
   signal SEG_3 : std_logic_vector(3 downto 0) := (others => '0');
   signal DP_CTRL : std_logic_vector(3 downto 0) := (others => '0');
   signal COL_EN : std_logic := '0';

 	--Outputs
   signal SEG_OUT : std_logic_vector(6 downto 0);
   signal DP_OUT : std_logic;
   signal AN_OUT : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SSegDriver PORT MAP (
          CLK => CLK,
          RST => RST,
          EN => EN,
          SEG_0 => SEG_0,
          SEG_1 => SEG_1,
          SEG_2 => SEG_2,
          SEG_3 => SEG_3,
          DP_CTRL => DP_CTRL,
          COL_EN => COL_EN,
          SEG_OUT => SEG_OUT,
          DP_OUT => DP_OUT,
          AN_OUT => AN_OUT
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
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here
		rst <= '1';
		wait for CLK_period;
		rst <= '0';
		wait for CLK_period;
		
		seg_0 <= "0001";
		seg_2 <= "0010";
		seg_3 <= "0011";
		seg_1 <= "0100";
		wait for CLK_period*20;
		
		rst <= '1';
		wait for CLK_period;
		rst <= '0';
		wait for CLK_period;

      wait;
   end process;

END;
