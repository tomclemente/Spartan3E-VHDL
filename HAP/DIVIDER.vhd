----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:47:54 08/31/2011 
-- Design Name: 
-- Module Name:    DIVIDER - Structural 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DIVIDER is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
			  Borrow_out : out STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end DIVIDER;

architecture Structural of DIVIDER is

component SUBTRACTOR is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           Borrow_out : out  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal a0,a1,a2,a3,a4,a5,a6,a7 : STD_LOGIC_VECTOR(7 downto 0);
signal b0,b1,b2,b3,b4,b5,b6,b7 : STD_LOGIC_VECTOR(7 downto 0);
signal tempquotient: STD_LOGIC_VECTOR(7 downto 0);
signal bout : STD_LOGIC_VECTOR(7 downto 0);
signal res0,res1,res2,res3,res4,res5,res6,res7 : STD_LOGIC_VECTOR(7 downto 0);
signal width : STD_LOGIC_VECTOR(2 downto 0);
signal tempop2 : STD_LOGIC_VECTOR(3 downto 0);
signal tempout : STD_LOGIC_VECTOR(7 downto 0);

begin

--INITIALIZE--
tempop2 <= op2(3 downto 0);                                     
a0 <= op1;

--SHIFTED DIVISOR--
b0 <= tempop2(0) & "0000000" when std_match(tempop2,"0001") else
	   tempop2(1 downto 0) & "000000" when std_match(tempop2,"001-") else
	   tempop2(2 downto 0) & "00000" when std_match(tempop2,"01--") else
	   tempop2(3 downto 0) & "0000" when std_match(tempop2,"1---");
b1 <= '0' & b0(7 downto 1);
b2 <= "00" & b0(7 downto 2);
b3 <= "000" & b0(7 downto 3);
b4 <= "0000" & b0(7 downto 4);
b5 <= "00000" & b0(7 downto 5);
b6 <= "000000" & b0(7 downto 6);
b7 <= "0000000" & b0(7);

--WIDTH OF DIVISOR--
width <= "001" when std_match(tempop2,"0001") else
		   "010" when std_match(tempop2,"001-") else
	      "011" when std_match(tempop2,"01--") else
	      "100" when std_match(tempop2,"1---");

--REPEATED SUBTRACTION--
SUB0: SUBTRACTOR PORT MAP(op1 => a0,
								  op2 => b0,
								  Borrow_out => bout(0),
								  output => res0);

a1 <= res0 when bout(0) = '0' else a0;
tempquotient(7) <= not bout(0);

SUB1: SUBTRACTOR PORT MAP(op1 => a1,
								  op2 => b1,
								  Borrow_out => bout(1),
								  output => res1);

a2 <= res1 when bout(1) = '0' else a1;
tempquotient(6) <= not bout(1);

SUB2: SUBTRACTOR PORT MAP(op1 => a2,
								  op2 => b2,
								  Borrow_out => bout(2),
								  output => res2);

a3 <= res2 when bout(2) = '0' else a2;
tempquotient(5) <= not bout(2);

SUB3: SUBTRACTOR PORT MAP(op1 => a3,
								  op2 => b3,
								  Borrow_out => bout(3),
								  output => res3);

a4 <= res3 when bout(3) = '0' else a3;
tempquotient(4) <= not bout(3);

SUB4: SUBTRACTOR PORT MAP(op1 => a4,
								  op2 => b4,
								  Borrow_out => bout(4),
								  output => res4);

a5 <= res4 when bout(4) = '0' else a4;
tempquotient(3) <= not bout(4);

SUB5: SUBTRACTOR PORT MAP(op1 => a5,
								  op2 => b5,
								  Borrow_out => bout(5),
								  output => res5);

a6 <= res5 when bout(5) = '0' else a5;
tempquotient(2) <= not bout(5);

SUB6: SUBTRACTOR PORT MAP(op1 => a6,
								  op2 => b6,
								  Borrow_out => bout(6),
								  output => res6);

a7 <= res6 when bout(6) = '0' else a6;
tempquotient(1) <= not bout(6);

SUB7: SUBTRACTOR PORT MAP(op1 => a7,
								  op2 => b7,
								  Borrow_out => bout(7),
								  output => res7);

Borrow_out <= '1' when tempop2 = "0000" else '0';
tempquotient(0) <= not bout(7);

tempout <= "000" & tempquotient(7 downto 3) when width = "100" else
			  "00" & tempquotient(7 downto 2) when width = "011" else
			  "0" & tempquotient(7 downto 1) when width = "010" else
			  tempquotient when width = "001";
			  
output <= "11111111" when tempop2 = "0000" else tempout;		  
end Structural;

