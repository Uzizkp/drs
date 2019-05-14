entity sub_vector is
port(
  a, b: in  bit_vector(31 downto 0);
  o:    out bit_vector(31 downto 0)
);
end entity;

library ieee;
use ieee.numeric_bit.all;

architecture impl of sub_vector is
begin
  o <= bit_vector(unsigned(a) - unsigned(b));
end architecture;
