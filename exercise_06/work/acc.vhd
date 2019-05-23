----------------------------------------------------------------------------------
-- sheet 6 exercise 2 acc
-- Kuangpu Zhang, Tianyang Liu
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.acc_pkg.all;

entity acc is
  port(
    clk   : in std_ulogic;
    instr : in instruction;
    din   : in std_ulogic_vector(31 downto 0);

    status: out acc_status;
    addr  : out std_ulogic_vector(7 downto 0);
    dout  : out std_ulogic_vector(31 downto 0)
    );
end acc;

architecture impl of acc is

  signal acc : unsigned(31 downto 0) := (others => '0');
  signal state : acc_status := idle;
  signal current_addr : unsigned(7 downto 0) := (others => '0');
  signal counter : unsigned(7 downto 0) := (others => '0');

begin
  status <= state;
  addr <= std_ulogic_vector(current_addr);
  dout <= std_ulogic_vector(acc);

  main: process
  begin
    wait until rising_edge(clk);
    case state is
    when idle =>
      state <= busy;
      current_addr <= to_unsigned(instr.addr,current_addr'length);
      counter <= to_unsigned(instr.length, counter'length);
    when busy =>
      if (counter > 0) then
        counter <= counter - 1;
        current_addr <= current_addr + 1;
        acc <= acc + unsigned(din);
      else
        state <= finished;
      end if;
    when finished =>
      state <= idle;
      acc <= (acc'range => '0');
    end case;
  end process;

end architecture;
