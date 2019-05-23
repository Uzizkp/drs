----------------------------------------------------------------------------------
-- sheet 6 exercise 1 fifo
-- Kuangpu Zhang, Tianyang Liu
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--fifo entity
entity fifo is
	generic(addr_bits, data_bits : positive);
	port (
		-- inputs
		clk : in std_ulogic;
		reset : in std_ulogic;
		din : in std_ulogic_vector(n-1 downto 0);
		wr_en, rd_en : in std_ulogic;	-- write and read

		-- outputs
		full, empty : out std_ulogic;
		dout : out std_ulogic_vector(n-1 downto 0);
		level : out natural -- number of content
		);
end fifo;

-- fifo implement
architecture impl of fifo is
	type ram_type is array(d-1 downto 0) of std_ulogic_vector(n-1 downto 0);
begin
	process(clk, din, wr_en, rd_en)
	variable words: ram_type;
	variable head : natural range 0 to d-1;
	variable tail : natural range 0 to d-1;
	variable num :  natural := 0;

	begin
		if (rising_edge(clk)) then
			-- clears the FIFO content if equal to '1'
			if (reset='1') then
				head := 0;
				tail := 0;
				full <= '0';
				empty <= '1';
				num := 0;
			else
				-- if fifo is full, wr_en is ignored
				if (num /= d) then
					if (wr_en = '1') then
						words(head) := din;
						num := num + 1;
						empty <= '0';
						if (head = d-1) then
							head :=0;
						else
 							head := head + 1;
						end if;
					end if;
				elsif (num = d) then
						full <= '1';
						report "memory is full, can't write more" severity warning;
				end if;
				-- if fifo is empty, rd_en is ignored
				if (num /= 0) then
					if (rd_en = '1') then
						dout <= words(tail);
						num := num -1;
						full <= '0';
						if (tail = d-1) then
							tail :=0;
						else
							tail := tail + 1;
						end if;
					end if;
				elsif (num = 0) then
					empty <= '1';
					report "memory is empty, can't read more" severity warning;
				end if;
			end if;
			-- display the number of fifp content
			level <= num;
		end if;
	end process;
end architecture;
