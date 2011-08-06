--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.1i
--  \   \         Application : ISE
--  /   /         Filename : twb_test.vhw
-- /___/   /\     Timestamp : Fri Jul 29 10:11:07 2011
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: twb_test
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library SFR;
use SFR.SHIFT.all;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY twb_test IS
END twb_test;

ARCHITECTURE testbench_arch OF twb_test IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT test
        PORT (
            mode : In std_logic_vector (1 DownTo 0);
            shiftinput : In std_logic;
            inputshift : In std_logic_vector (7 DownTo 0);
            outputshift : Out std_logic_vector (7 DownTo 0)
        );
    END COMPONENT;

    SIGNAL mode : std_logic_vector (1 DownTo 0) := "10";
    SIGNAL shiftinput : std_logic := '1';
    SIGNAL inputshift : std_logic_vector (7 DownTo 0) := "00010000";
    SIGNAL outputshift : std_logic_vector (7 DownTo 0) := "00000000";

    BEGIN
        UUT : test
        PORT MAP (
            mode => mode,
            shiftinput => shiftinput,
            inputshift => inputshift,
            outputshift => outputshift
        );

        PROCESS
            BEGIN
                -- -------------  Current Time:  100ns
                WAIT FOR 100 ns;
                shiftinput <= '0';
                inputshift <= "00000001";
                -- -------------------------------------
                -- -------------  Current Time:  200ns
                WAIT FOR 100 ns;
                shiftinput <= '1';
                inputshift <= "00000010";
                -- -------------------------------------
                -- -------------  Current Time:  300ns
                WAIT FOR 100 ns;
                shiftinput <= '0';
                inputshift <= "00000011";
                -- -------------------------------------
                -- -------------  Current Time:  400ns
                WAIT FOR 100 ns;
                shiftinput <= '1';
                inputshift <= "00000100";
                -- -------------------------------------
                -- -------------  Current Time:  500ns
                WAIT FOR 100 ns;
                shiftinput <= '0';
                inputshift <= "00000101";
                -- -------------------------------------
                -- -------------  Current Time:  600ns
                WAIT FOR 100 ns;
                shiftinput <= '1';
                inputshift <= "00000110";
                -- -------------------------------------
                -- -------------  Current Time:  700ns
                WAIT FOR 100 ns;
                shiftinput <= '0';
                inputshift <= "00000111";
                -- -------------------------------------
                -- -------------  Current Time:  800ns
                WAIT FOR 100 ns;
                shiftinput <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  900ns
                WAIT FOR 100 ns;
                shiftinput <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1000ns
                WAIT FOR 100 ns;
                shiftinput <= '1';

            END PROCESS;

    END testbench_arch;

