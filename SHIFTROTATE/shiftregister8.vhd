LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
use IEEE.std_logic_arith.all
use IEEE.numeric_std.all
ENTITY shiftregister8 IS 
   PORT (sl, sr, clk : IN std_logic; 
         parin : IN std_logic_vector (7 DOWNTO 0);
         m : IN std_logic_vector (1 DOWNTO 0);
         parout : OUT std_logic_vector (7 DOWNTO 0));
END ENTITY;
--
ARCHITECTURE procedural OF shiftregister8 IS
   SIGNAL shift_reg : std_logic_vector (7 DOWNTO 0) := "00000000";
BEGIN
   PROCESS (clk) BEGIN
      IF (clk = '0' AND clk'EVENT) THEN
         CASE m IS
            WHEN "00" => shift_reg <= shift_reg;
            WHEN "01" => shift_reg <= sl & shift_reg (7 DOWNTO 1);
            WHEN "10" => shift_reg <= shift_reg (6 DOWNTO 0) & sr; 
            WHEN "11" => shift_reg <= parin;
            WHEN OTHERS => shift_reg <= "XXXXXXXX";
         END CASE;
      END IF;
   END PROCESS;
   parout <= shift_reg;
END ARCHITECTURE procedural;
