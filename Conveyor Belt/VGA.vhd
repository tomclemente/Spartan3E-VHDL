----------------------------------------------------------------------------------
-- Module Name:    VGA - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity VGA is
	Port ( Clock					: 	in std_logic;
			 vga_r,vga_g,vga_b	:	out std_logic;
			 vga_hs,vga_vs		:	out std_logic
		  );
end VGA;

architecture Behavioral of VGA is
	
	-------character ROM
	component ROMReal is
		port(	character_address	:	in std_logic_vector(7 downto 0);
				font_row,font_col	:	in std_logic_vector(2 downto 0);
				rom_mux_output		:	out std_logic);
	end component;
	
	--------vga_sync
	component vga_sync is
		port(	clock_50mhz,red,green,blue	:	in std_logic;
				red_out,green_out,blue_out	:	out std_logic;
				horiz_sync_out,vert_sync_out:	out std_logic;
				pixel_row					:	out std_logic_vector(9 downto 0);
				pixel_column				:	out std_logic_vector(9 downto 0));
	end component;

	---------character location
	component RAM is
	port ( pixel_row, pixel_col 	: 	in std_logic_vector(9 downto 4);
		    char 					   : 	out std_logic_vector(7 downto 0));
	end component;

	signal pixel_roww 				: 	std_logic_vector(9 downto 0);
	signal pixel_columnn 			: 	std_logic_vector(9 downto 0);
	signal rom_mux						:	std_logic;
	signal red,green,blue			:	std_logic;
	signal red_in,green_in,blue_in 	:  	std_logic;
	signal char_add 				: 	std_logic_vector(7 downto 0);
begin
	vga: vga_sync port map(Clock, red_in, green_in, blue_in,
								   red, green, blue, vga_hs, vga_vs,
							      pixel_roww, pixel_columnn);
	
	char: ROMReal port map(char_add, pixel_roww(3 downto 1), pixel_columnn(3 downto 1), rom_mux);
	
	value: RAM port map ( pixel_roww(9 downto 4), pixel_columnn(9 downto 4), char_add);
	
	with red select
		vga_r		<=	'1' when '1',
					 	'0' when others;
	with green select
		vga_g	<=	'1' when '1',
					'0' when others;
	with blue select
		vga_b	<=	'1' when '1',
					'0' when others;

	process (pixel_roww(9 downto 4), pixel_columnn(9 downto 4))
	begin
	
		if (pixel_roww(9 downto 4) = 2) then
			if rom_mux = '1' then
				red_in		<=	'0';	--CYAN
				green_in	<=	'1';
				blue_in		<=	'1';
			else
				red_in		<=	'0';
				green_in	<=	'0';
				blue_in		<=	'0';
			end if;
		elsif (pixel_roww(9 downto 4) = 4) then
			if rom_mux = '1' then
				red_in		<=	'1';	--YELLOW
				green_in	<=	'1';
				blue_in		<=	'0';
			else
				red_in		<=	'0';
				green_in	<=	'0';
				blue_in		<=	'0';
			end if;
		elsif (pixel_roww(9 downto 4) = 6) then
			if rom_mux = '1' then
				red_in		<=	'0';	--GREEN
				green_in	<=	'1';
				blue_in		<=	'0';
			else
				red_in		<=	'0';
				green_in	<=	'0';
				blue_in		<=	'0';
			end if;
		elsif (pixel_roww(9 downto 4) = 8) or (pixel_roww(9 downto 4) = 19) then
			if rom_mux = '1' then
				red_in		<=	'1';	--RED
				green_in	<=	'0';
				blue_in		<=	'0';
			else
				red_in		<=	'0';
				green_in	<=	'0';
				blue_in		<=	'0';
			end if;
		elsif (pixel_roww(9 downto 4) = 10) then
			if rom_mux = '1' then
				red_in		<=	'1';	--MAGENTA
				green_in	<=	'0';
				blue_in		<=	'1';
			else
				red_in		<=	'0';
				green_in	<=	'0';
				blue_in		<=	'0';
			end if;
		elsif (pixel_roww(9 downto 4) = 12) or (pixel_roww(9 downto 4) = 13) or (pixel_roww(9 downto 4) = 14) or (pixel_roww(9 downto 4) = 15) or (pixel_roww(9 downto 4) = 16) or (pixel_roww(9 downto 4) = 17) then
			if rom_mux = '1' then
				red_in		<=	'1';	--WHITE
				green_in	<=	'1';
				blue_in		<=	'1';
			else
				red_in		<=	'0';
				green_in	<=	'0';
				blue_in		<=	'0';
			end if;
		end if;
	end process;
end Behavioral;