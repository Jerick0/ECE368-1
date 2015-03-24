--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:19:58 03/23/2015
-- Design Name:   
-- Module Name:   D:/ECE368/Project Path/OPPAC_TB/OPP_AC_TB.vhd
-- Project Name:  OPPAC_TB
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Opp_Acc_Control
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
use ieee.numeric_std.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY OPP_AC_TB IS
END OPP_AC_TB;
 
ARCHITECTURE behavior OF OPP_AC_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Opp_Acc_Control
    PORT(
         O_inst : IN  std_logic_vector(15 downto 0);
         EXEC : IN  std_logic_vector(15 downto 0);
         WB : IN  std_logic_vector(15 downto 0);
         WBPLUS1 : IN  std_logic_vector(15 downto 0);
         PC : IN  std_logic_vector(13 downto 0);
         CLK : IN  std_logic;
         notCLK : IN  std_logic;
         O_instout : OUT  std_logic_vector(15 downto 0);
         CNTLA_out : OUT  std_logic_vector(2 downto 0);
         CNTLB_out : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal O_inst : std_logic_vector(15 downto 0) := (others => '0');
   signal EXEC : std_logic_vector(15 downto 0) := (others => '0');
   signal WB : std_logic_vector(15 downto 0) := (others => '0');
   signal WBPLUS1 : std_logic_vector(15 downto 0) := (others => '0');
   signal PC : std_logic_vector(13 downto 0) := (others => '0');
   signal CLK : std_logic := '0';
   signal notCLK : std_logic := '0';

 	--Outputs
   signal O_instout : std_logic_vector(15 downto 0);
   signal CNTLA_out : std_logic_vector(2 downto 0);
   signal CNTLB_out : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
   constant notCLK_period : time := 10 ns;
 
BEGIN
notclk <= not clk;
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Opp_Acc_Control PORT MAP (
          O_inst => O_inst,
          EXEC => EXEC,
          WB => WB,
          WBPLUS1 => WBPLUS1,
          PC => PC,
          CLK => CLK,
          notCLK => notCLK,
          O_instout => O_instout,
          CNTLA_out => CNTLA_out,
          CNTLB_out => CNTLB_out
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
		PC <= std_logic_vector( unsigned(PC) + 1);
   end process;
 
   notCLK_process :process
   begin
		notCLK <= '1';
		wait for notCLK_period/2;
		notCLK <= '0';
		wait for notCLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 
		O_inst <= B"0000_0001_0001_0000";
		wait for CLK_period;
		O_inst <= B"0001_0001_0001_0000";
		wait for CLK_period;
		O_inst <= B"0101_0001_0001_0000";
		wait for CLK_period;
		Exec<= B"1001_0011_0001_0000";
		O_inst <= B"0001_0011_0011_0000";
		wait for CLK_period;
		WBPlus1 <= B"0001_0110_0001_0000";
		O_inst <= B"0001_0001_0110_0000";
		

      wait;
   end process;

END;
