----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Geraldine Granada
-- 
-- Create Date:    13:08:51 08/22/2011 
-- Design Name: 
-- Module Name:    ROM - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
    Port ( memIn : in  STD_LOGIC_VECTOR (7 downto 0);
           instOut : out  STD_LOGIC_VECTOR (15 downto 0);
           ROMen : in  STD_LOGIC);
end ROM;

architecture Behavioral of ROM is
	type ROM_LUT is array (0 to 76) of std_logic_vector (15 downto 0);
	constant INST: ROM_LUT := (

		0 => x"CB00",  --1100 1 011 0000 0000", --LI 		DX <= x00
		1 => x"2803",  --0010 1 000 0000 0011", --AND		AX <= AX && DX
		2 => x"2913",  --0010 1 001 0001 0011", --AND 		BX <= BX && DX
		3 => x"2A23",  --0010 1 010 0010 0011", --AND 		CX <= CX && DX
		4 => x"2C43",  --0010 1 100 0100 0011", --AND 		EX <= EX && DX
		5 => x"2D53",  --0010 1 101 0101 0011", --AND 		FX <= FX && DX
		6 => x"2E63",  --0010 1 110 0110 0011", --AND 		GX <= GX && DX
		7 => x"2F73",  --0010 1 111 0111 0011", --AND 		HX <= HX && DX
		8 => x"C805",  --1100 1 000 0000 0101", --LI 		AX <= x05
		9 => x"CB04",  --1100 1 011 0000 0100", --LI		DX <= x04
		10 => x"2003", --0010 0 000 0000 0011", --ROR		AX <= AX ror DX
		11 => x"CB64", --1100 1 011 0110 0100", --LI		DX <= x64
		12 => x"7703", --0111 0 111 0000 0011", --GTE		HX <= AX gte DX	
		13 => x"CA01", --1100 1 010 0000 0001", --LI		CX <= x01
		14 => x"4172", --0100 0 001 0111 0010", --XOR		BX <= HX xor CX
		15 => x"9913", --1001 1 001 0001 0011", --BNE		if BX == 1, PC 1<= x13 (line 19)
		16 => x"CB14", --1100 1 011 0001 0100", --LI		DX <= x14
		17 => x"5003", --0101 0 000 0000 0011", --SUB		AX <= AX sub DX
		18 => x"B80B", --1011 1 000 0000 1011", --J			J to x0B (line 11)
		19 => x"CB01", --1100 1 011 0000 0001", --LI		DX <= x01
		20 => x"2903", --0010 1 001 0000 0011", --AND		BX <= AX && DX
		21 => x"B81A", --1011 1 000 0001 1010", --J			J to x1A (line 26)
		22 => x"CB02", --1100 1 011 0000 0010", --LI		DX <= x02
		23 => x"9003", --1001 0 000 0000 0011", --DIV		AX <= AX/DX
		24 => x"CA1D", --1100 1 010 0001 1101", --LI		CX <= x1D 
		25 => x"C002", --1100 0 000 0000 0010", --JR		PC <= CX (line 29)
		26 => x"991D", --1001 1 001 0001 1101", --BNE		if BX == 1 then PC <= x1D (line 29)
		27 => x"CA16", --1100 1 010 0001 0110", --LI		CX <= x16 
		28 => x"C022", --1100 0 000 0010 0010", --JR		PC <= CX (line 22)
		29 => x"D800", --1101 1 000 0000 0000", --STORE		Mx00 <= AX
		30 => x"CB09", --1100 1 011 0000 1001", --LI		DX <= x09
		31 => x"7D03", --0111 1 101 0000 0011", --LTE		FX <= AX lte DX
		32 => x"3D50", --0011 1 101 0101 0000", --NOT		FX <= not FX
		33 => x"CA01", --1100 1 010 0000 0001", --LI		CX <= x01
		34 => x"2D52", --0010 1 101 0101 0010", --AND		FX <= FX && CX
		35 => x"D400", --1101 0 100 0000 0000", --LD		EX <= Mx00
		36 => x"6A52", --0110 1 010 0101 0010", --EQ		CX <= FX eq CX
		37 => x"9A28", --1001 1 010 0010 1000", --BNE		if CX == 1 PC <= x28 (line 40)
		38 => x"8C04", --1000 1 100 0000 0100", --MULT		EX <= AX mult EX
		39 => x"B81D", --1011 1 000 0001 1101", --J			J to x1D (line 29)
		40 => x"C900", --1100 1 001 0000 0000", --LI		BX <= x00
		41 => x"DA01", --1101 1 010 0000 0001", --STORE		Mx01 <= CX              --change bx to cx
		42 => x"C903", --1100 1 001 0000 0011", --LI		BX <= x03
		43 => x"CA01", --1100 1 010 0000 0001", --LI 		CX <= x01
		44 => x"1C42", --0001 1 100 0100 0010", --ROL		EX <= EX rol CX
		45 => x"2B42", --0010 1 011 0100 0010", --AND		DX <= EX && CX
		46 => x"3663", --0011 0 110 0110 0011", --OR		GX <= GX or DX
		47 => x"1662", --0001 0 110 0110 0010", --SL		GX <= GX sl CX 
		48 => x"CB05", --1100 1 011 0000 0101", --LI		DX <= x05
		49 => x"7563", --0111 0 101 0110 0011", --GTE		FX <= GX gte DX
		50 => x"CA35", --1100 1 010 0011 0101", --LI		CX <= x35
		51 => x"B502", --1011 0 101 0000 0010", --BER		if FX == 0 then PC <= CX (line 53)
		52 => x"4E61", --0100 1 110 0110 0001", --ADD		GX <= GX + BX
		53 => x"CDF0", --1100 1 101 1111 0000", --LI		FX <= xF0
		54 => x"CD04", --1100 1 011 0000 0100", --LI		DX <= x04
		55 => x"CF01", --1100 1 111 0000 0001", --LI		HX <= X01
		56 => x"2D65", --0010 1 101 0110 0101", --AND		FX <= GX && FX
		57 => x"0557", --0000 0 101 0101 0111", --SRL		FX <= FX srl HX
		58 => x"CF03", --1100 1 111 0000 0011", --LI		HX <= x03
		59 => x"0D57", --0000 1 101 0101 0111", --SRA		FX <= FX sra HX
		60 => x"6253", --0110 0 010 0101 0011", --GT		CX <= FX gt DX
		61 => x"C901", --1100 1 001 0000 0001", --LI		BX <= x01
		62 => x"8121", --1000 0 001 0010 0001", --NE		BX <= CX ne BX
		63 => x"CF43", --1100 1 111 0100 0011", --LI		HX <= x43
		64 => x"A907", --1010 1 001 0000 0111", --BNER		if BX == 1 PC <= HX (line 67)
		65 => x"C930", --1100 1 001 0011 0000", --LI		BX <= x30
		66 => x"4E61", --0100 1 110 0110 0001", --ADD		GX <= GX + BX
		67 => x"C8FE", --1100 1 000 1111 1110", --LI		AX <= xFE
		68 => x"2C40", --0010 1 100 0100 0000", --AND		EX <= EX && AX
		69 => x"D101", --1101 0 001 0000 0001", --LD		BX <= Mx01
		70 => x"CA01", --1100 1 010 0000 0001", --LI		CX <= x01
		71 => x"4912", --0100 1 001 0001 0010", --ADD		BX <= BX + CX
		72 => x"CF01", --1100 1 111 0000 0001", --LI		HX <= x01
		73 => x"5F17", --0101 1 111 0001 0111", --LT		HX <= BX lt HX
		74 => x"A74C", --1010 0 111 0100 1100", --BE		if HX == 0 PC <= x4C (line 76)
		75 => x"B829", --1011 1 000 0010 1001", --J			J to x29 (line 41)
		76 => x"DE02", --1101 1 110 0000 0010", --STORE		Mx02 <= GX  
		OTHERS => X"FFFF" 
	); 

begin

	rproc: process(ROMen, memIn) 
	begin
		if(ROMen = '1') then
			instOut <= INST(conv_integer(memIn));
		else
			instOut <= "ZZZZZZZZZZZZZZZZ";
		end if;
	end process;
end Behavioral;

