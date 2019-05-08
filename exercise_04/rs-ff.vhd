----------------------------------------------------------------------------------
-- sheet 4 exercise 2.1 RS-FF with an asyncronous reset signal
-- Kuangpu Zhang, Tianyang Liu 
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity rs_ff is
port (
	r     :in  std_logic; 
        s     :in  std_logic;
	clk   :in  std_logic;	 
        asyn_reset :in  std_logic; 
        q     :out std_logic;
	q_bar :out std_logic  

    );
end entity;

architecture impl of rs_ff is
signal t :std_logic;
begin
process (s, r, clk, asyn_reset) 
begin
        if (asyn_reset = '1') then
        q <= '0';
	q_bar <= '0';
        elsif (rising_edge(clk)) then
		if (s/=r) then
		q <= s;
		q_bar <= r;
		elsif (s='1' and r='1') then
        	-- signal doesn't change
		q <= 'Z'; 	
		q_bar <= 'Z';	
		end if;
        end if;
end process;
q <= t;
end architecture;