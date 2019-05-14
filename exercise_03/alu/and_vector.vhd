entity and_vector is
port(
  a, b: in  bit_vector(31 downto 0);
  o:    out bit_vector(31 downto 0)
);
end entity;

architecture impl of and_vector is
begin
  o <= a and b;
end architecture;
