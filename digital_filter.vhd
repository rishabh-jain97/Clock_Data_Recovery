--Package Declaration
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY DIGITAL_FILTER IS
PORT
    (
    clk :IN STD_LOGIC;
    In_P :IN STD_LOGIC;
    In_N :IN STD_LOGIC;
    
    --outputs
    Out_P :OUT STD_LOGIC;
    Out_N :OUT STD_LOGIC
    );
END DIGITAL_FILTER;


ARCHITECTURE Behaviour of DIGITAL_FILTER IS
    signal P_OR :STD_LOGIC;
    signal N_OR :STD_LOGIC;
    signal P_reg :STD_LOGIC_VECTOR(3 downto 0);
    signal N_reg :STD_LOGIC_VECTOR(3 downto 0);

    begin

        process(clk) begin
            if rising_edge(clk) then
                P_reg <= P_reg(2 downto 0) & In_P;
                N_reg <= N_reg(2 downto 0) & In_N ;

            end if;
        end process;

        process(P_reg, N_reg)begin
            if P_reg = "0000" then
                P_OR <= '0';
            else
                P_OR <= '1';
            end if;

            if N_reg = "0000" then
                N_OR <= '0';
            else
                N_OR <= '1';
            end if;
        end process;


        process(P_OR, N_OR) begin

            if P_OR = '1' AND N_OR = '0' then
                Out_P <= '1';
                Out_N <= '0';
            
            elsif N_OR = '1' AND P_OR = '0' then
                Out_N <= '1';
                Out_P <= '0';
            else
                Out_P <= '0';
                Out_N <= '0';
            end if;
        end process;
        
END Behaviour;