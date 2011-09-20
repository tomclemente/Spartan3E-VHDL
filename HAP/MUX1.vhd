----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Archie Morre
-- 
-- Create Date:    23:08:03 08/29/2011 
-- Design Name: 
-- Module Name:    MUX1 - Behavioral 
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

entity MUX1 is
    Port ( r1in : in  STD_LOGIC_VECTOR (7 downto 0);
			  r2in : in  STD_LOGIC_VECTOR (7 downto 0);
           irIn : in  STD_LOGIC_VECTOR (7 downto 0);
           mux1sel : in  STD_LOGIC_VECTOR (1 downto 0);
           memOut : out  STD_LOGIC_VECTOR (7 downto 0));
end MUX1;

architecture Behavioral of MUX1 is

begin

with mux1sel select
	memOut <= irIn when "01",
				 r1in when "10",
				 r2in when "11",
			  "ZZZZZZZZ" when others;
			  
end Behavioral;

