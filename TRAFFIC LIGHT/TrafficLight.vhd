----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:02:39 08/19/2011 
-- Design Name: 
-- Module Name:    TrafficLight - Behavioral 
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

entity TrafficLight is
    Port ( Clk : in  STD_LOGIC;
			  Clk_out: out STD_LOGIC;
           Sensor : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Highway : out  STD_LOGIC_VECTOR (2 downto 0);
           Farm : out  STD_LOGIC_VECTOR (2 downto 0));
end TrafficLight;

architecture Structural of TrafficLight is
signal sig1: STD_LOGIC;

component ClockGen 
	PORT(clk_in : IN std_logic;
		clk_out : OUT std_logic);
	
end component;

component ControlUnit 
    Port ( clk_in : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Sensor : in  STD_LOGIC;
           Highway : out  STD_LOGIC_VECTOR (2 downto 0);
           Farm : out  STD_LOGIC_VECTOR (2 downto 0));
end component;
begin
	Clk_out<=sig1;
	A0: Clockgen port map (Clk, sig1);
	A1: ControlUnit port map (sig1, Reset, Sensor, Highway, Farm);


end Structural;

