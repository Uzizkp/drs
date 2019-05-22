
package acc_pkg is
    type instruction is record
        addr: natural range 0 to 255;
        length: natural range 0 to 255;
    end record;

    type acc_status is (idle, finished);

    type instruction_array is array(natural range <>) of instruction;

    constant test_instructions: instruction_array(0 to 7) := (
        (addr =>   5, length =>  20),        -- 0
        (addr => 254, length =>   1),        -- 1
        (addr =>   0, length =>   1),        -- 2
        (addr => 100, length =>  17),        -- 3
        (addr =>  71, length =>   5),        -- 4
        (addr =>   9, length =>  73),        -- 5
        (addr =>  20, length => 191),        -- 6
        (addr =>  42, length =>  42)         -- 7
    );
end package;
