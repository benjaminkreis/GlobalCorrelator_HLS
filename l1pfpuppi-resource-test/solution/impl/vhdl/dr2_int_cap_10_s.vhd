-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2018.1
-- Copyright (C) 1986-2018 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dr2_int_cap_10_s is
port (
    ap_ready : OUT STD_LOGIC;
    eta1_V : IN STD_LOGIC_VECTOR (9 downto 0);
    phi1_V : IN STD_LOGIC_VECTOR (9 downto 0);
    eta2_V : IN STD_LOGIC_VECTOR (9 downto 0);
    phi2_V : IN STD_LOGIC_VECTOR (9 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (8 downto 0) );
end;


architecture behav of dr2_int_cap_10_s is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv11_0 : STD_LOGIC_VECTOR (10 downto 0) := "00000000000";
    constant ap_const_lv10_0 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
    constant ap_const_lv32_5 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000101";
    constant ap_const_lv32_9 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001001";
    constant ap_const_lv5_0 : STD_LOGIC_VECTOR (4 downto 0) := "00000";
    constant ap_const_lv11_106 : STD_LOGIC_VECTOR (10 downto 0) := "00100000110";
    constant ap_const_lv9_106 : STD_LOGIC_VECTOR (8 downto 0) := "100000110";
    constant ap_const_logic_0 : STD_LOGIC := '0';

    signal lhs_V_fu_50_p1 : STD_LOGIC_VECTOR (10 downto 0);
    signal rhs_V_fu_54_p1 : STD_LOGIC_VECTOR (10 downto 0);
    signal r_V_fu_58_p2 : STD_LOGIC_VECTOR (10 downto 0);
    signal tmp_1252_fu_64_p1 : STD_LOGIC_VECTOR (9 downto 0);
    signal tmp_fu_68_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_s_fu_74_p2 : STD_LOGIC_VECTOR (9 downto 0);
    signal lhs_V_5_fu_88_p1 : STD_LOGIC_VECTOR (10 downto 0);
    signal rhs_V_5_fu_92_p1 : STD_LOGIC_VECTOR (10 downto 0);
    signal r_V_5_fu_96_p2 : STD_LOGIC_VECTOR (10 downto 0);
    signal tmp_1253_fu_102_p1 : STD_LOGIC_VECTOR (9 downto 0);
    signal tmp_17_fu_106_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_18_fu_112_p2 : STD_LOGIC_VECTOR (9 downto 0);
    signal dphi_V_fu_118_p3 : STD_LOGIC_VECTOR (9 downto 0);
    signal deta_V_fu_80_p3 : STD_LOGIC_VECTOR (9 downto 0);
    signal tmp_19_fu_126_p2 : STD_LOGIC_VECTOR (9 downto 0);
    signal tmp_1254_fu_132_p4 : STD_LOGIC_VECTOR (4 downto 0);
    signal deta2_V_fu_186_p2 : STD_LOGIC_VECTOR (9 downto 0);
    signal dphi2_V_fu_193_p2 : STD_LOGIC_VECTOR (9 downto 0);
    signal rhs_V_6_fu_151_p1 : STD_LOGIC_VECTOR (10 downto 0);
    signal lhs_V_6_fu_148_p1 : STD_LOGIC_VECTOR (10 downto 0);
    signal icmp_fu_142_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal r_V_6_fu_154_p2 : STD_LOGIC_VECTOR (10 downto 0);
    signal val_assign_fu_160_p3 : STD_LOGIC_VECTOR (10 downto 0);
    signal tmp_21_fu_168_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_1255_fu_174_p1 : STD_LOGIC_VECTOR (8 downto 0);

    component mp7wrapped_pfalgog8j IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        din0 : IN STD_LOGIC_VECTOR (9 downto 0);
        din1 : IN STD_LOGIC_VECTOR (9 downto 0);
        dout : OUT STD_LOGIC_VECTOR (9 downto 0) );
    end component;



