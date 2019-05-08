----------------------------------------------------------------------------------
-- sheet 4 exercise 2.1 JK-FF with an asyncronous reset signal
-- Kuangpu Zhang, Tianyang Liu 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity jk_ff is 
port (
	j: in std_logic;
	k: in std_logic;
	clk: in std_logic;	
	asyn_reset: in std_logic;
	q: out std_logic;
	q_bar: out std_logic);
end jk_ff;

architecture impl of jk_ff is
begin
process(j,k,clk,asyn_reset)
begin
	if (asyn_reset = '1') then
        q <= '0';
	q_bar <= '0';
        elsif (rising_edge(clk)) then
		if (j/=k) then
		q <= j;
		q_bar <= not j;
		elsif (j='1' and k='1') then
        	-- signal doesn't change
		q <= not j; 	
		q_bar <= j;	
		end if;
        end if;
end process;
end architecture;