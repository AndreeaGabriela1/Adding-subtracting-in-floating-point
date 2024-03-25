library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity SSD is
  Port ( clk: in STD_LOGIC;
         reset: in STD_LOGIC;
         data: in STD_LOGIC_VECTOR (31 downto 0); 
         an: out STD_LOGIC_VECTOR (7 downto 0);  
         cat: out STD_LOGIC_VECTOR (7 downto 0));  
end SSD;

architecture Behavioral of SSD is
constant CNT_100HZ : integer := 2**20;                 
signal Num         : integer range 0 to CNT_100HZ - 1 := 0;
signal NumV        : STD_LOGIC_VECTOR (19 downto 0) := (others => '0');    
signal led_selection: STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
signal hex: STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
begin

divizare_clk: process (Clk)
    begin
    if (clk'event and clk = '1') then
        if (reset = '1') then
            Num <= 0;
        elsif (Num = CNT_100HZ - 1) then
            Num <= 0;
        else
            Num <= Num + 1;
        end if;
    end if;
    end process;

    NumV <= CONV_STD_LOGIC_VECTOR (Num, 20);
    led_selection <= NumV (19 downto 17);
    
-- Selectia anodului activ
    an <= "11111110" when led_selection = "000" else
          "11111101" when led_selection = "001" else
          "11111011" when led_selection = "010" else
          "11110111" when led_selection = "011" else
          "11101111" when led_selection = "100" else
          "11011111" when led_selection = "101" else
          "10111111" when led_selection = "110" else
          "01111111" when led_selection = "111" else
          "11111111";
          
-- Selectia cifrei active
    hex <= data (3 downto 0) when led_selection = "000" else
        data (7 downto 4) when led_selection = "001" else
        data (11 downto 8) when led_selection = "010" else
        data (15 downto 12) when led_selection = "011" else
        data (19 downto 16) when led_selection = "100" else
        data (23 downto 20) when led_selection = "101" else
        data (27 downto 24) when led_selection = "110" else
        data (31 downto 28) when led_selection = "111" else
        X"0";
        
-- Activarea/dezactivarea segmentelor cifrei active
    cat <= "11111001" when hex = "0001" else            -- 1
           "10100100" when hex = "0010" else            -- 2
           "10110000" when hex = "0011" else            -- 3
           "10011001" when hex = "0100" else            -- 4
           "10010010" when hex = "0101" else            -- 5
           "10000010" when hex = "0110" else            -- 6
           "11111000" when hex = "0111" else            -- 7
           "10000000" when hex = "1000" else            -- 8
           "10010000" when hex = "1001" else            -- 9
           "10001000" when hex = "1010" else            -- A
           "10000011" when hex = "1011" else            -- b
           "11000110" when hex = "1100" else            -- C
           "10100001" when hex = "1101" else            -- d
           "10000110" when hex = "1110" else            -- E
           "10001110" when hex = "1111" else            -- F
           "11000000";                                  -- 0
                   
end Behavioral;
