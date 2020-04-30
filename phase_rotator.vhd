--Package Declaration
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY PHASE_ROTATOR IS
PORT
    (
    clk :IN STD_LOGIC; --clk
    rst :IN STD_LOGIC; --reset counter
    INC :IN STD_LOGIC; --increment counter
    DEC :IN STD_LOGIC; --decrement counter
    P :IN STD_LOGIC_VECTOR(7 downto 0); --8 clock pulses
    --outputs
    CLK_early :OUT STD_LOGIC;
    CLK_edge :OUT STD_LOGIC;
    CLK_late :OUT STD_LOGIC;
    counter_out :OUT STD_LOGIC_VECTOR(2 downto 0)
    );
END PHASE_ROTATOR;


ARCHITECTURE Behaviour of PHASE_ROTATOR IS
    signal div_4_clk :STD_LOGIC;
    signal counter :STD_LOGIC_VECTOR(2 downto 0);
    --signal counter :STD_LOGIC_VECTOR(2 downto 0);

    begin
        counter_out <= counter;
        process(clk, rst)begin
            if rst = '0' then
                counter <= "000";
             elsif rising_edge(clk) then
                if INC = '1'and DEC = '0' then
                    counter <= counter + 1;
                elsif DEC ='1' and INC = '0' then
                    counter <= counter - 1;
                else
                    counter <= counter;
                end if;
            end if;
        end process;

        process(counter) begin
        
            case counter is
                when "000" => --0
                CLK_early <= P(0);
                CLK_edge <= P(2);
                CLK_late <= P(4);
                
                when "001" => --1
                CLK_early <= P(1);
                CLK_edge <= P(3);
                CLK_late <= P(5);
                
                when "010" => --2
                CLK_early <= P(2);
                CLK_edge <= P(4);
                CLK_late <= P(6);
                
                when "011" => --3
                CLK_early <= P(3);
                CLK_edge <= P(5);
                CLK_late <= P(7);
                
                when "100" => --4
                CLK_early <= P(4);
                CLK_edge <= P(6);
                CLK_late <= P(0);
                
                when "101" => --5
                CLK_early <= P(5);
                CLK_edge <= P(7);
                CLK_late <= P(1);
                
                when "110" => --6
                CLK_early <= P(6);
                CLK_edge <= P(0);
                CLK_late <= P(2);
                
                when "111" => --7
                CLK_early <= P(7);
                CLK_edge <= P(1);
                CLK_late <= P(3);
            end case;
        end process;
        
END Behaviour;