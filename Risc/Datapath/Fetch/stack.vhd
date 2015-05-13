----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:52:05 04/09/2015 
-- Design Name: 
-- Module Name:    stack - behavioral 
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

entity stack is
	generic(	addr_size			: integer :=13;		-- address line width
				stack_size			: integer :=4);	-- number of addresses stored on stack
	
	port(		-- inputs
				addr_in				: in std_logic_vector(addr_size-1 downto 0);
				addr_in_branch		: in std_logic_vector(addr_size-1 downto 0);
	
				-- outputs
				addr_out				: out std_logic_vector(addr_size-1 downto 0);
				addr_out_branch	: out std_logic_vector(addr_size-1 downto 0);
				
				-- control signals
				clk					: in std_logic;	-- system clk
				rst					: in std_logic;	-- system reset
				push_notPop			: in std_logic;	-- 1 is a push, 0 is a pop
				push_notPop_branch: in std_logic;	-- 1 is a push, 0 is a pop
				enable				: in std_logic;	-- enable read or write. define 1 to be enabled
				enable_branch		: in std_logic;	-- enable read or write. define 1 to be enabled
				merge					: in std_logic;	-- merge the stacks to ensure they are the same
				enable_merge		: in std_logic);	-- enable a merge of the stacks
end stack;

architecture behavioral of stack is
	type stack_type is array (stack_size-1 downto 0) of std_logic_vector(addr_size-1 downto 0);
	signal stack_reg				:	stack_type := (others => (others => '0'));			-- this is a stack
	signal stack_reg_branch		:	stack_type := (others => (others => '0'));			-- this is a branching stack
	signal stack_ptr				:	integer := 0;													-- this is the stack pointer
	signal stack_ptr_branch		:	integer := 0;													-- this is the branch stack pointer
	signal full						:	std_logic := '0';												-- is the stack full
	signal empty					: 	std_logic := '1';												-- is the stack empty
	signal full_branch			:	std_logic := '0';												-- is the branch stack full
	signal empty_branch			:	std_logic := '1';												-- is the branch stack empty
	
	signal addr_in_s				: 	std_logic_vector(addr_size-1 downto 0);
	signal addr_in_branch_s		:	std_logic_vector(addr_size-1 downto 0);
	signal addr_out_s				: 	std_logic_vector(addr_size-1 downto 0);
	signal addr_out_branch_s	:	std_logic_vector(addr_size-1 downto 0);

begin
	addr_in_s 			<= addr_in;
	addr_in_branch_s	<= addr_in_branch;
	addr_out 			<= addr_out_s;
	addr_out_branch	<= addr_out_branch_s;

	-------------------------------------------------------------------------------------
	--
	--	Main Stack
	--
	-------------------------------------------------------------------------------------
	process (clk, rst, push_notPop, enable)
	begin
		if (rst = '1') then																-- system reset
			stack_reg 	<= (others => (others => '0'));
			stack_ptr 	<= 0;
			full			<= '0';
			empty			<= '1';
		elsif (clk'event and clk='0') then	
			if (enable = '1' and push_notPop = '1' and full /= '1') then-- push event
				stack_reg(stack_ptr) <= addr_in_s;								-- store an address in stack
				
				if (stack_ptr < 3) then												-- increase the stack pointer, unless already full
					stack_ptr <= stack_ptr + 1;
				end if; 
			end if;
			
			if (enable = '1' and push_notPop = '0' and empty /= '1') then-- pop event
				addr_out_s <= stack_reg(stack_ptr-1);							-- remove item from stack
				
				if (stack_ptr > 0) then												-- decrease the stack pointer, unless already empty
					stack_ptr <= stack_ptr - 1;
				end if;
			end if;
			
			-- check to see if the stack is full, empty, or neither
			if (stack_ptr = 3) then 		-- is the stack full
				full <= '1';
				empty <= '0';
			elsif (stack_ptr = 0) then		-- is the stack empty
				full <= '0';
				empty <= '1';
			else									-- is the stack neither full or empty
				full <= '0';
				empty <= '0';
			end if;
		end if;
	end process;

	-------------------------------------------------------------------------------------
	--
	--	Branching Stack
	--
	-------------------------------------------------------------------------------------
	process (clk, rst, push_notPop_branch, enable_branch)
	begin
		if (rst = '1') then																-- system reset
			stack_reg_branch 	<= (others => (others => '0'));
			stack_ptr_branch 	<= 0;
			full_branch			<= '0';
			empty_branch		<= '1';
		elsif (clk'event and clk='0') then	
			if (enable_branch = '1' and push_notPop_branch = '1' and full_branch /= '1') then-- push event
				stack_reg_branch(stack_ptr_branch) <= addr_in_branch_s;								-- store an address in stack
				
				if (stack_ptr_branch < 3) then												-- increase the stack pointer, unless already full
					stack_ptr_branch <= stack_ptr_branch + 1;
				end if; 
			end if;
			
			if (enable_branch = '1' and push_notPop_branch = '0' and empty_branch /= '1') then-- pop event
				addr_out_branch_s <= stack_reg_branch(stack_ptr_branch-1);							-- remove item from stack
				
				if (stack_ptr_branch > 0) then												-- decrease the stack pointer, unless already empty
					stack_ptr_branch <= stack_ptr_branch - 1;
				end if;
			end if;
			
			-- check to see if the stack is full, empty, or neither
			if (stack_ptr_branch = 3) then 		-- is the stack full
				full_branch <= '1';
				empty_branch <= '0';
			elsif (stack_ptr_branch = 0) then		-- is the stack empty
				full_branch <= '0';
				empty_branch <= '1';
			else									-- is the stack neither full or empty
				full_branch <= '0';
				empty_branch <= '0';
			end if;
		end if;
	end process;
	
	-------------------------------------------------------------------------------------
	--
	--	Merge Stacks
	--
	-------------------------------------------------------------------------------------
	process(clk, merge, enable_merge)
	begin
		if(clk'event and clk='0') then				-- perform merge on falling edge
			if(enable_merge = '1') then				-- ensure the merge is enabled
				if(merge = '0') then						-- the main pipe was taken
					stack_reg_branch <= stack_reg;
				elsif(merge = '1') then					-- the branching pipe was taken
					stack_reg <= stack_reg_branch;
				end if;
			end if;
		end if;
	end process;
	
end behavioral;

