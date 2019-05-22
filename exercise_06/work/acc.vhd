----------------------------------------------------------------------------------
-- sheet 6 exercise 2 fifo
-- Kuangpu Zhang, Tianyang Liu
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.acc_pkg.all;

entity acc is
  port(
    clk   : in std_ulogic;
    instr : buffer instruction;
    din   : buffer std_ulogic_vector(31 downto 0);

    status: buffer acc_status;
    addr  : out std_ulogic_vector(7 downto 0);
    dout  : out std_ulogic_vector(31 downto 0)
    );
end acc;

architecture impl of acc is
  signal sum : std_ulogic_vector(31 downto 0);

  begin
  acc_loop: for i in 1 to instr.length generate
    uut: entity work.mem
    port map(
      instr.addr => addr,
      dout => din
    );
    instr.addr <= instr.addr + 1;
    sum <= sum + din;
    status <= 'finished';
  end generate when (rising_eadge(clk) and status = 'idle');
  dout <= sum

end architecture;