begin
    mp7wrapped_pfalgog8j_U835 : component mp7wrapped_pfalgog8j
    generic map (
        ID => 1,
        NUM_STAGE => 1,
        din0_WIDTH => 10,
        din1_WIDTH => 10,
        dout_WIDTH => 10)
    port map (
        din0 => deta_V_fu_80_p3,
        din1 => deta_V_fu_80_p3,
        dout => deta2_V_fu_186_p2);

    mp7wrapped_pfalgog8j_U836 : component mp7wrapped_pfalgog8j
    generic map (
        ID => 1,
        NUM_STAGE => 1,
        din0_WIDTH => 10,
        din1_WIDTH => 10,
        dout_WIDTH => 10)
    port map (
        din0 => dphi_V_fu_118_p3,
        din1 => dphi_V_fu_118_p3,
        dout => dphi2_V_fu_193_p2);




    ap_ready <= ap_const_logic_1;
    ap_return <= 
        tmp_1255_fu_174_p1 when (tmp_21_fu_168_p2(0) = '1') else 
        ap_const_lv9_106;
    deta_V_fu_80_p3 <= 
        tmp_1252_fu_64_p1 when (tmp_fu_68_p2(0) = '1') else 
        tmp_s_fu_74_p2;
    dphi_V_fu_118_p3 <= 
        tmp_1253_fu_102_p1 when (tmp_17_fu_106_p2(0) = '1') else 
        tmp_18_fu_112_p2;
    icmp_fu_142_p2 <= "1" when (tmp_1254_fu_132_p4 = ap_const_lv5_0) else "0";
        lhs_V_5_fu_88_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(phi1_V),11));

    lhs_V_6_fu_148_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(deta2_V_fu_186_p2),11));
        lhs_V_fu_50_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(eta1_V),11));

    r_V_5_fu_96_p2 <= std_logic_vector(signed(lhs_V_5_fu_88_p1) - signed(rhs_V_5_fu_92_p1));
    r_V_6_fu_154_p2 <= std_logic_vector(unsigned(rhs_V_6_fu_151_p1) + unsigned(lhs_V_6_fu_148_p1));
    r_V_fu_58_p2 <= std_logic_vector(signed(lhs_V_fu_50_p1) - signed(rhs_V_fu_54_p1));
        rhs_V_5_fu_92_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(phi2_V),11));

    rhs_V_6_fu_151_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(dphi2_V_fu_193_p2),11));
        rhs_V_fu_54_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(eta2_V),11));

    tmp_1252_fu_64_p1 <= r_V_fu_58_p2(10 - 1 downto 0);
    tmp_1253_fu_102_p1 <= r_V_5_fu_96_p2(10 - 1 downto 0);
    tmp_1254_fu_132_p4 <= tmp_19_fu_126_p2(9 downto 5);
    tmp_1255_fu_174_p1 <= val_assign_fu_160_p3(9 - 1 downto 0);
    tmp_17_fu_106_p2 <= "1" when (signed(r_V_5_fu_96_p2) > signed(ap_const_lv11_0)) else "0";
    tmp_18_fu_112_p2 <= std_logic_vector(unsigned(ap_const_lv10_0) - unsigned(tmp_1253_fu_102_p1));
    tmp_19_fu_126_p2 <= (dphi_V_fu_118_p3 or deta_V_fu_80_p3);
    tmp_21_fu_168_p2 <= "1" when (unsigned(val_assign_fu_160_p3) < unsigned(ap_const_lv11_106)) else "0";
    tmp_fu_68_p2 <= "1" when (signed(r_V_fu_58_p2) > signed(ap_const_lv11_0)) else "0";
    tmp_s_fu_74_p2 <= std_logic_vector(unsigned(ap_const_lv10_0) - unsigned(tmp_1252_fu_64_p1));
    val_assign_fu_160_p3 <= 
        r_V_6_fu_154_p2 when (icmp_fu_142_p2(0) = '1') else 
        ap_const_lv11_106;
end behav;