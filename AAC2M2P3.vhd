library ieee;
use ieee.std_logic_1164.all;

entity FSM is
port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end FSM;

-- architecture

architecture Arch_FSM of FSM is
	type state_type is (A, B, C);
	signal PS, NS : state_type;
begin
	sync_proc : process(RST, CLK, NS)
	begin
		-- take care of the asynchrounous input
		if (RST = '1') then
			PS <= A;
		elsif (rising_edge(CLK)) then
			PS <= NS;
		end if;
	end process sync_proc;
	
	comb_proc : process(PS,In1)
	begin
		Out1 <= '0'; -- pre-assign output
		case PS is
			when A =>
				Out1 <= '0'; -- Moore output
				if (In1 = '1') then NS <= B;
				else NS <= A;
				end if;
			when B =>
				Out1 <= '0'; -- Moore output
				if (In1 = '0') then NS <= C;
				else NS <= B;
				end if;
			when C =>
				Out1 <= '1'; -- Moore output
				if (In1 = '1') then NS <= A;
				else NS <= C;
				end if;
		end case;
	end process comb_proc;
end Arch_FSM;