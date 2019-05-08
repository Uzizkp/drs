----------------------------------------------------------------------------------
-- sheet 4 exercise 1.3
-- Kuangpu Zhang, Tianyang Liu
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity ex1_3 is 
port(
	a,b,c,d: in std_logic_vector (3 downto 0);
	ctrl: in std_logic;

	sum: out std_logic_vector (3 downto 0) 
);
end ex1_3;

-- behavioral description
architecture impl of ex1_3 is
begin
process(a,b,c,d)
begin
if ctrl = '0' then
	sum <= a+b;
elsif ctrl = '1' then
	sum <= c+d;
end if;
end process;
end architecture;

-- dataflow description
architecture impl2 of ex1_3 is 
begin 
	sum <= a+b when ctrl = '0';
	sum <= c+d when ctrl = '1';
end architecture;
