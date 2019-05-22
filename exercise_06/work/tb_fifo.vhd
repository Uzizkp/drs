----------------------------------------------------------------------------------
-- sheet 6 exercise 1 tb_fifo
-- Kuangpu Zhang, Tianyang Liu
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- tb entity
entity tb_fifo is
end entity;

-- tb implement
architecture impl of tb_fifo is

	-- the width n and depth d of fifo
	constant n :positive := 8;
	constant d :positive := 6;

	-- input signals
	signal clk : std_ulogic;
	signal reset : std_ulogic := '0';
	signal din : std_ulogic_vector(n-1 downto 0);
	signal wr_en, rd_en : std_ulogic := '0';

	-- output signals
	signal full, empty : std_ulogic := '0';
	signal dout : std_ulogic_vector(n-1 downto 0);
	signal level : natural := 0;

	-- define clock period
	constant clk_period : time:= 10 ns;

begin
	-- uut
	uut: entity work.fifo
	generic map(
		n => n,
		d => d
		)
	port map(
		clk => clk,
		reset => reset,
		din => din,
		wr_en => wr_en,
		rd_en => rd_en,

		full => full,
		empty => empty,
		dout => dout,
		level => level
		);

	-- clok process
	clk_process :process
	begin
		clk <= '0';
		wait for clk_period/2;

		clk <= '1';
		wait for clk_period/2;
	end process;

	-- reset process
	rst_process :process
	begin
		reset <= '0';
		-- reset the fifo memory
		wait for clk_period * 8;
		reset <= '1';
		wait for clk_period;
		reset <= '0';
		wait;
	end process;

	-- write process
	wr_process :process
	variable counter : unsigned(7 downto 0) := (others => '0');
	begin
		-- generate din before reset
		for i in 1 to d loop
			counter := counter + 1;
			din <= std_ulogic_vector(counter);
			wait for clk_period;
			wr_en <= '1';
			wait for clk_period;
			wr_en <= '0';
		end loop;
		-- generate din after reset
		for i in 1 to d loop
			counter := counter + 1;
			din <= std_ulogic_vector(counter);
			wait for clk_period;
			wr_en <= '1';
			wait for clk_period;
			wr_en <= '0';
		end loop;
		wait;
	end process;

	-- read process
	rd_process :process
	variable counter : unsigned(7 downto 0) := (others => '0');
	begin
		wait for clk_period * 30;
		for i in 1 to d loop
			rd_en <= '1';
			wait for clk_period;
			rd_en <= '0';
			wait for clk_period;
		end loop;
		wait;
	end process;

end architecture;
