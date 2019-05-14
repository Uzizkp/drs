library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity testbench is
end testbench;

architecture behavior of testbench is

    -- Component Declaration for the Unit Under Test (UUT)
    component toplevel
    port(
         clk : IN  std_logic;
         en : IN  std_logic;
         ivld : IN  std_logic;
         mask : IN  std_logic_vector(63 downto 0);
         din : IN  std_logic_vector(63 downto 0);
         ovld : OUT  std_logic;
         dout : OUT  std_logic_vector(63 downto 0)
        );
    end component;

   --Inputs
   signal clk : std_logic := '0';
   signal en : std_logic := '0';
   signal ivld : std_logic := '0';
   signal mask : std_logic_vector(63 downto 0) := (others => '0');
   signal din : std_logic_vector(63 downto 0) := (others => '0');

    --Outputs
   signal ovld : std_logic;
   signal dout : std_logic_vector(63 downto 0);

   -- Clock period definitions
   constant clk_period : time := 5 ns;

begiN

    -- Instantiate the Unit Under Test (UUT)
   uut: toplevel port map (
          clk => clk,
          en => en,
          ivld => ivld,
          mask => mask,
          din => din,
          ovld => ovld,
          dout => dout
        );

   -- Clock process definitions
   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;


   -- Stimulus process
   stim_proc: process
   begin
      ivld <= '0';
      en   <= '0';
      mask <= CONV_std_logic_vector(0, 64);
      wait for 100 ns;

      en   <= '1';
      wait for clk_period*10;

      ivld <= '1';
      din  <= CONV_std_logic_vector(1, 64);
      wait for clk_period;

      din  <= CONV_std_logic_vector(42, 64);
      wait for clk_period;

      din  <= CONV_std_logic_vector(12, 64);
      wait for clk_period;

      din  <= CONV_std_logic_vector(34, 64);
      wait for clk_period;

      din  <= CONV_std_logic_vector(234, 64);
      wait for clk_period;

      din  <= CONV_std_logic_vector(86, 64);
      wait for clk_period;

      ivld <= '0';
      en <= '0';
   end process;

end;
