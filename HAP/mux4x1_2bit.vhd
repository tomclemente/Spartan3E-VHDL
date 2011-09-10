----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:14:13 08/29/2011 
-- Design Name: 
-- Module Name:    mux4x1_2bit - Behavioral 
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

entity mux4x1_2bit is
    Port ( Input1 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input2 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input3 : in  STD_LOGIC_VECTOR (7 downto 0);
           Input4 : in  STD_LOGIC_VECTOR (7 downto 0);
           Output : out  STD_LOGIC_VECTOR (7 downto 0);
           Mode : in  STD_LOGIC_VECTOR (1 downto 0));
end mux4x1_2bit;

architecture Behavioral of mux4x1_2bit is

begin
	with Mode select
	Output <=  Input1 when "00",
			     Input2 when "01",
			     Input3 when "10",
			     Input4 when "11",
			     "ZZZZZZZZ" when others;

end Behavioral;

