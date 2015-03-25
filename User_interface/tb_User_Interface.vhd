--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:26:16 03/24/2015
-- Design Name:   
-- Module Name:   C:/Users/Logan Doonan/Documents/Xilinx/ECE-368_Lab3/User_interface/tb_User_Interface.vhd
-- Project Name:  User_interface
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: User_Interface
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
 
ENTITY tb_User_Interface IS
END tb_User_Interface;
 
ARCHITECTURE behavior OF tb_User_Interface IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT User_Interface
    PORT(CLK 	: IN  	std_logic;
         BTN 	: IN  	std_logic;
			WE 	: IN  	std_logic;
         OPCODE: IN  	std_logic_vector(3 downto 0);
         WB 	: IN  	std_logic_vector(15 downto 0);
         SW 	: IN  	std_logic_vector(15 downto 0);
         RST 	: OUT  	std_logic;
         DP 	: OUT  	std_logic;
         SEG 	: OUT  	std_logic_vector(6 downto 0);
         AN 	: OUT  	std_logic_vector(3 downto 0);
         LED 	: OUT  	std_logic_vector(7 downto 0);
			DEBUG	: out STD_LOGIC_VECTOR(15 downto 0));
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal BTN : std_logic := '0';
	signal WE : std_logic := '0';
   signal OPCODE : std_logic_vector(3 downto 0) := (others => '0');
   signal WB : std_logic_vector(15 downto 0) := (others => '0');
   signal SW : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal RST : std_logic;
   signal DP : std_logic;
   signal SEG : std_logic_vector(6 downto 0);
   signal AN : std_logic_vector(3 downto 0);
   signal LED : std_logic_vector(7 downto 0);
	signal DEBUG : STD_LOGIC_VECTOR(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: User_Interface PORT MAP (
          CLK => CLK,
          BTN => BTN,
          OPCODE => OPCODE,
          WB => WB,
			 WE => WE,
          SW => SW,
          RST => RST,
          DP => DP,
          SEG => SEG,
          AN => AN,
          LED => LED,
			 DEBUG => DEBUG
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
		WE <= '1';						--prep for instructions
		wait for CLK_period;
		
		WB <= "0000000000000000";	--load instructions
		OPCODE <= "0000";
		wait for CLK_period;
		WB <= "0101010101010101";
		OPCODE <= "0001";
		wait for CLK_period;
		WB <= "1010101010101010";
		OPCODE <= "0010";
		wait for CLK_period;
		WB <= "1111111111111111";
		OPCODE <= "0011";
		wait for CLK_period;
		WB <= "0000000000000000";
		OPCODE <= "0100";
		wait for CLK_period;
		WB <= "0000000011111111";
		OPCODE <= "0101";
		wait for CLK_period;
		WB <= "1111111100000000";
		OPCODE <= "0110";
		wait for CLK_period;
		WB <= "1111000011110000";
		OPCODE <= "0111";
		wait for CLK_period;
		WB <= "0000111100001111";
		OPCODE <= "1000";
		wait for CLK_period;
		WB <= "0000000000000000";
		SW <= "0101010101010101";
		OPCODE <= "1001";
		wait for CLK_period;
		WB <= "1111111111111111";
		OPCODE <= "1010";
		wait for CLK_period;
		WB <= "0101010101010101";
		SW <= "0000000000000000";
		OPCODE <= "1011";
		wait for CLK_period;
		WB <= "1010101010101010";
		OPCODE <= "1100";
		wait for CLK_period;
		WB <= "0101010101010101";
		OPCODE <= "1101";
		wait for CLK_period;
		WB <= "1010101010101010";
		OPCODE <= "1110";
		wait for CLK_period;
		
		WE <= '0';						--instructions loaded
		wait for CLK_period;			--prep for display
		
		BTN <= '1';
		wait for 40 ns;
		BTN <= '0';
		wait for 40 ns;
		
		BTN <= '1';
		wait for 40 ns;
		BTN <= '0';
		wait for 40 ns;
		
		BTN <= '1';
		wait for 40 ns;
		BTN <= '0';
		wait for 40 ns;
		
		BTN <= '1';
		wait for 40 ns;
		BTN <= '0';
		wait for 40 ns;
		
		BTN <= '1';
		wait for 40 ns;
		BTN <= '0';
		wait for 40 ns;
		
		WE <= '1';
		wait for CLK_period;
		WB <= "0101010101010101";
		OPCODE <= "1111";
		wait for CLK_period;

      wait;
   end process;

END;
