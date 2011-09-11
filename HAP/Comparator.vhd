----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:45:32 08/31/2011 
-- Design Name: 
-- Module Name:    comparator - Behavioral 
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

entity comparator is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           mode : in  STD_LOGIC_VECTOR (2 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end comparator;

architecture Behavioral of comparator is

begin

output(7 downto 1) <= "0000000";
output(0)<=	'1' when (op1 < op2) and (mode = "000") else				--LT
				'1' when (op1 > op2) and (mode = "001") else				--GT
				'1' when (op1 = op2) and (mode = "010") else				--EQ
				'1' when (op1 >= op2) and (mode = "011") else			--GTE
				'1' when (op1 <= op2) and (mode = "100") else			--LTE
				'1' when (op1 /= op2) and (mode = "101") else			--NE
				--------------------Branching-----------------
				'1' when (op1 = "00000000") and (mode = "110") else	--BE or BER
				'1' when (op1 /= "00000000") and (mode = "111") else	--BNE or BNER
				'0';

end Behavioral;

