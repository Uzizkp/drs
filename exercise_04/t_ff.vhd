----------------------------------------------------------------------------------
-- sheet 4 exercise 2.1 T-FF with an asyncronous reset signal
-- Kuangpu Zhang, Tianyang Liu 
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity tff is
port (
	T     :in  std_logic; 
        clk   :in  std_logic; 
        reset :in  std_logic; 
        q     :out std_logic;
	qb    :out std_logic
    );
end entity;

architecture impl of tff is
signal tmp :std_logic;
begin
process (T,clk, reset) 
begin
        if (reset = '1') then
                tmp <= '0';
        elsif (rising_edge(clk)) then
		if (T = '0') then
		tmp <= tmp;
		elsif (T = '1') then
		tmp <= not tmp;
		end if;
        end if;
end process;
q <= tmp;
qb <= not tmp;
end architecture;