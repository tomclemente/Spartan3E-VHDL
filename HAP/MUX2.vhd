----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Archie Morre
-- 
-- Create Date:    23:11:00 08/29/2011 
-- Design Name: 
-- Module Name:    MUX2 - Behavioral 
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

entity MUX2 is
    Port ( irOut : in  STD_LOGIC_VECTOR (7 downto 0);
           ramOut : in  STD_LOGIC_VECTOR (7 downto 0);
           aluOut : in  STD_LOGIC_VECTOR (7 downto 0);
           mux2sel : in  STD_LOGIC_VECTOR (1 downto 0);
           dataOut : out  STD_LOGIC_VECTOR (7 downto 0));
end MUX2;

architecture Behavioral of MUX2 is
signal irIn, ramIn, aluIn : STD_LOGIC_VECTOR (7 downto 0);
begin
irIn <= irOut;
ramIn <= ramOut;
aluIn<=aluOut;
	with mux2sel select
		dataOut <= irIn when "01",
					  ramIn when "10",
					  aluIn when "11",
					 "ZZZZZZZZ" when others;

end Behavioral;

