----------------------------------------------------------------------------------
-- sheet 5 exercise 2
-- Kuangpu Zhang, Tianyang Liu
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.phys_quan.all;

entity testbench2 is
end entity;

architecture tb of testbench2 is
	signal a,b: length;
	signal result: area;
begin
	stim: process
	begin
		a <= 2.1 inch;
		b <= 1.5 inch;
		result <= a * b;
		wait for 10 ns;
	
		a <= 1 cm;
		b <= 3.5 mm;
		result <= a * b;
		wait for 10 ns;

		a <= 1 mm;
		b <= 24 inch;
		result <= a * b;
		wait for 10 ns;

		a <= 5 m - 4 yard + 1 inch - 5 mm;
		b <= 1 inch - 2.5 cm;
		result <= a * b;
		wait for 10 ns;

		a <= 3 cm;
		b <= 4 foot;
		result <= a * b;
		wait for 10 ns;
		report "the result of 3 cm * 4 foot is negtive, since it's out of range" severity note;
		report "m2 = 1e+12 which is out of range, and foot2 is lager, so they are not useful units in the physical type for area" severity note;
		
			
	end process;
end;