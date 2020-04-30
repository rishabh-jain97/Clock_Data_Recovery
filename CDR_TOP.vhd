--Package Declaration
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY TOP IS
PORT
    (
		Din 		:IN STD_LOGIC;
		Ref_clk		:IN STD_LOGIC;
		RST			:IN	STD_LOGIC;
		
		Dout		:OUT STD_LOGIC;
		recov_clk	:OUT STD_LOGIC
    );

END TOP; 

ARCHITECTURE Behaviour of  TOP IS
	--signals
	Q_late_clk	:STD_LOGIC;
	Q_clk_div	:STD_LOGIC;
	Q_recov_clk	:STD_LOGIC;
	clk_div		:STD_LOGIC;
	P			:STD_LOGIC_VECTOR(7 downto 0);
	clk_early	:STD_LOGIC;
	clk_edge	:STD_LOGIC;
	clk_late	:STD_LOGIC;
	up			:STD_LOGIC;
	down		:STD_LOGIC;
	out_p		:STD_LOGIC;
	out_n		:STD_LOGIC;
	
	--components
	 COMPONENT CLKD
         GENERIC 
            (
                divide :integer
            );
        PORT
            (
                --inputs
                sys_clk     :IN STD_LOGIC; --system clock
                rst         :IN STD_LOGIC;
                --outputs
                div_clk     :IN STD_LOGIC --divided clock
                
            );
    END COMPONENT;
	
	COMPONENT PHASE_GENERATOR
	PORT
    (
       --inputs
        ref_clk 		        :IN STD_LOGIC; --phase generator reference clock
        rst                 :IN STD_LOGIC; --reset phase generator
        --outputs
         parallel_data_out  :OUT STD_LOGIC_VECTOR(7 downto 0) --10 bit register counter
    );
	END COMPONENT;
	
	COMPONENT PHASE_ROTATOR
	PORT
    (
        clk     :IN STD_LOGIC;  --clk
        rst     :IN STD_LOGIC;  --reset counter
        INC     :IN STD_LOGIC;  --increment counter
        DEC     :IN STD_LOGIC; --decrement counter
        P   	:IN STD_LOGIC_VECTOR(7 downto 0);   --8 clock pulses
        --outputs
        CLK_early           :OUT STD_LOGIC;
        CLK_edge            :OUT STD_LOGIC;
        CLK_late            :OUT STD_LOGIC
     );
	END COMPONENT;
	
	
	COMPONENT BBPD
	PORT
    (
        Din     	:IN STD_LOGIC;  --clk
        CLK_early   :IN STD_LOGIC;
        CLK_edge    :IN STD_LOGIC;
        CLK_late    :IN STD_LOGIC;
        --outputs
        UP 			:OUT STD_LOGIC;
		DOWN		:OUT STD_LOGIC
    );
	END COMPONENT;
	
	
	COMPONENT DIGITAL_FILTER
	PORT
    (
		clk		:IN STD_LOGIC;
		In_P	:IN STD_LOGIC;
		In_N	:IN STD_LOGIC;
		--outputs
		Out_P	:OUT STD_LOGIC;
		sOut_N	:OUT STD_LOGIC
    );
	END COMPONENT;
	
	begin
		recov_clk <= Q_recov_clk;
		process(ref_clk)
			if rising_edge(ref_clk) then
				Q_clk_div <= clk_div;
				Q_late_clk <= clk_late;
				Q_recov_clk <= Q_late_clk;
			end if;
		end process;
		
		process(Q_recov_clk)begin
			if rising_edge(Q_recov_clk) then
				Dout <= Din;
			end if;
		end process;
	
	
	--clock divider
	clk_div_4 : CLKD 
		GENERIC MAP (4)
		PORT MAP 
			(
				Q_late_clk,
				rst,
				clk_div
			);
	
	--phase generator
	phase_gen : PHASE_GENERATOR
		PORT MAP
			(
				Ref_clk,
				RST,
				P				
			);
			
	phase_rot : PHASE_ROTATOR
		PORT MAP
			(
				Q_clk_div,
				RST,
				out_n,
				out_p,
				P,
				clk_early,
				clk_edge,
				clk_late				
			);
			
	phase_dect : BBPD
		PORT MAP
			(
				Din,  
				clk_early,
				clk_edge, 
				clk_late,
				up, 
				down,	
			);
			
	dig_filter : DIGITAL_FILTER
		PORT MAP
			(
				Q_late_clk,
				up,
				down,
				out_p,
				out_n
			);
END Behaviour;
