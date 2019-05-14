----------------------------------------------------------------------------------
-- Company: Technical Computer Science - University of Bonn
-- Engineer: Armin Felke
--
-- Create Date: 17:27:59 04/30/2009
-- Design Name: hash_int64
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity hash_int64 is
   port(
      -- clock input
      clk  : in  std_logic;

      -- input ports
      en   : in  std_logic;
      ivld : in  std_logic;
      din  : in  std_logic_vector(63 downto 0);

      -- output ports
      ovld : out std_logic;
      dout : out std_logic_vector(63 downto 0)
   );
end entity;

architecture rtl of hash_int64 is

    type data_reg_type is array(8 downto 0) of std_logic_vector(63 downto 0);
    signal data_reg : data_reg_type;

    signal temp_reg  : std_logic_vector(55 downto 0);
    signal temp_reg2 : std_logic_vector(59 downto 0);

    signal vld_shift_reg : std_logic_vector(8 downto 0) := (others => '0');

begin
   ovld <= vld_shift_reg(8);

   proc : process(clk)
   begin
      if (clk'EVENT and clk = '1') then
         if (en = '1') then
            vld_shift_reg <= (vld_shift_reg(7 downto 0) & ivld);

            data_reg(0) <= din;
            data_reg(1) <= ((not data_reg(0)) + (data_reg(0)(42 downto 0) & "000000000000000000000"));
            data_reg(2) <= (data_reg(1) xor ("000000000000000000000000" & data_reg(1)(63 downto 24)));
            data_reg(3) <= (data_reg(2) + (data_reg(2)(60 downto 0) & "000"));
            temp_reg    <= data_reg(2)(55 downto 0);
            data_reg(4) <= (data_reg(3) + (temp_reg & "00000000"));
            data_reg(5) <= (data_reg(4) xor ("00000000000000" & data_reg(4)(63 downto 14)));
            data_reg(6) <= (data_reg(5) + (data_reg(4)(61 downto 0) & "00"));
            temp_reg2   <= data_reg(5)(59 downto 0);
            data_reg(7) <= (data_reg(6) + (temp_reg2 & "0000"));
            data_reg(8) <= (data_reg(7) xor (data_reg(7)(35 downto 0) & "0000000000000000000000000000"));
            dout        <= (data_reg(8) + (data_reg(8)(32 downto 0) & "0000000000000000000000000000000"));
         end if;
      end if;
   end process;

-- Algorithm:
-------------
--    public long hash64shift(long key)
--    {
--      key = (~key) + (key << 21); // key = (key << 21) - key - 1;
--      key = key ^ (key >>> 24);
--      key = (key + (key << 3)) + (key << 8); // key * 265
--      key = key ^ (key >>> 14);
--      key = (key + (key << 2)) + (key << 4); // key * 21
--      key = key ^ (key >>> 28);
--      key = key + (key << 31);
--      return key;
--    }

end architecture;
