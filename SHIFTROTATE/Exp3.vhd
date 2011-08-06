----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:49:10 07/28/2011 
-- Design Name: 
-- Module Name:    Exp3 - Behavioral 
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

library work;
use work.SHIFT.vhd
			
---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Expsda is
    Port ( Mode : in  STD_LOGIC_VECTOR (1 downto 0);
           Inputs : in  STD_LOGIC_VECTOR (7 downto 0);
           Outputs : out  STD_LOGIC_VECTOR (7 downto 0));
end Expsda;

architecture Behavioral of Exp3 is


begin


end Behavioral;

