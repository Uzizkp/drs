-- Testbench

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity;

architecture tb of testbench is
	signal clk: std_logic := '0';

	signal din, count: std_logic_vector(7 downto 0) := (others => '0');
	signal reset, load, up: std_logic := '0';

begin

clk <= not clk after 1 ns;


uut: entity work.up_down_counter
port map(
	clk => clk,
	reset => reset,
	load => load,
	din => din,
	up => up,
	count => count
);

main: process
begin
	-- Put your stimulus and assertions here!
	-- test 1
	reset <= '1';
	load  <= '1';
	din   <= std_logic_vector(to_unsigned(90, din'length));
	up    <= '1';

	wait until rising_edge(clk);
	wait for 1 ns;
	if count /= std_logic_vector(to_unsigned(0, din'length)) then
		assert false report "test 1 failed" severity error;
	end if;	
	
	-- test 2
	reset <= '0';
	load  <= '1';
	din   <= std_logic_vector(to_unsigned(18, din'length));
	up    <= '1';
	wait until rising_edge(clk);
	wait for 1 ns;
	if count /= std_logic_vector(to_unsigned(18, din'length)) then
		assert false report "test 2 failed" severity error;
	end if;	

	-- test 3
	reset <= '0';
	load  <= '1';
	din   <= std_logic_vector(to_unsigned(255, din'length));
	up    <= '1';
	wait until rising_edge(clk);
	load  <= '0';
	wait until rising_edge(clk);
	wait for 1 ns;
	if count /= std_logic_vector(to_unsigned(0, din'length)) then
		assert false report "test 3 failed" severity error;
	end if;

	reset <= '0';
	load  <= '1';
	din   <= std_logic_vector(to_unsigned(0, din'length));
	up    <= '0';
	wait until rising_edge(clk);
	load  <= '0';
	wait until rising_edge(clk);
	wait for 1 ns;
	if count /= std_logic_vector(to_unsigned(255, din'length)) then
		assert false report "test 3 failed" severity error;
	end if;
			
	
	-- test 4
	reset <= '0';
	load  <= '1';
	din   <= std_logic_vector(to_unsigned(22, din'length));
	up    <= '0';
	wait until rising_edge(clk);	
	load  <= '0';
	wait until rising_edge(clk);
	wait for 1 ns;
	if count /= std_logic_vector(to_unsigned(21, din'length)) then
		assert false report "test 4 failed" severity error;
	end if;	

	up    <= '1';
	wait until rising_edge(clk);
	wait for 1 ns;
	if count /= std_logic_vector(to_unsigned(22, din'length)) then
		assert false report "test 4 failed" severity error;
	end if;	

end process;


end architecture;
