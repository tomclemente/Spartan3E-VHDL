----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:18:59 08/27/2011 
-- Design Name: 
-- Module Name:    SUBTRACTOR - Structural 
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

entity SUBTRACTOR is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           Borrow_out : out  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end SUBTRACTOR;

architecture Structural of SUBTRACTOR is

component FullSubtractor is
    Port ( X : in  STD_LOGIC;
           Y : in  STD_LOGIC;
           Borrow_in : in  STD_LOGIC;
           Borrow_out : out  STD_LOGIC;
           Difference : out  STD_LOGIC);
end component;

signal out_sig,borrow_sig: std_logic_vector(7 downto 0);
begin

FS0: FullSubtractor port map ( X => op1(0),
										 Y => op2(0),
										 Borrow_in => '0',
										 Borrow_out => borrow_sig(0),
										 Difference => out_sig(0));
									
GEN1:
	for i in 1 to 7 generate
		begin
			FS1: FullSubtractor port map ( X => op1(i),
													 Y => op2(i),
													 Borrow_in => borrow_sig(i-1),
													 Borrow_out => borrow_sig(i),
													 Difference => out_sig(i));
	end generate;
	
	output <= out_sig;
	Borrow_out <= borrow_sig(7);

end Structural;

