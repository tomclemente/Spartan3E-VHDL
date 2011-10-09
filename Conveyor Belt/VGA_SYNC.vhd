----------------------------------------------------------------------------------
-- Module Name:    VGA_SYNC - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- VGA Video Sync generation

entity VGA_SYNC is
	Port(clock_50Mhz, red, green, blue		: 		in	std_logic;
		  red_out, green_out, blue_out, horiz_sync_out, vert_sync_out,pixel_clock	: out	std_logic;
		  pixel_row, pixel_column			: out std_logic_vector(9 downto 0));

end VGA_SYNC;

architecture Behavioral of VGA_SYNC is
	signal horiz_sync, vert_sync 			: std_logic;
	signal video_on, video_on_v, video_on_h : std_logic;
	signal h_count, v_count 				: std_logic_vector(9 downto 0);
	signal clock_25mhz : std_logic;
	
begin

-- generate a 25Mhz clock
process (clock_50mhz)
begin
  if clock_50mhz 'event and clock_50mhz='1' then
    if (clock_25mhz = '0') then
      clock_25mhz <= '1';
    else
      clock_25mhz <= '0';
    end if;
  end if;
end process;

 video_on <= video_on_H and video_on_V;

--Generate Horizontal and Vertical Timing Signals for Video Signal

process
begin
	wait until(clock_25Mhz 'event) and (clock_25Mhz='1');

	if (h_count = 799) then
   		h_count <= "0000000000";
	else
   		h_count <= h_count + 1;
	end if;

	--Generate Horizontal Sync Signal using H_count
	if (h_count <= 755) and (h_count >= 659) then
 	  	horiz_sync <= '0';
	else
 	  	horiz_sync <= '1';
	end if;

	if (v_count >= 524) and (h_count >= 699) then
   		v_count <= "0000000000";
	elsif (h_count = 699) then
   		v_count <= v_count + 1;
	end if;

		-- Generate Vertical Sync Signal using V_count
	if (v_count <= 494) and (v_count >= 493) then
   		vert_sync <= '0';
	else
  		vert_sync <= '1';
	end if;

		-- Generate Video on Screen Signals for Pixel Data
	if (h_count <= 639) then
   		video_on_h <= '1';
   		pixel_column <= h_count;
	else
	   	video_on_h <= '0';
	end if;

	if (v_count <= 479) then
   		video_on_v <= '1';
   		pixel_row <= v_count;
	else
   		video_on_v <= '0';
	end if;

		red_out 	<= red and video_on;
		green_out <= green and video_on;
		blue_out <= blue and video_on;
		horiz_sync_out <= horiz_sync;
		vert_sync_out <= vert_sync;
		pixel_clock<=clock_25mhz;

end process;

end Behavioral;