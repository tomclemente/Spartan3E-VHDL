----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:30:43 08/30/2011 
-- Design Name: 
-- Module Name:    GPR2 - Behavioral 
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

entity GPR is
    Port ( DataIn : in  STD_LOGIC_VECTOR (7 downto 0);
           --Immediate : in  STD_LOGIC_VECTOR (7 downto 0);
           --DataIn : in  STD_LOGIC_VECTOR (7 downto 0);
           --Opcode : in  STD_LOGIC_VECTOR (4 downto 0);
           RD: in  STD_LOGIC_VECTOR (2 downto 0);
           R1 : in  STD_LOGIC_VECTOR (2 downto 0);
           R2 : in  STD_LOGIC_VECTOR (2 downto 0);
           Read_en : in  STD_LOGIC;
			  Write_en: in STD_LOGIC;
			  Reset: in STD_LOGIC;
           --eGPR : in  STD_LOGIC;
           --enable : in  STD_LOGIC;
           --DataOut : out  STD_LOGIC_VECTOR (7 downto 0);
           dataR1 : out  STD_LOGIC_VECTOR (7 downto 0);
           dataR2: out  STD_LOGIC_VECTOR (7 downto 0));
           --ackGPR : out  STD_LOGIC);
end GPR;

architecture Behavioral of GPR is
	signal AX, BX, CX, DX, EX, FX, GX, HX : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
	signal tempRD: STD_LOGIC_VECTOR (2 downto 0);
begin
	process (DataIn, R1, R2, RD, Write_en, Read_en)
		begin
			if(Reset='1') then
					AX <= "00000000";
					BX <= "00000000";
					CX <= "00000000";
					DX <= "00000000";
					EX <= "00000000";
					FX <= "00000000";
					GX <= "00000000";
					HX <= "00000000";
		
			else
				tempRD <= RD;
				if(Read_en='1' ) then
					case (R1) is
						when "000" =>  DataR1 <= AX;
						when "001" =>  DataR1 <= BX;
						when "010" =>  DataR1 <= CX;
						when "011" =>  DataR1 <= DX;
						when "100" =>  DataR1 <= EX;
						when "101" =>  DataR1 <= FX;
						when "110" =>  DataR1 <= GX;
						when "111" =>  DataR1 <= HX;
						when others =>
					end case;
					
					case (R2) is
						when "000" =>  DataR2 <= AX;
						when "001" =>  DataR2 <= BX;
						when "010" =>  DataR2 <= CX;
						when "011" =>  DataR2 <= DX;
						when "100" =>  DataR2 <= EX;
						when "101" =>  DataR2 <= FX;
						when "110" =>  DataR2 <= GX;
						when "111" =>  DataR2 <= HX;
						when others =>
					end case;
				
		
				
				
				elsif((Write_en='1') ) then
					
					case (RD) is
						when "000" =>  AX <= DataIn;
						when "001" =>  BX <= DataIn;
						when "010" =>  CX <= DataIn;
						when "011" =>  DX <= DataIn;
						when "100" =>  EX <= DataIn;
						when "101" =>  FX <= DataIn;
						when "110" =>  GX <= DataIn;
						when "111" =>  HX <= DataIn;
						when others =>
					end case;
					

				end if;
			
			end if;
		end process;


end Behavioral;

