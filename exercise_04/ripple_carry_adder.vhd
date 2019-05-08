----------------------------------------------------------------------------------
-- sheet 4 exercise 1.2
-- Kuangpu Zhang, Tianyang Liu
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity ripple_carry_adder is
port(
	a,b: in std_logic_vector (3 downto 0); -- 4 bit vector input 
	cin: in std_logic;

	s: out std_logic_vector (3 downto 0);  -- 4 bit vector output sum
	cout: out std_logic
);
end ripple_carry_adder;

architecture impl of ripple_carry_adder is

-- declare the component of 1 bit full adder
component full_adder is
port(
	a,b: in std_logic;
	cin: in std_logic;

	s:   out std_logic;
	cout:out std_logic
);
end component;

-- declare used signals
signal cin1,cin2,cin3: std_logic;

begin
u1: full_adder port map(a(0), b(0), cin, s(0), cin1);
u2: full_adder port map(a(1), b(1), cin, s(1), cin2);
u3: full_adder port map(a(2), b(2), cin, s(2), cin3);
u4: full_adder port map(a(3), b(3), cin, s(3), cout);
end architecture;
