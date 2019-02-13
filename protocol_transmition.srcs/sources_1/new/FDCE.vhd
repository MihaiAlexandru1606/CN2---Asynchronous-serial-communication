----------------------------------------------------------------------------------
-- Nume : Niculescu
-- Prenume : Mihai Alexandru
-- Grupa : 335CB
--
-- Project : transmiterea si receptionarea datelor asincron
-- File : fdce.vhd
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FDCE is
    Port (
            D : in std_logic;
            CE : in std_logic;
            C : in std_logic;
            CLR : in std_logic;
            Q : out std_logic
           );
end FDCE;

architecture Behavioral of FDCE is

begin

    process(CLR, CE, D, C)
    begin
    
        if CLR = '1' then
            Q <= '0';
        elsif (C' event and C = '1') then
            Q <= D;
        end if;
    end process;

end Behavioral;
