----------------------------------------------------------------------------------
-- sheet 4 exercise 2.1 D-FF with an asyncronous reset signal
-- Kuangpu Zhang, Tianyang Liu 
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity d_ff is 
port(   
	clk :in std_logic;  
	reset: in std_logic;  
	d :in  std_logic;
	q : out std_logic    
   );
end d_ff;

architecture impl of d_ff is  
begin  
process(clk,reset)
begin 
	if(reset='0') then 
	q <= '0';
	elsif (rising_edge(clk)) then 
	q <= d; 
	end if;       
end process;  
end architecture;