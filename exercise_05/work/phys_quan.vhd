----------------------------------------------------------------------------------
-- sheet 5 exercise 2
-- Kuangpu Zhang, Tianyang Liu
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

package phys_quan is
type length is range integer'low to integer'high
	units
		um;
		mm = 1e3 um;
		cm = 10 mm;
		m = 100 cm;
		inch = 25400 um;
		foot = 12 inch;
		yard = 3 foot;
	end units;

type area is range integer'low to integer'high
	units	
		um2;
		cm2 = 1e8 um2;
		inch2 = 64516 cm2;
		m2 = 1550 inch2;
	end units;

-- overload the operator "*"
function "*" (l,r : length) return area;
end phys_quan;

package body phys_quan is
	function "*" (l,r : length) return area is
	begin
		return area'val(length'pos(l)*length'pos(r));
	end function;
end;


