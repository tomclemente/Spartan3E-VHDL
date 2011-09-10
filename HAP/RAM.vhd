----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:14:15 08/16/2011 
-- Design Name: 
-- Module Name:    RAM - Behavioral 
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
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
    Port ( dataIn : in  STD_LOGIC_VECTOR (7 downto 0);
           memIn : in  STD_LOGIC_VECTOR(7 downto 0);
			  Clock : in STD_LOGIC;
           RRen : in  STD_LOGIC;
           RWen : in  STD_LOGIC;
           dataOut : out  STD_LOGIC_VECTOR (7 downto 0));
end RAM;

architecture Behavioral of RAM is

	type ram_type is array (0 to 255) of std_logic_vector(7 downto 0);
   signal ram : ram_type;
   signal read_address : std_logic_vector(7 downto 0);
	
begin

	process (RRen, RWen, Clock, memIn, dataIn) is
	
	begin
				if (RWen = '1' and RRen = '0') then				--write enable
					ram(to_integer(unsigned(memIn))) <= dataIn;		--data is written in the specified address
				end if;
				read_address <= memIn;
				
				if(rising_edge(Clock)) then
					if (RRen = '1' and RWen = '0') then				--read enable
						dataOut <= ram(to_integer(unsigned(read_address)));	--data in the specified address is outputted
					end if;
				end if;
			
  end process;
 
end Behavioral;

