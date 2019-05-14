entity or_vector is
port(
  a, b: in  bit_vector(31 downto 0);
  o:    out bit_vector(31 downto 0)
);
end entity;

architecture impl of or_vector is
begin
  o <= a or b;
end architecture;
