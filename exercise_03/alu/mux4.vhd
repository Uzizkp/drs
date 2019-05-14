entity mux is
port(
  a,b,c,d: in  bit_vector(31 downto 0);
  s:       in  bit_vector( 1 downto 0);
  o:       out bit_vector(31 downto 0)
);
end entity;

architecture impl of mux is
begin

with s select o <=
  a when "00",
  b when "01",
  c when "10",
  d when "11";

end architecture;
