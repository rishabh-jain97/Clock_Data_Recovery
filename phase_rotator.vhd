----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2020 06:39:13 PM
-- Design Name: 
-- Module Name: phase_rotator - Behavioral
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

entity phase_rotator is
    Port ( 
    INC : in std_logic;
    DEC : in std_logic;
    rst : in std_logic;
    clk : in std_logic;
    clk_early : out std_logic; 
    clk_edge : out std_logic;
    clk_late : out std_logic 
    );
end phase_rotator;

architecture Behavioral of phase_rotator is

    signal P: STD_LOGIC_VECTOR(7 downto 0);
    signal edge : STD_LOGIC_VECTOR(7 downto 0);
    signal late : STD_LOGIC_VECTOR(7 downto 0);

COMPONENT counter 
    PORT
    (
    INC : in std_logic;
    DEC : in std_logic;
    clk : in std_logic;
    rst : in std_logic; 
    count : out std_logic_vector (2 downto 0)
    );
END COMPONENT; 

Component PG 
    PORT ( 
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    P :OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
    );
end component;

COMPONENT mux
    PORT ( 
    a : in std_logic_vector(7 downto 0); 
    sel : in std_logic_Vector (2 downto 0);
    b : out std_logic
    );
END COMPONENT;

signal cnt : STD_LOGIC_VECTOR (3 downto 0);

begin

    PROCESS(P) begin 
        edge <= P(1) & P(0) & P(7) & P(6) & P(5) & P(4) & P(3) & P(2);
        late <= P(3) & P(2) & P(1) & P(0) & P(7) & P(6) & P(5) & P(4);
    end process;


    counter1 : counter PORT MAP (INC,DEC,clk,rst,cnt);

    phase_generator : PG PORT MAP(clk,rst,P);

    mux_early : mux PORT MAP (P,cnt,clk_early);
    mux_edge : mux PORT MAP (edge,cnt,clk_edge);
    mux_late : mux PORT MAP(late,cnt,clk_late);

end Behavioral;
