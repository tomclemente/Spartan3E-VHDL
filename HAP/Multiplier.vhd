----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:34:34 09/01/2011 
-- Design Name: 
-- Module Name:    Multiplier - Structural 
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

entity Multiplier is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end Multiplier;

architecture Structural of Multiplier is

component Adder8 is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0);
           C_out : out  STD_LOGIC);
end component;

signal MA1, MA2, MA3, MB1, MB2, MB3: std_logic_vector (7 downto 0);
signal ag_a3b0,ag_a2b0,ag_a1b0,ag_a3b1,ag_a2b1,ag_a1b1,ag_a0b1: std_logic;
signal ag_a3b2,ag_a2b2,ag_a1b2,ag_a0b2: std_logic;
signal ag_a3b3,ag_a2b3,ag_a1b3,ag_a0b3: std_logic;
signal tempout1, tempout2, tempout3, tempout4: std_logic_vector(7 downto 0);
signal carry1, carry2, carry3: std_logic;

begin

-----1st level

output(0) <= op1(0) and op2(0);

ag_a3b0 <= op1(3) and op2(0);
ag_a2b0 <= op1(2) and op2(0);
ag_a1b0 <= op1(1) and op2(0);

MA1 <= "00000" & ag_a3b0 & ag_a2b0 & ag_a1b0;

ag_a3b1 <= op1(3) and op2(1); 
ag_a2b1 <= op1(2) and op2(1);
ag_a1b1 <= op1(1) and op2(1);
ag_a0b1 <= op1(0) and op2(1);

MB1 <= "0000" & ag_a3b1 & ag_a2b1 & ag_a1b1 & ag_a0b1;

Addblock1: Adder8 port map( op1 => MA1,
									op2 => MB1,
									output => tempout1,
									C_out => carry1);

------2nd level 

output(1) <= tempout1(0);

MA2<= "0000" & (tempout1(4 downto 1));

ag_a3b2 <= op1(3) and op2(2); 
ag_a2b2 <= op1(2) and op2(2);
ag_a1b2 <= op1(1) and op2(2);
ag_a0b2 <= op1(0) and op2(2);

MB2 <= "0000" & ag_a3b2 & ag_a2b2 & ag_a1b2 & ag_a0b2;

Addblock2: Adder8 port map(op1 => MA2,
									op2 => MB2,
									output => tempout2,
									C_out => carry2);

--------3rd level

output(2) <= tempout2(0);

MA3<= "0000" & (tempout2(4 downto 1));

ag_a3b3 <= op1(3) and op2(3); 
ag_a2b3 <= op1(2) and op2(3);
ag_a1b3 <= op1(1) and op2(3);
ag_a0b3 <= op1(0) and op2(3);

MB3 <= "0000" & ag_a3b3 & ag_a2b3 & ag_a1b3 & ag_a0b3;

Addblock3: Adder8 port map(op1 => MA3,
									op2 => MB3,
									output => tempout3,
									C_out => carry3);

-----Product

output(7 downto 3) <= tempout3(4 downto 0);

end Structural;

