library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity H1 is
    Port (
            D : in std_logic_vector(7 downto 0);
            PARITATE : out std_logic
        );
end H1;

architecture Behavioral of H1 is

begin

    PARITATE <= xor D;
    
end Behavioral;