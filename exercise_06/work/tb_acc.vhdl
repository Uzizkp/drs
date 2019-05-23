library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.acc_pkg.all;

entity tb_acc is
end entity;

architecture impl of tb_acc is
  signal clk   : std_ulogic := '0';
  signal instr : instruction;
  signal din   : std_ulogic_vector(31 downto 0);

  signal status: acc_status;
  signal addr  : std_ulogic_vector(7 downto 0);
  signal fout  : std_ulogic_vector(31 downto 0);

  -- define clock period
  constant clk_period : time:= 10 ns;

begin
  acc_uut: entity work.acc
  port map(
    clk => clk,
    instr => instr,
    din => din,

    status => status,
    addr => addr,
    dout => fout
    );
  mem_uut: entity work.mem
  port map(
    addr => addr,
    dout => din
  );
  -- clok process
  clk_process :process
  begin
  	clk <= '0';
  	wait for clk_period/2;
  	clk <= '1';
  	wait for clk_period/2;
  end process;

  stim: process

  begin
    wait until status = finished;
    for idx in 0 to 7 loop

      instr <= test_instructions(idx);
      wait until status = idle;
      wait until status = finished;
      report "instruction No." & integer'image(idx) & ":  " & integer'image(to_integer(unsigned(fout)));
    end loop;

  end process;
end architecture;
