----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Maria Johanna Ybanez
-- 
-- Create Date:    21:51:22 08/17/2011 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    Port ( memIn : in  STD_LOGIC_VECTOR (7 downto 0);
			  PCen : in  STD_LOGIC;
           PCLen : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  Clock : in STD_LOGIC;
           memOut : out  STD_LOGIC_VECTOR (7 downto 0));
end PC;

architecture Behavioral of PC is

signal temp: std_logic_vector(7 downto 0):="00000000";

begin

	process (PCen, PCLen, Reset, Clock)				--counter outputs the current value of count
		begin
			
			if (Reset = '1') then		--counter cleared
				temp <= "00000000";
			elsif(rising_edge(Clock)) then
				if(PCen = '1') then		--if count is high
					temp <= temp + 1;		--increments counter
				end if;
				if(PCLen = '1') then		--for jumping instructions
					temp <= memIn;
				end if;
			end if;
			
	end process;
		
		memOut <= temp;

end Behavioral;