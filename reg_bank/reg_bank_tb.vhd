--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:25:20 03/14/2015
-- Design Name:   
-- Module Name:   C:/Users/Christopher/Documents/College/UMD/Digital Design/Lab03/reg_bank/parallel_ram/reg_bank_tb.vhd
-- Project Name:  parallel_ram
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: reg_bank
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
 
ENTITY reg_bank_tb IS
END reg_bank_tb;
 
ARCHITECTURE behavior OF reg_bank_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT reg_bank
    PORT(
         reg_a_addr : IN  std_logic_vector(3 downto 0);
         reg_b_addr : IN  std_logic_vector(3 downto 0);
         write_addr : IN  std_logic_vector(3 downto 0);
         data_in : IN  std_logic_vector(15 downto 0);
         reg_a : OUT  std_logic_vector(15 downto 0);
         reg_b : OUT  std_logic_vector(15 downto 0);
         w_en : IN  std_logic_vector(0 downto 0);
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reg_a_addr : std_logic_vector(3 downto 0) := (others => '0');
   signal reg_b_addr : std_logic_vector(3 downto 0) := (others => '0');
   signal write_addr : std_logic_vector(3 downto 0) := (others => '0');
   signal data_in : std_logic_vector(15 downto 0) := (others => '0');
   signal w_en : std_logic_vector(0 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal reg_a : std_logic_vector(15 downto 0);
   signal reg_b : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg_bank PORT MAP (
          reg_a_addr => reg_a_addr,
          reg_b_addr => reg_b_addr,
          write_addr => write_addr,
          data_in => data_in,
          reg_a => reg_a,
          reg_b => reg_b,
          w_en => w_en,
          clk => clk
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
      wait for 100 ns;	
		
		report "Start Register Bank Test Bench" severity note;
      wait for clk_period*10;
		
		-- fill register bank with data
		w_en <= "1";
		
		write_addr <= x"0";
		data_in <= x"AA55";
		wait for clk_period;
		
		write_addr <= x"1";
		data_in <= x"55AA";
		wait for clk_period;
		
		write_addr <= x"2";
		data_in <= x"F22F";
		wait for clk_period;
		
		write_addr <= x"3";
		data_in <= x"4CD6";
		wait for clk_period;
		
		write_addr <= x"4";
		data_in <= x"B1E8";
		wait for clk_period;
		
      -- read values from register 
		reg_a_addr <= x"2";
		reg_b_addr <= x"1";
		wait for clk_period;

      wait;
   end process;

END;
