LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY RAM128_32 IS
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		clock	: IN STD_LOGIC  := '1';
		data	: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren	: IN STD_LOGIC ;
		q	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END RAM128_32;

ARCHITECTURE behavior OF RAM128_32 IS
    TYPE ram_array IS ARRAY (0 TO 127) OF STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL ram_data : ram_array;
BEGIN
    PROCESS (clock)
    BEGIN
        IF rising_edge(clock) THEN
            IF wren = '1' THEN
                -- Write operation
                ram_data(to_integer(unsigned(address))) <= data;
            END IF;
        END IF;
    END PROCESS;

    -- Read operation
    q <= ram_data(to_integer(unsigned(address)));

END behavior;