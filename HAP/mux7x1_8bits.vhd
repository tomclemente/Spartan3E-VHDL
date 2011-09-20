----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:10:57 08/24/2011 
-- Design Name: 
-- Module Name:    mux7x1_8bits - Behavioral 
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

entity mux7x1_8bits is
    Port ( Input1 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input2 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input3 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input4 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input5 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input6 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input7 : in  STD_LOGIC_VECTOR (7 downto 0);
           ALUEn : in  STD_LOGIC_VECTOR (2 downto 0);
           Output : out  STD_LOGIC_VECTOR (7 downto 0));
end mux7x1_8bits;

architecture Behavioral of mux7x1_8bits is

begin
	with ALUEn select
	Output <= Input1 when "001",
			     Input2 when "010",
			     Input3 when "011",
			     Input4 when "100",
			     Input5 when "101",
			     Input6 when "110",
			     Input7 when "111",
			     "ZZZZZZZZ" when others;
end Behavioral;

