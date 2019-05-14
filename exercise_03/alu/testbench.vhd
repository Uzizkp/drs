entity testbench is
end entity;

library ieee;
use ieee.numeric_bit.all;

architecture tb of testbench is
  component alu
  port(
    a,b: in  bit_vector(31 downto 0);
    s:   in  bit_vector( 1 downto 0);
    o:   out bit_vector(31 downto 0)
  );
  end component;

  signal a,b,o: bit_vector(31 downto 0);
  signal s:     bit_vector( 1 downto 0);
begin

test: process
begin
  wait for 2 ns;
  report "Test s=00";
  a <= bit_vector(to_unsigned(5, 32));
  b <= bit_vector(to_unsigned(9, 32));
  s <= "00";
  wait for 2 ns;
  assert to_integer(unsigned(o)) = 14
    report "s=00 does not produce correct addition"
    severity failure;

  wait for 2 ns;
  report "Test s=01";
  a <= bit_vector(to_unsigned(9, 32));
  b <= bit_vector(to_unsigned(5, 32));
  s <= "01";
  wait for 2 ns;
  assert to_integer(unsigned(o)) = 4
    report "s=01 does not produce correct subtraction"
    severity failure;

  wait for 2 ns;
  report "Test s=10";
  a <= x"0f0f0f0f";
  b <= x"aaaaaaaa";
  s <= "10";
  wait for 2 ns;
  assert o = x"0a0a0a0a"
    report "s=10 does not produce correct and"
    severity failure;

  wait for 2 ns;
  report "Test s=11";
  a <= x"0a0a0a0a";
  b <= x"b0b0b0b0";
  s <= "11";
  wait for 2 ns;
  assert o = x"babababa"
    report "s=11 does not produce correct or"
    severity failure;

  wait for 2 ns;
  report "Success";
  wait;
end process;

dut: alu port map(a => a, b => b, o => o, s => s);

end architecture;
