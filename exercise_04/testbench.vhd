----------------------------------------------------------------------------------
-- sheet 4 exercise 1.4.2
-- Kuangpu Zhang, Tianyang Liu
-- Error : 
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity testbench is
end testbench;

architecture impl of testbench is
constant bwidth : integer := 16;
component arb_sized_adder is
generic ( bitwidth :integer:=bwidth );
port (  a: in std_logic_vector (bitwidth-1 downto 0);
	b: in std_logic_vector (bitwidth-1 downto 0);
	cin: in std_logic;
	s: out std_logic_vector (bitwidth-1 downto 0);
	cout: out std_logic);
end component;

signal  a: std_logic_vector (bwidth-1 downto 0) := (others => '0');
signal  b: std_logic_vector (bwidth-1 downto 0) := (others => '0');
signal  cin: std_logic := '0';
signal  s: std_logic_vector (bwidth-1 downto 0);
signal  cout: std_logic; 

begin
uut: arb_sized_adder 
generic map (bitwidth => bwidth)
port map(a=>a,
	b=>b,
	cin=>cin,
	s=>s,
	cout=>cout);

stim: process
begin
a <= std_logic_vector(to_unsigned(1, a'length));
b <= std_logic_vector(to_unsigned(1, b'length));
cin <= '0';
wait for 50 ns;

a <= std_logic_vector(to_unsigned(1024, a'length));
b <= std_logic_vector(to_unsigned(32, b'length));
cin <= '0';
wait for 50 ns;

a <= std_logic_vector(to_unsigned(65535, a'length));
b <= std_logic_vector(to_unsigned(1, b'length));
cin <= '0';
wait for 50 ns;

a <= std_logic_vector(to_unsigned(65535, a'length));
b <= std_logic_vector(to_unsigned(65535, b'length));
cin <= '0';
wait for 50 ns;

a <= std_logic_vector(to_unsigned(123, a'length));
b <= std_logic_vector(to_unsigned(987, b'length));
cin <= '0';
wait for 50 ns;

a <= std_logic_vector(to_unsigned(5, a'length));
b <= std_logic_vector(to_unsigned(18, b'length));
cin <= '0';
wait for 50 ns;

end process;
end architecture;
