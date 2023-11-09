LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY counter_4bit IS
    PORT(
        clk : IN std_logic;
        rst : IN std_logic;
		  en: IN std_logic;
        count : OUT std_logic_vector(3 DOWNTO 0)
    );
END counter_4bit;

ARCHITECTURE rtl OF counter_4bit IS
    SIGNAL int_a, int_b, int_c, int_d : std_logic;
	 SIGNAL int_da, int_db, int_dc, int_dd : std_logic;
    SIGNAL int_na, int_nb, int_nc, int_nd : std_logic;

    COMPONENT enARdFF_2 IS
    PORT(
        i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC
    );
    END COMPONENT;

BEGIN

int_da <= (en and int_d and int_c and int_b) xor int_a;
int_db <= (int_c and int_d and en) xor int_b;
int_dc <= (int_d and en) xor int_c;
int_dd <= int_d xor en;


reg_A : enARdFF_2
    PORT MAP(
        i_clock => clk,
        i_resetBar => rst,
        i_enable => '1',
        i_d => int_da,
		  o_q => int_a,
        o_qBar => int_na
    );

reg_B : enARdFF_2
    PORT MAP(
        i_clock => clk,
        i_resetBar => rst,
        i_enable => '1',
        i_d => int_db,
		  o_q => int_b,
        o_qBar => int_nb
    );

reg_C : enARdFF_2
    PORT MAP(
        i_clock => clk,
        i_resetBar => rst,
        i_enable => '1',
        i_d => int_dc,
		  o_q => int_c,
        o_qBar => int_nc
    );

reg_D : enARdFF_2
    PORT MAP(
        i_clock => clk,
        i_resetBar => rst,
        i_enable => '1',
        i_d => int_dd,
		  o_q => int_d,
        o_qBar => int_nd
    );

count <= int_a & int_b & int_c & int_d;

END rtl;
