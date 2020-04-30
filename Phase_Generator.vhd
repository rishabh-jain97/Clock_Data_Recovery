--Package Declaration
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY PHASE_GENERATOR IS
PORT
    (
    --inputs
    clk :IN STD_LOGIC; --phase generator reference clock
    rst :IN STD_LOGIC; --reset phase generator
    --outputs
    parallel_data_out :OUT STD_LOGIC_VECTOR(7 downto 0) 
    );
 
END PHASE_GENERATOR;

ARCHITECTURE Behaviour of PHASE_GENERATOR IS

    signal Q :STD_LOGIC_VECTOR(7 downto 0);
    begin
        parallel_data_out <= Q;
        process(clk,rst)
        begin
            if(rst = '0') then
                Q <= "10000000";
            elsif falling_edge(clk) then
            Q <= Q(6 downto 0) & Q(7); --shift register
            end if;
        end process;
END Behaviour;
