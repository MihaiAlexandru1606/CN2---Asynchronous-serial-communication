----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2018 18:42:33
-- Design Name: 
-- Module Name: x74_194 - Behavioral
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

entity x74_194 is
    Port(
           SLI : in std_logic;
           A : in std_logic;
           B : in std_logic;
           C : in std_logic;
           D : in std_logic;
           SRI : in std_logic;
           S0: in std_logic;
           S1 : in std_logic;
           CK : in std_logic;
           CLR : in std_logic;
           QA : out std_logic;
           QB : out std_logic;
           QC : out std_logic;
           QD : out std_logic
         );
end x74_194;

architecture Behavioral of x74_194 is

signal A_buffer, B_buffer, C_buffer, D_buffer : std_logic;

begin

    process(CK, CLR)
    begin
        
        if (CLR = '1' ) then
        A_buffer <= '0';
        B_buffer <= '0'; 
        C_buffer <= '0'; 
        D_buffer <= '0'; 
        else
            if(CK' event and CK = '1') then
            
                if (S1 = '1' and S0 = '1') then
                A_buffer <= A; 
                B_buffer <= B; 
                C_buffer <= C; 
                D_buffer <= D; 
                end if;
                
                if (S1 = '0' and S0 = '1') then
                A_buffer <= SRI; 
                B_buffer <= A_buffer;
                C_buffer <= B_buffer;
                D_buffer <= C_buffer; 
                end if;
                
                if (S1 = '1' and S0 = '0') then
                A_buffer <= B_buffer;
                B_buffer <= C_buffer;
                C_buffer <= D_buffer;
                D_buffer <= SLI;
                end if;
                
            end if; 
        end if;
    end process;
    
    QA <= A_buffer;
    QB <= B_buffer;
    QC <= C_buffer;
    QD <= D_buffer;

end Behavioral;
