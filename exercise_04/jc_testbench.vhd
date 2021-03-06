library ieee;
use ieee.std_logic_1164.all;

entity jc_testbench is
end jc_testbench;

architecture impl of jc_testbench is 

constant bwidth: integer := 4;

component johnson_counter is
generic (bitwidth: integer := bwidth);
port (
	clk: in std_logic;
	rst: in std_logic;
	q: out std_logic_vector(bitwidth-1 downto 0)
);
end component;

signal clk: std_logic:='0';
signal rst: std_logic:='0';
signal q:   std_logic_vector (bwidth-1 downto 0);
constant clk_period : time := 10 ns;

begin

uut: johnson_counter
generic map (bitwidth => bwidth)
port map (clk => clk, rst => rst, q => q);

clk_process :process
begin
clk <= '0';
wait for clk_period/2;

clk <= '1';
wait for clk_period/2;
end process;

stim: process
begin
wait for 100 ns;
rst <= '1';

wait for 100 ns;
rst <= '0';


end process;
end architecture;


