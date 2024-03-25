library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PmodKYPD is
    Port (
    JA1 : in  STD_LOGIC_VECTOR (3 downto 0); 
    JA2 : out  STD_LOGIC_VECTOR (3 downto 0);
    AN : out  STD_LOGIC_VECTOR (7 downto 0);   
    CAT : out  STD_LOGIC_VECTOR (7 downto 0); 
    
    Depasire_superioara: out STD_LOGIC;
    Depasire_inferioara: out STD_LOGIC;
    NaN: out STD_LOGIC;
    
    citesc_A : in STD_LOGIC;
    citesc_B : in STD_LOGIC;
    Operatie:in std_logic;
    Rst:in std_logic;
    clk:in std_logic;
    Start: in std_logic);
end PmodKYPD;

architecture Behavioral of PmodKYPD is
signal A : STD_LOGIC_VECTOR (31 downto 0)  := (others => '0');
signal B : STD_LOGIC_VECTOR (31 downto 0)  := (others => '0');
signal S : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal dep: std_logic_vector(1 downto 0);

signal iesire_decode: STD_LOGIC_VECTOR (3 downto 0) := "0000"; 
signal cifra_citita : std_logic := '0'; 
signal cifra_cititaDebounced : std_logic := '0';

signal Numar_citit : std_logic_vector(31 downto 0) := (others => '0');
signal cifra_selectata : std_logic_vector(2 downto 0) := (others => '0');

begin
    Decodare: entity WORK.Decoder
	port map(
		Clk => clk,
		Row => JA1(3 downto 0),
		Col => JA2(3 downto 0),
		DecodeOut => iesire_decode,
		DigitRead => cifra_citita
	);
	
	Debounce :entity WORK.debounce
    port map(
        Clk => clk,
        Rst => Rst,
        D_IN => cifra_citita,
        Q_OUT => cifra_cititaDebounced
    );
    
    Citire_numar:process(Clk)
    begin
        if rising_edge(Clk) then
            if Rst = '1' then
                Numar_citit <= (others => '0');
            elsif cifra_cititaDebounced = '1' then
                if cifra_selectata = "000" then
                    Numar_citit(31 downto 28) <= iesire_decode;
                elsif cifra_selectata = "001" then
                    Numar_citit(27 downto 24) <= iesire_decode;    
                elsif cifra_selectata = "010" then
                    Numar_citit(23 downto 20) <= iesire_decode;
                elsif cifra_selectata = "011" then
                    Numar_citit(19 downto 16) <= iesire_decode;
                elsif cifra_selectata = "100" then
                    Numar_citit(15 downto 12) <= iesire_decode;
                elsif cifra_selectata = "101" then
                    Numar_citit(11 downto 8) <= iesire_decode;
                elsif cifra_selectata = "110" then
                    Numar_citit(7 downto 4) <= iesire_decode;
                else 
                    Numar_citit(3 downto 0) <= iesire_decode;
                end if;
                cifra_selectata <= cifra_selectata + 1;
            end if;
        end if;
    end process;
    
    Care_numar_citim:process(clk)
    begin
        if rising_edge(clk) then
            if Rst = '1' then
                A <= (others => '0');
                B <= (others => '0');
            elsif citesc_A = '1' then
                A <= Numar_citit;
            elsif citesc_B = '1' then
                B <= Numar_citit;
            end if;
        end if;
    end process;
    
    Calculare_rezultat: entity WORK.main
    port map(
        A => A,
        B => B,
        A_S => Operatie,    
        Rst => Rst,
        clk => clk,
        Start => Start,
        dep => dep,
        S => S
    );
    
    Afisare : entity WORK.SSD
    port map(
        clk => clk,
        reset => Rst,
        data => S,
        an => An,
        cat => CAT
    );
    
    Cazuri_speciale:process 
    begin
        if dep = "01" then 
            Depasire_inferioara <= '1';
            Depasire_superioara <= '0';
            NaN <= '0';
        elsif dep = "10" then 
            Depasire_superioara <= '1';
            Depasire_inferioara <= '0';
            NaN <= '0';
        else
            Depasire_superioara <= '0';
            Depasire_inferioara <= '0';
            NaN <= '0';
        end if;
    end process;
    
end Behavioral;
