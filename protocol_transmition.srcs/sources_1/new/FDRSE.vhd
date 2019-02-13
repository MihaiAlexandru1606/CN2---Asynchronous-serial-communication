----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2018 11:56:18
-- Design Name: 
-- Module Name: FDRSE - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FDRSE is
    Port (
        D : in std_logic;
        CE : in std_logic;
        C : in std_logic;
        R : in std_logic;
        S : in std_logic;
        Q : out std_logic
      );
end FDRSE;

architecture Behavioral of FDRSE is

begin

    process(C)
    begin
        if (C'event and C = '1') then
            if R = '1' then
                Q <= '0';
            else
                if S = '1' then
                    Q <= '1';
                else
                    if CE = '1' then 
                        Q  <= D;
                    end if;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
