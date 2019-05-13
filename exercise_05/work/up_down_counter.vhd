-- Synchronous Up/Down Counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity up_down_counter is
port(
	clk:   in  std_logic;
	reset: in  std_logic;
	load:  in  std_logic;
	din:   in  std_logic_vector(7 downto 0);
	up:    in  std_logic;
	count: out std_logic_vector(7 downto 0));
end entity;


architecture behav of up_down_counter is
	signal count_reg: unsigned(7 downto 0) := (others => '0');
	signal decr: unsigned(7 downto 0) := (others => '0');
begin

decr <= to_unsigned(1,8) when count_reg /= 0 else
        to_unsigned(0,8);

main: process(clk)
begin
	if rising_edge(clk) then
		if reset = '1' then
			count_reg <= to_unsigned(0, 8);
		elsif load = '1' then
			count_reg <= unsigned(din);
		elsif up = '1' then
			count_reg <= count_reg + 1;
		else
			count_reg <= count_reg - decr;
		end if;
	end if;
end process;

count <= std_logic_vector(count_reg);

end architecture;
