----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:21:51 07/31/2011 
-- Design Name: 
-- Module Name:    PEncoder - Conditional 
-- Project Name: 
--\\ Target Devices: 
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
use IEEE.NUMERIC_STD.ALL;
---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PEncoder is
    Port ( I : in  STD_LOGIC_VECTOR (3 downto 0);
           A : out  STD_LOGIC_VECTOR (1 downto 0));
end PEncoder;

architecture Conditional of PEncoder is

signal temp: STD_LOGIC_VECTOR(3 downto 0);
begin

temp <= I;

A <= "00" when std_match(temp, "---1") else
	  "01" when std_match(temp, "--10") else
	  "10" when std_match(temp, "-100") else
	  "11" when std_match(temp, "1000") else
	  "ZZ";
	  

end Conditional;

