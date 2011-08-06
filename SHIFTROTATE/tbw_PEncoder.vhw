--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.1i
--  \   \         Application : ISE
--  /   /         Filename : tbw_PEncoder.vhw
-- /___/   /\     Timestamp : Sun Jul 31 17:24:28 2011
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: tbw_PEncoder
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY tbw_PEncoder IS
END tbw_PEncoder;

ARCHITECTURE testbench_arch OF tbw_PEncoder IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT PEncoder
        PORT (
            I : In std_logic_vector (3 DownTo 0);
            A : Out std_logic_vector (1 DownTo 0)
        );
    END COMPONENT;

    SIGNAL I : std_logic_vector (3 DownTo 0) := "0000";
    SIGNAL A : std_logic_vector (1 DownTo 0) := "00";

    BEGIN
        UUT : PEncoder
        PORT MAP (
            I => I,
            A => A
        );

        PROCESS
            BEGIN
                -- -------------  Current Time:  100ns
                WAIT FOR 100 ns;
                I <= "1111";
                -- -------------------------------------
                -- -------------  Current Time:  200ns
                WAIT FOR 100 ns;
                I <= "1110";
                -- -------------------------------------
                -- -------------  Current Time:  300ns
                WAIT FOR 100 ns;
                I <= "1101";
                -- -------------------------------------
                -- -------------  Current Time:  400ns
                WAIT FOR 100 ns;
                I <= "1100";
                -- -------------------------------------
                -- -------------  Current Time:  500ns
                WAIT FOR 100 ns;
                I <= "1011";
                -- -------------------------------------
                -- -------------  Current Time:  600ns
                WAIT FOR 100 ns;
                I <= "1010";
                -- -------------------------------------
                -- -------------  Current Time:  700ns
                WAIT FOR 100 ns;
                I <= "1001";
                -- -------------------------------------
                -- -------------  Current Time:  800ns
                WAIT FOR 100 ns;
                I <= "1000";
                WAIT FOR 200 ns;

            END PROCESS;

    END testbench_arch;

