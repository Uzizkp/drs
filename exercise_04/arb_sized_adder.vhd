----------------------------------------------------------------------------------
-- sheet 4 exercise 1.4.1
-- Kuangpu Zhang, Tianyang Liu
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity arb_sized_adder is
generic (bitwidth :integer);
port (	a: in std_logic_vector (bitwidth-1 downto 0);
	b: in std_logic_vector (bitwidth-1 downto 0);
	cin: in std_logic;
	s: out std_logic_vector (bitwidth-1 downto 0);
	cout: out std_logic);
end arb_sized_adder;

architecture impl of arb_sized_adder is
component full_adder is 
port (	a,b: in std_logic;
	cin: in std_logic;

	s:   out std_logic;
	cout:out std_logic);
end component;

signal cc: std_logic_vector (bitwidth downto 1);

begin
u_0: full_adder port map (a(0), b(0), cin, s(0), cc(1));

g: for i in 1 to bitwidth-1 generate
	u_i: full_adder port map (a(i), b(i), cc(i), s(i), cc(i+1));
end generate;
cout <= cc(bitwidth);

end architecture;
