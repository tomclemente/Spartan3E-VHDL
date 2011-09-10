----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:14:56 08/27/2011 
-- Design Name: 
-- Module Name:    FullSubtractor - Dataflow 
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

entity FullSubtractor is
    Port ( X : in  STD_LOGIC;
           Y : in  STD_LOGIC;
           Borrow_in : in  STD_LOGIC;
           Borrow_out : out  STD_LOGIC;
           Difference : out  STD_LOGIC);
end FullSubtractor;

architecture Dataflow of FullSubtractor is

begin

Difference <= (X XOR Y) XOR Borrow_in;
Borrow_out <= ((NOT X) AND (Y XOR Borrow_in)) OR (Y AND Borrow_in);

end Dataflow;

