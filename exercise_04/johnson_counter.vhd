----------------------------------------------------------------------------------
-- sheet 4 exercise 2.2 and 2.3 Johnson Counter using D-FF
-- Kuangpu Zhang, Tianyang Liu 
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity johnson_counter is
generic( bitwidth : integer);
port(
	clk: in std_logic;
	rst: in std_logic;
	q: out std_logic_vector(bitwidth-1 downto 0)
);
end johnson_counter;

-- dataflow description
architecture impl_dd of johnson_counter is
component d_ff is
port (
	clk :in std_logic;  
	reset: in std_logic;  
	d :in  std_logic;
	q : out std_logic    
);
end component;

signal 	q_tmp: std_logic_vector(bitwidth-1 downto 0);
signal  q_init: std_logic;

begin  
u_0: d_ff port map (clk, rst, q_init, q_tmp(0));

g: for i in 1 to bitwidth-1 generate
	u_i: d_ff port map (clk, rst, q_tmp(i-1), q_tmp(i));
end generate;
q_init <= q_tmp(bitwidth-1);
q <= q_tmp;

end architecture;

-- behavioral description
architecture impl_bd of johnson_counter is

signal q_tmp : std_logic_vector(bitwidth-1 downto 0);

begin
process(clk,rst,q_tmp)
	begin
	q_tmp(0) <= not q_tmp(bitwidth-1);
	for i in bitwidth-1 downto 1 loop
		if (rst = '1') then
		q_tmp(i) <= '0';
		elsif (rising_edge(clk)) then
		q_tmp(i) <= q_tmp(i-1);
		end if;
	end loop;
end process;
q <= q_tmp;
end architecture;
