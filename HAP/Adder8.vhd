----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:11:32 09/14/2011 
-- Design Name: 
-- Module Name:    Adder8 - Structural 
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

entity Adder8 is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0);
           C_out : out  STD_LOGIC);
end Adder8;

architecture Structural of Adder8 is

signal carry_sig, temp: std_logic_vector(7 downto 0);

component Full_adder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           C_in : in  STD_LOGIC;
           Sum : out  STD_LOGIC;
           C_out : out  STD_LOGIC);
end component;

begin

FA1: Full_adder port map ( A => op1(0),
								  B => op2(0),
								  C_in => '0',
								  Sum => temp(0),
								  C_out => carry_sig(0));
								  
GEN1:
	for x in 1 to 7 generate
			FA2: Full_adder port map (A=>op1(x),
											  B=>op2(x),
											  C_in=>carry_sig(x-1),
											  Sum=>temp(x),
											  C_out=>carry_sig(x));
	end generate;

C_out<=carry_sig(7);
output<=temp;

end Structural;


