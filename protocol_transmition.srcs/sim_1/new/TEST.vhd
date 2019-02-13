----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2018 06:50:54
-- Design Name: 
-- Module Name: TEST - Behavioral
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

entity TEST is
--  Port ( );
end TEST;

architecture Behavioral of TEST is

    component Transmisia is
        Port (
                D : in std_logic_vector(7 downto 0);
                CEAS : in std_logic;
                START : in std_logic;
                RESET : in std_logic;
                RXRDY : in std_logic;
                DREQ: in std_logic;
                DATE_SERIALE : out std_logic;
                GATA_OPERATIE: out std_logic
          );
    end component Transmisia;

    constant clk_period : time := 10 ns;
    signal clk : std_logic := '0';
    signal date : std_logic_vector(7 downto 0);
    signal date_serie : std_logic;
    signal gata_operatie : std_logic;
    signal reset : std_logic := '1';
    signal rxrdy : std_logic := '0';
    signal dreq : std_logic := '0';
    signal start: std_logic := '0';
    
begin
    clk_process :process
    begin
        clk <= '1';
        wait for clk_period/2;  --for 0.5 ns signal is '0'.
        clk <= '0';
        wait for clk_period/2;  --for next 0.5 ns signal is '1'.
    end process;

    reset_process: process
    begin
        wait for clk_period;
        reset <= '0';
        wait for 150ns;
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for 150ns;
        reset <= '1';    
        wait for clk_period;
        reset <= '0';
        wait for clk_period;
    end process;
    
        
    transmis: Transmisia port map(               
                                  D => date,
                                  CEAS => clk,
                                  START => start,
                                  RESET => reset,
                                  RXRDY => rxrdy,
                                  DREQ => dreq,
                                  DATE_SERIALE => date_serie,
                                  GATA_OPERATIE => gata_operatie
                                  );

    TEST: process
    begin
    wait for clk_period;
        rxrdy <= '1';
        dreq <= '1';
        start <= '1';
        date <= "11000011";    
    wait for 160ns;
        rxrdy <= '1';
        dreq <= '1';
        start <= '1';
        date <= "10001001";    
    wait for 150ns;
    end process;
end Behavioral;
