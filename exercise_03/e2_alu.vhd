----------------------------------------
-- Name: Kuangpu Zhang, Tianyang Liu  --
----------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Declare the alu entity
entity alu is
port(
	-- input port 
	a,b: in bit_vector(31 downto 0);
	s:   in bit_vector( 1 downto 0);
	-- output port 
	o:   out bit_vector(31 downto 0)
);
end alu;

architecture alu_struct of alu is
	-- component alu is
	-- port(
	--   a,b: in bit_vector(31 downto 0);
        --   s:   in bit_vector( 1 downto 0); 
        --   o:   out bit_vector(31 downto 0)
	-- );
	-- end component;

	-- Declare +,-,AND,OR and multiplexer conponents
	component add_vector is
	port(
	  a, b: in  bit_vector(31 downto 0);
	  o:    out bit_vector(31 downto 0)
	);
	end component;

	component sub_vector is
	port(
	  a, b: in  bit_vector(31 downto 0);
	  o:    out bit_vector(31 downto 0)
	);
	end component;

	component and_vector is
	port(
	  a, b: in  bit_vector(31 downto 0);
	  o:    out bit_vector(31 downto 0)
	);
	end component;
	
	component or_vector is
	port(
	  a, b: in  bit_vector(31 downto 0);
	  o:    out bit_vector(31 downto 0)
	);
	end component;

	component mux is
	port(
	  a,b,c,d: in  bit_vector(31 downto 0);
	  s:       in  bit_vector( 1 downto 0);
	  o:       out bit_vector(31 downto 0)
	);
	end component;
	
	-- Declare the signals
	signal x: bit_vector(3 downto 0);
	
	-- There are some errors 
        --'Cannot resolve indexed name (type std.STANDARD.BIT) as type std.STANDARD.BIT_VECTOR'
	Begin
	u0: add_vector port map (a=>a, b=>b, o=>x(0));
	u1: sub_vector port map (a=>a, b=>b, o=>x(1));
	u2: and_vector port map (a=>a, b=>b, o=>x(2));
	u3: or_vector  port map (a=>a, b=>b, o=>x(3));
	u4: mux4       port map (x(0)=>a, 
				 x(1)=>b, 
				 x(2)=>c, 
				 x(3)=>d, 
				 s=>s, o=>o);

end;
