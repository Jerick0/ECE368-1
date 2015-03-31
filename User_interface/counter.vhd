---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Daniel Noyes
-- 
-- Create Date:    SPRING 2014
-- Module Name:    counter
-- Project Name:   CLOCK COUNTER
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description: Counter
--  Will increase the counter(output) ever time
--  the clock does a rising action
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
		Generic( num_instruct	: integer :=20);

		Port (CLK			: in  STD_LOGIC;
				RST			: in  STD_LOGIC;
				INC			: in  STD_LOGIC;
				COUNT_OUT	: out STD_LOGIC_VECTOR (7 downto 0));
               
end counter;

architecture Behavioral of counter is

    signal pointer : integer range 0 to num_instruct-1 := 0;
    begin
        process (CLK, INC, RST)
        begin
            if (RST = '1') then 
                    pointer <= 0;
            elsif (INC'event and INC = '1') then
               pointer <= pointer + 1;
					if pointer > 15 then
						pointer <= 0;
               end if;
            end if;
        end process;
    COUNT_OUT <= STD_LOGIC_VECTOR(TO_UNSIGNED(pointer,8));
end Behavioral;

