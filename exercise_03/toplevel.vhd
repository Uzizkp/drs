--Kuangpu Zhang ,Tianyang Liu
-- the synatx error happend in line 84
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity toplevel is
    port (
        -- clock input
        clk  : in  std_logic;

        -- input ports
        en   : in  std_logic;
        ivld : in  std_logic;
        mask : in  std_logic_vector (63 downto 0);
        din  : in  std_logic_vector (63 downto 0);

        -- output ports
        ovld : out std_logic;
        dout : out std_logic_vector (63 downto 0)
    );
end toplevel;

architecture rtl of toplevel is

    signal masked_data_sig : std_logic_vector (63 downto 0);
    signal hashed_data_sig : std_logic_vector (63 downto 0);
    signal hashed_data_vld_sig : std_logic;

    signal mult_op1_sig : signed(31 downto 0);
    signal mult_op2_sig : signed(31 downto 0);

    constant PIPE : integer := 6;
    type regbank6x64 is array(PIPE-1 downto 0) of SIGNED(63 downto 0);
    signal mult_pipe   : regbank6x64;
    signal mult_result : signed(63 downto 0);

    signal mult_vld_reg : std_logic_vector(PIPE-1 downto 0) := (others => '0');

    component hash_int64 is
       port(
          clk  : in  std_logic;
          en   : in  std_logic;
          ivld : in  std_logic;
          din  : in  std_logic_vector(63 downto 0);
          ovld : out std_logic;
          dout : out std_logic_vector(63 downto 0)
       );
    end component;

begin
    masked_data_sig <= (din xor mask);

    hash_int64_instance : hash_int64
        port map(
            clk  => clk,
            en   => en,
            ivld => ivld,
            din  => masked_data_sig,
            ovld => hashed_data_vld_sig,
            dout => hashed_data_sig
        );

    mult_op1_sig <= signed(hashed_data_sig(63 downto 32));
    mult_op2_sig <= signed(hashed_data_sig(31 downto 0));

    -- pipelined 32x32 multiplier
    mult_pipe(0) <= (mult_op1_sig * mult_op2_sig);
    regbank_proc : for i in 1 to PIPE-1 generate
    begin
        process (CLK) begin
            if (rising_edge(CLK)) then
                if (en = '1') then
                    mult_pipe(i) <= mult_pipe(i-1);
                end if;
            end if;
        end process;
    end generate;

    mult_vld_reg(0) <= hashed_data_vld_sig;
    process (CLK) begin
        if (rising_edge(CLK)) then
            if (en = '1') then
                mult_vld_reg(PIPE-1 downto 1) <= mult_vld_reg(PIPE-2 downto 0);
            end if;
        end if;
    end process;

    ovld <= mult_vld_reg(PIPE-1);
    dout <= CONV_std_logic_vector(mult_pipe(PIPE-1), 64);

end;
