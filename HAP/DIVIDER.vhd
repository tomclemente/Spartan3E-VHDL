----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:25:02 08/27/2011 
-- Design Name: 
-- Module Name:    DIVIDER - Behavioral 
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

entity DIVIDER is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end DIVIDER;

architecture Behavioral of DIVIDER is

begin

	division: process(op1, op2)
	
	variable tempop1, tempout: std_logic_vector(7 downto 0);
	variable tempop2: std_logic_vector(3 downto 0);
		
	begin
			
		tempop1 := op1(7 downto 0);
		tempop2 := op2(3 downto 0);
			
		tempout := "00000000";
			
		for i in 0 to 255 loop
			if tempop1 >= tempop2 then
				tempout := tempout + '1';
				tempop1 := tempop1 - tempop2;
			else
				exit;
			end if;
		end loop;
				
		output <= tempout;
		
	end process;
end Behavioral;

