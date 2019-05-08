----------------------------------------------------------------------------------
-- sheet 4 exercise 1.1
-- Kuangpu Zhang, Tianyang Liu
----------------------------------------------------------------------------------
-- this library is used for others tasks 
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
port(
	a,b: in std_logic; -- input number a and b
	cin: in std_logic; -- 

	s:   out std_logic;-- sum
	cout:out std_logic -- 
);
end full_adder;

--dataflow description
architecture impl_dd of full_adder is
begin
	s <= a xor b xor cin;
	cout <= (a and b) or (cin and a) or (cin and b);	
end architecture;

--behavioral description
architecture impl_bd of full_adder is
begin
full_adder:process(a,b,cin)
begin
if (a='0' and b='0' and cin='0') then
	s <= '0';
	cout <= '0';
elsif (a='0' and b='0' and cin='1') then
	s <= '1';
	cout <= '0';
elsif (a='0' and b='1' and cin='0') then
	s <= '1';
	cout <= '0';	
elsif (a='1' and b='0' and cin='0') then
	s <= '1';
	cout <= '0';	
elsif (a='0' and b='1' and cin='1') then
	s <= '0';
	cout <= '1';	
elsif (a='1' and b='0' and cin='1') then
	s <= '0';
	cout <= '1';
elsif (a='1' and b='1' and cin='0') then
	s <= '0';
	cout <= '1';	
elsif (a='1' and b='1' and cin='1') then
	s <= '1';
	cout <= '1';		
end if;
end process;
end architecture;
