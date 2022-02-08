library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ledc8x8 is
port ( -- Sem doplnte popis rozhrani obvodu.
	RESET: in std_logic;
	SMCLK: in std_logic;
	ROW: out std_logic_vector(7 downto 0);
	LED: out std_logic_vector(7 downto 0)

);
end ledc8x8;

architecture main of ledc8x8 is

    -- Sem doplnte definice vnitrnich signalu.
	 signal s1: std_logic_vector(8 downto 0) := (others => '0');
	 signal s2: std_logic_vector(2 downto 0) := (others => '0');
	 signal s3: std_logic;
	 signal s4: std_logic_vector(23 downto 0);

begin
	process(SMCLK, RESET)
	begin
	if RESET = '1' then
		s1 <= (others => '0');
		s2 <= (others => '0');
		s4 <= (others => '0');
	
	
	elsif SMCLK'event and SMCLK = '1' then
		if s4 = "011100000111110011100000" then
			if s3 = '1' then s3 <= '0';
			else s3 <= '1';	
			end if;
			s4 <= (others => '0');
		else
			s4 <= s4 + 1;
		end if;
		
		if s1 = "100000000" then --256
			s1 <= "000000000";
			s2 <= s2 + 1;
		else
			s1 <= s1 + 1;
		end if;	
	end if;
	
end process;

process(s3, s2)	
begin
	if s3 = '0' then
		case s2 is
			when "000" => ROW <= "00000001"; LED <= "10111110"; 
			when "001" => ROW <= "00000010"; LED <= "10011100"; 
			when "010" => ROW <= "00000100"; LED <= "10101010";
			when "011" => ROW <= "00001000"; LED <= "10110110";
			when "100" => ROW <= "00010000"; LED <= "10111110";
			when "101" => ROW <= "00100000"; LED <= "10111110";
			when "110" => ROW <= "01000000"; LED <= "10111110";
			when "111" => ROW <= "10000000"; LED <= "10111110";
			when others => ROW <= "10000000"; LED <= "10111110";
		end case;
	else
		case s2 is
			when "000" => ROW <= "00000001"; LED <= "11100111";
			when "001" => ROW <= "00000010"; LED <= "11011011";
			when "010" => ROW <= "00000100"; LED <= "11111011";
			when "011" => ROW <= "00001000"; LED <= "11110111";
			when "100" => ROW <= "00010000"; LED <= "11101111";
			when "101" => ROW <= "00100000"; LED <= "11011111";
			when "110" => ROW <= "01000000"; LED <= "11011011";
			when "111" => ROW <= "10000000"; LED <= "11100111";
			when others => ROW <= "10000000"; LED <= "10111110";
		end case;
	end if;
end process;
	
	
    -- Sem doplnte popis funkce obvodu (zakladni konstrukce VHDL jako napr.
    -- prirazeni signalu, multiplexory, dekodery, procesy...).
    -- DODRZUJTE ZASADY PSANI SYNTETIZOVATELNEHO VHDL UVEDENE NA WEBU:
    -- http://merlin.fit.vutbr.cz/FITkit/docs/navody/synth_templates.html

    -- Nezapomente take doplnit mapovani signalu rozhrani na piny FPGA
    -- v souboru ledc8x8.ucf.

end main;
