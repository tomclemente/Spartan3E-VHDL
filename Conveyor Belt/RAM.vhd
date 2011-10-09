----------------------------------------------------------------------------------
-- Module Name:    RAM - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM is
    Port (	pixel_row : in std_logic_vector(9 downto 4);
				pixel_col : in std_logic_vector(9 downto 4);
				char 		 : out std_logic_vector(7 downto 0));
end RAM;

architecture Behavioral of RAM is
	signal row, col1: std_logic_vector(5 downto 0);
    
	begin
		col1 <= "000000"; 
		
		process(pixel_row, pixel_col)
		begin

      	if (pixel_row = 2) then

				if pixel_col=col1+15 then
					 char <= "01010111"; -- "W"
				elsif pixel_col=col1+16 then
					 char <= "01000101"; -- "E"
				elsif pixel_col=col1+17 then
					 char <= "01001100"; -- "L"
				elsif pixel_col=col1+18 then
					 char <= "01000011"; -- "C"
				elsif pixel_col=col1+19 then
					 char <= "01001111"; -- "O"
				elsif pixel_col=col1+20 then
					 char <= "01001101"; -- "M"
				elsif pixel_col=col1+21 then
					 char <= "01000101"; -- "E"
				elsif pixel_col=col1+22 then
					 char <= "00100001"; -- "!"
				else
					 char <= "00100000"; -- space
				end if;

			elsif pixel_row = 4 then
			
				 if pixel_col=col1+10 then
							char <= "01000011"; -- "C"
				 elsif pixel_col=col1+11 then
							char <= "01001111"; -- "O"
				 elsif pixel_col=col1+12 then
							char <= "01001110"; -- "N"
				 elsif pixel_col=col1+13 then
							char <= "01010110"; -- "V"
				 elsif pixel_col=col1+14 then
							char <= "01000101"; -- "E"
				 elsif pixel_col=col1+15 then
							char <= "01011001"; -- "Y"
				 elsif pixel_col=col1+16 then
							char <= "01001111"; -- "O"
				 elsif pixel_col=col1+17 then
							char <= "01010010"; -- "R"
				 elsif pixel_col=col1+18 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+19 then
							char <= "01000010"; -- "B"
				 elsif pixel_col=col1+20 then
							char <= "01000101"; -- "E"
				 elsif pixel_col=col1+21 then
							char <= "01001100"; -- "L"
				 elsif pixel_col=col1+22 then
							char <= "01010100"; -- "T"
				 elsif pixel_col=col1+23 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+24 then
							char <= "01110110"; -- "v"
				 elsif pixel_col=col1+25 then
							char <= "00110010"; -- "2"
				 elsif pixel_col=col1+26 then
							char <= "01101011"; -- "k"
				 elsif pixel_col=col1+27 then
							char <= "00110001"; -- "1"
				 elsif pixel_col=col1+28 then
							char <= "00110001"; -- "1"
				 else
							char <= "00100000"; -- space
				 end if;
				 
			elsif pixel_row = 6 then
			
				 if pixel_col=col1+10 then
							char <= "01001111"; -- "O"
				 elsif pixel_col=col1+11 then
							char <= "01110000"; -- "p"
				 elsif pixel_col=col1+12 then
							char <= "01110100"; -- "t"
				 elsif pixel_col=col1+13 then
							char <= "01101001"; -- "i"
				 elsif pixel_col=col1+14 then
							char <= "01101111"; -- "o"
				 elsif pixel_col=col1+15 then
							char <= "01101110"; -- "n"
				 elsif pixel_col=col1+16 then
							char <= "01110011"; -- "s"
				 elsif pixel_col=col1+17 then
							char <= "00111010"; -- ":"
				 else
							char <= "00100000"; -- space
				 end if;
				 
			elsif pixel_row = 8 then
			
				 if pixel_col=col1+11 then
							char <= "01010011"; -- "S"
				 elsif pixel_col=col1+12 then
							char <= "01010111"; -- "W"
				 elsif pixel_col=col1+13 then
							char <= "00110001"; -- "1"
				 elsif pixel_col=col1+14 then
							char <= "00111101"; -- "="
				 elsif pixel_col=col1+15 then
							char <= "00110001"; -- "1"
				 elsif pixel_col=col1+16 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+17 then
							char <= "01010011"; -- "S"
				 elsif pixel_col=col1+18 then
							char <= "01010111"; -- "W"
				 elsif pixel_col=col1+19 then
							char <= "00110001"; -- "1"
				 elsif pixel_col=col1+20 then
							char <= "00111101"; -- "="
				 elsif pixel_col=col1+21 then
							char <= "00110000"; -- "0"
				 else
							char <= "00100000"; -- space
				 end if;
				 
			elsif pixel_row = 10 then
			
				 if pixel_col=col1+13 then
							char <= "01001011"; -- "K"
				 elsif pixel_col=col1+14 then
							char <= "01000010"; -- "B"
				 elsif pixel_col=col1+15 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+16 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+17 then
							char <= "01001011"; -- "K"
				 elsif pixel_col=col1+18 then
							char <= "01010000"; -- "P"
				 elsif pixel_col=col1+19 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+20 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+21 then
							char <= "01001101"; -- "M"
				 elsif pixel_col=col1+22 then
							char <= "01101111"; -- "o"
				 elsif pixel_col=col1+23 then
							char <= "01100100"; -- "d"
				 elsif pixel_col=col1+24 then
							char <= "01100101"; -- "e"
				 else
							char <= "00100000"; -- space
				 end if;
				
			elsif pixel_row = 12 then
			
				 if pixel_col=col1+13 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+14 then
							char <= "01010111"; -- "W"
				 elsif pixel_col=col1+15 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+16 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+17 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+18 then
							char <= "00110010"; -- "2"
				 elsif pixel_col=col1+19 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+20 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+21 then
							char <= "01000110"; -- "F"
				 elsif pixel_col=col1+22 then
							char <= "01010111"; -- "W"
				 else
							char <= "00100000"; -- space
				 end if;
			
			elsif pixel_row = 13 then
			
				 if pixel_col=col1+13 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+14 then
							char <= "01000001"; -- "A"
				 elsif pixel_col=col1+15 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+16 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+17 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+18 then
							char <= "00110100"; -- "4"
				 elsif pixel_col=col1+19 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+20 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+21 then
							char <= "01000110"; -- "F"
				 elsif pixel_col=col1+22 then
							char <= "01000110"; -- "F"
				 elsif pixel_col=col1+23 then
							char <= "01010111"; -- "W"
				 else
							char <= "00100000"; -- space
				 end if;
				 
			elsif pixel_row = 14 then
			
				 if pixel_col=col1+13 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+14 then
							char <= "01011010"; -- "Z"
				 elsif pixel_col=col1+15 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+16 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+17 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+18 then
							char <= "00111000"; -- "8"
				 elsif pixel_col=col1+19 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+20 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+21 then
							char <= "01000010"; -- "B"
				 elsif pixel_col=col1+22 then
							char <= "01010111"; -- "W"
				 else
							char <= "00100000"; -- space
				 end if;
				 
			elsif pixel_row = 15 then
			
				 if pixel_col=col1+13 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+14 then
							char <= "01010011"; -- "S"
				 elsif pixel_col=col1+15 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+16 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+17 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+18 then
							char <= "00110110"; -- "6"
				 elsif pixel_col=col1+19 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+20 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+21 then
							char <= "01000110"; -- "F"
				 elsif pixel_col=col1+22 then
							char <= "01000010"; -- "B"
				 elsif pixel_col=col1+23 then
							char <= "01010111"; -- "W"
				 else
							char <= "00100000"; -- space
				 end if;
				 
			elsif pixel_row = 16 then
			
				 if pixel_col=col1+12 then
							char <= "01010011"; -- "S"
				 elsif pixel_col=col1+13 then
							char <= "01000010"; -- "B"
				 elsif pixel_col=col1+14 then
							char <= "01000001"; -- "A"
				 elsif pixel_col=col1+15 then
							char <= "01010010"; -- "R"
				 elsif pixel_col=col1+16 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+17 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+18 then
							char <= "00110000"; -- "0"
				 elsif pixel_col=col1+19 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+20 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+21 then
							char <= "01010011"; -- "S"
				 elsif pixel_col=col1+22 then
							char <= "01110100"; -- "t"
				 elsif pixel_col=col1+23 then
							char <= "01101111"; -- "o"
				 elsif pixel_col=col1+24 then
							char <= "01110000"; -- "p"
				 else
							char <= "00100000"; -- space
				 end if;
				 
			elsif pixel_row = 17 then
			
				 if pixel_col=col1+13 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+14 then
							char <= "00110001"; -- "1"
				 elsif pixel_col=col1+15 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+16 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+17 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+18 then
							char <= "00110001"; -- "1"
				 elsif pixel_col=col1+19 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+20 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+21 then
							char <= "01000001"; -- "A"
				 elsif pixel_col=col1+22 then
							char <= "01110101"; -- "u"
				 elsif pixel_col=col1+23 then
							char <= "01110100"; -- "t"
				 elsif pixel_col=col1+24 then
							char <= "01101111"; -- "o"
				 else
							char <= "00100000"; -- space
				 end if;
				 
			elsif pixel_row = 19 then
			
				 if pixel_col=col1+13 then
							char <= "01010010"; -- "R"
				 elsif pixel_col=col1+14 then
							char <= "01100101"; -- "e"
				 elsif pixel_col=col1+15 then
							char <= "01110011"; -- "s"
				 elsif pixel_col=col1+16 then
							char <= "01100101"; -- "e"
				 elsif pixel_col=col1+17 then
							char <= "01110100"; -- "t"
				 elsif pixel_col=col1+18 then
							char <= "00101100"; -- ","
				 elsif pixel_col=col1+19 then
							char <= "00100000"; -- "SPACE"
				 elsif pixel_col=col1+20 then
							char <= "01010011"; -- "S"
				 elsif pixel_col=col1+21 then
							char <= "01010111"; -- "W"
				 elsif pixel_col=col1+22 then
							char <= "00110010"; -- "2"
				 elsif pixel_col=col1+23 then
							char <= "00111101"; -- "="
				 elsif pixel_col=col1+24 then
							char <= "00110001"; -- "1"
				 else
							char <= "00100000"; -- space
				 end if;
			end if;
	end process;

end Behavioral;