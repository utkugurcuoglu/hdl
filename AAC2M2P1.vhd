LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 	-- clock
   SR:  in std_logic;  -- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  -- Parallel input
   PE:   in std_logic;  -- Parallel Enable (Load)
   CEP: in std_logic;  -- Count enable parallel input
   CET:  in std_logic; -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);            			
   TC:  out std_logic  -- Terminal Count
);            		
end AAC2M2P1;

architecture Behavioral of AAC2M2P1 is
    signal counter : std_logic_vector(3 downto 0) := "0000"; -- 4-bit counter
    signal RCO : std_logic;
begin
    process (CP, SR)
    begin
        if (SR = '0') then
            counter <= "0000"; -- Synchronous reset when SR is active low
        elsif rising_edge(CP) then
            if (PE = '0') then
                counter <= P;  -- Parallel load when PE is active high
            elsif (CEP = '1' and CET = '1') then
                if (counter = "1111") then
                    counter <= "0000"; -- Reset counter to 0 when it reaches 9
                    RCO <= '0';   -- Set Terminal Count
                else
                    counter <= counter + 1; -- Increment as unsigned
                end if;
            end if;
        end if;
    end process;

    Q <= counter; -- Output the current counter value
    TC <= '1' when counter = "1111" else
          '0';
end Behavioral;
