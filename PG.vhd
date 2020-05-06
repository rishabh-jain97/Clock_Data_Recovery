----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2020 04:06:32 PM
-- Design Name: 
-- Module Name: PG - Behavioral
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

LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY PG IS
 PORT ( 
clk : IN STD_LOGIC;
rst : IN STD_LOGIC;
P :OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
);
end PG;

Architecture Behavioral of PG is

--signals
signal P_wire :STD_LOGIC_VECTOR(7 DOWNTO 0);

begin

P(7 downto 0) <= P_wire(7 downto 0);

PROCESS(clk,rst) begin 

if rst = '0' then 
   P_wire(0) <= '1';
   P_wire(7 downto 1) <= "000000";
   
elsif (rising_edge(clk)) then
P_wire(7 downto 0) <= P_wire(6 downto 0) & P_wire(7);

--P_wire(0) <= P_wire(7); 
--P_wire(1) <= P_wire(0);
--P_wire(2) <= P_wire(1);
--P_wire(3) <= P_wire(2);
--P_wire(4) <= P_wire(3);
--P_wire(5) <= P_wire(4);
--P_wire(6) <= P_wire(5);
--P_wire(7) <= P_wire(6);
--P_wire(7) <= P_wire(6);


END IF;
END PROCESS;
end Behavioral;
