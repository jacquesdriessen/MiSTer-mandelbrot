-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 17.0 (Release Build #602)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2017 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from mandelbrot_addsub_0002
-- VHDL created on Mon Dec  7 14:04:30 2020


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity mandelbrot_addsub_0002 is
    port (
        a : in std_logic_vector(31 downto 0);  -- float32_m23
        b : in std_logic_vector(31 downto 0);  -- float32_m23
        opSel : in std_logic_vector(0 downto 0);  -- ufix1
        en : in std_logic_vector(0 downto 0);  -- ufix1
        q : out std_logic_vector(31 downto 0);  -- float32_m23
        clk : in std_logic;
        areset : in std_logic
    );
end mandelbrot_addsub_0002;

architecture normal of mandelbrot_addsub_0002 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signB_uid6_fpAddSubTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal restB_uid7_fpAddSubTest_b : STD_LOGIC_VECTOR (30 downto 0);
    signal invSignB_uid8_fpAddSubTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal muxSignB_uid9_fpAddSubTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal muxSignB_uid9_fpAddSubTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bOperand_uid10_fpAddSubTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal expFracX_uid15_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (30 downto 0);
    signal expFracY_uid16_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (30 downto 0);
    signal xGTEy_uid17_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid17_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid17_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid17_fpAddSubTest_ieeeAdd_n : STD_LOGIC_VECTOR (0 downto 0);
    signal fracY_uid18_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expY_uid19_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (7 downto 0);
    signal sigY_uid20_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal ypn_uid21_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (31 downto 0);
    signal aSig_uid25_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aSig_uid25_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bSig_uid26_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal bSig_uid26_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (31 downto 0);
    signal cstAllOWE_uid27_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (22 downto 0);
    signal cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (7 downto 0);
    signal exp_aSig_uid30_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (30 downto 0);
    signal exp_aSig_uid30_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (7 downto 0);
    signal frac_aSig_uid31_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (22 downto 0);
    signal frac_aSig_uid31_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid33_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid34_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid35_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_aSig_uid36_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_aSig_uid37_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_aSig_uid37_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid38_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid39_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_aSig_uid40_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal exp_bSig_uid44_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (30 downto 0);
    signal exp_bSig_uid44_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (7 downto 0);
    signal frac_bSig_uid45_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (22 downto 0);
    signal frac_bSig_uid45_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid47_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid47_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid48_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid49_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_bSig_uid50_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_bSig_uid51_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_bSig_uid51_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid52_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_bSig_uid54_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigA_uid59_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal sigB_uid60_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal effSub_uid61_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracBz_uid65_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracBz_uid65_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (22 downto 0);
    signal oFracB_uid68_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expAmExpB_uid69_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid69_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid69_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid69_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (8 downto 0);
    signal cWFP2_uid70_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (4 downto 0);
    signal shiftedOut_uid72_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid72_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid72_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid72_fpAddSubTest_ieeeAdd_c : STD_LOGIC_VECTOR (0 downto 0);
    signal padConst_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (24 downto 0);
    signal rightPaddedIn_uid74_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal iShiftedOut_uid76_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (48 downto 0);
    signal alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal cmpEQ_stickyBits_cZwF_uid80_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal effSubInvSticky_uid83_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal effSubInvSticky_uid83_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal zocst_uid85_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (1 downto 0);
    signal fracAAddOp_uid86_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOp_uid89_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracAddResult_uid91_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid91_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid91_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid91_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (26 downto 0);
    signal rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (26 downto 0);
    signal fracGRS_uid93_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal cAmA_uid95_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (4 downto 0);
    signal aMinusA_uid96_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostNorm_uid98_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (26 downto 0);
    signal oneCST_uid99_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (7 downto 0);
    signal expInc_uid100_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid100_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid100_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid100_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expPostNorm_uid101_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid101_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid101_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid101_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (9 downto 0);
    signal Sticky0_uid102_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (0 downto 0);
    signal Sticky0_uid102_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Sticky1_uid103_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (1 downto 0);
    signal Sticky1_uid103_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Round_uid104_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (2 downto 0);
    signal Round_uid104_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Guard_uid105_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (3 downto 0);
    signal Guard_uid105_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal LSB_uid106_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (4 downto 0);
    signal LSB_uid106_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rndBitCond_uid107_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (4 downto 0);
    signal cRBit_uid108_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (4 downto 0);
    signal rBi_uid109_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rBi_uid109_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal roundBit_uid110_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (25 downto 0);
    signal fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (23 downto 0);
    signal expFracR_uid112_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExpFrac_uid113_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid113_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid113_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid113_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (34 downto 0);
    signal wEP2AllOwE_uid114_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (9 downto 0);
    signal rndExp_uid115_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExp_uid115_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (9 downto 0);
    signal rOvfEQMax_uid116_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rOvfEQMax_uid116_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rndExpFracOvfBits_uid118_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExpFracOvfBits_uid118_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (3 downto 0);
    signal rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (3 downto 0);
    signal rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_n : STD_LOGIC_VECTOR (0 downto 0);
    signal rOvf_uid120_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal wEP2AllZ_uid121_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (9 downto 0);
    signal rUdfEQMin_uid123_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rUdfEQMin_uid123_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rUdfExtraBit_uid124_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rUdfExtraBit_uid124_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rUdf_uid125_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPreExc_uid126_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExc_uid126_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPreExc_uid127_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (31 downto 0);
    signal expRPreExc_uid127_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (7 downto 0);
    signal regInputs_uid128_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal regInputs_uid128_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZeroVInC_uid129_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (4 downto 0);
    signal excRZero_uid130_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rInfOvf_uid131_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInfVInC_uid132_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (5 downto 0);
    signal excRInf_uid133_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN2_uid134_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAIBISub_uid135_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid136_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid137_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid138_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (1 downto 0);
    signal invAMinusA_uid139_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRReg_uid140_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigBBInf_uid141_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigAAInf_uid142_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInf_uid143_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAZBZSigASigB_uid144_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excBZARSigA_uid145_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRZero_uid146_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInfRZRReg_uid147_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInfRZRReg_uid147_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExcRNaN_uid148_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid149_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oneFracRPostExc2_uid150_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPostExc_uid153_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostExc_uid153_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPostExc_uid157_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expRPostExc_uid157_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (7 downto 0);
    signal R_uid158_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (31 downto 0);
    signal zs_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mO_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (11 downto 0);
    signal vStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (11 downto 0);
    signal cStage_uid165_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vStagei_uid167_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid167_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid170_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid176_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (3 downto 0);
    signal zs_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (1 downto 0);
    signal vCount_uid182_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid185_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid185_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid187_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid189_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (4 downto 0);
    signal wIntCst_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (5 downto 0);
    signal shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_a : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_o : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_n : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng16_uid195_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStage0Idx1_uid197_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx2Rng32_uid198_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (16 downto 0);
    signal rightShiftStage0Idx2Pad32_uid199_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (31 downto 0);
    signal rightShiftStage0Idx2_uid200_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx3Rng48_uid201_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx3Pad48_uid202_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage0Idx3_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx1Rng4_uid206_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (44 downto 0);
    signal rightShiftStage1Idx1_uid208_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx2Rng8_uid209_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (40 downto 0);
    signal rightShiftStage1Idx2_uid211_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx3Rng12_uid212_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (36 downto 0);
    signal rightShiftStage1Idx3Pad12_uid213_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (11 downto 0);
    signal rightShiftStage1Idx3_uid214_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage2Idx1Rng1_uid217_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage2Idx1_uid219_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage2Idx2Rng2_uid220_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (46 downto 0);
    signal rightShiftStage2Idx2_uid222_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage2Idx3Rng3_uid223_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (45 downto 0);
    signal rightShiftStage2Idx3Pad3_uid224_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStage2Idx3_uid225_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage2_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal zeroOutCst_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal r_uid229_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid229_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (48 downto 0);
    signal leftShiftStage0Idx1Rng8_uid234_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage0Idx1Rng8_uid234_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage0Idx1_uid235_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx2_uid238_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx3Pad24_uid239_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage0Idx3Rng24_uid240_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (3 downto 0);
    signal leftShiftStage0Idx3Rng24_uid240_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (3 downto 0);
    signal leftShiftStage0Idx3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx1Rng2_uid245_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (25 downto 0);
    signal leftShiftStage1Idx1Rng2_uid245_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (25 downto 0);
    signal leftShiftStage1Idx1_uid246_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx2Rng4_uid248_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage1Idx2Rng4_uid248_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage1Idx2_uid249_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx3Pad6_uid250_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (5 downto 0);
    signal leftShiftStage1Idx3Rng6_uid251_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (21 downto 0);
    signal leftShiftStage1Idx3Rng6_uid251_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (21 downto 0);
    signal leftShiftStage1Idx3_uid252_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage2Idx1Rng1_uid256_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in : STD_LOGIC_VECTOR (26 downto 0);
    signal leftShiftStage2Idx1Rng1_uid256_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b : STD_LOGIC_VECTOR (26 downto 0);
    signal leftShiftStage2Idx1_uid257_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q : STD_LOGIC_VECTOR (27 downto 0);
    signal rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_in : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_b : STD_LOGIC_VECTOR (22 downto 0);
    signal stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_c : STD_LOGIC_VECTOR (25 downto 0);
    signal rVStage_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid175_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid175_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel4Dto3_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel4Dto3_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel4Dto3_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_d : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_vCount_uid176_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_vCount_uid170_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_vStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist3_vCount_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_rVStage_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist5_signRInfRZRReg_uid147_fpAddSubTest_ieeeAdd_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_regInputs_uid128_fpAddSubTest_ieeeAdd_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_expRPreExc_uid127_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist8_fracRPreExc_uid126_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist9_rUdfExtraBit_uid124_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist11_aMinusA_uid96_fpAddSubTest_ieeeAdd_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_2_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist14_effSub_uid61_fpAddSubTest_ieeeAdd_q_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_sigB_uid60_fpAddSubTest_ieeeAdd_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_sigB_uid60_fpAddSubTest_ieeeAdd_b_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_sigA_uid59_fpAddSubTest_ieeeAdd_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_sigA_uid59_fpAddSubTest_ieeeAdd_b_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist19_InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_excN_bSig_uid51_fpAddSubTest_ieeeAdd_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_excI_bSig_uid50_fpAddSubTest_ieeeAdd_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist22_fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist23_expXIsMax_uid47_fpAddSubTest_ieeeAdd_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist25_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist26_frac_bSig_uid45_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist27_exp_bSig_uid44_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist28_excN_aSig_uid37_fpAddSubTest_ieeeAdd_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist29_excI_aSig_uid36_fpAddSubTest_ieeeAdd_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist30_fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist32_frac_aSig_uid31_fpAddSubTest_ieeeAdd_b_3_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist34_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_5_q : STD_LOGIC_VECTOR (7 downto 0);

begin


    -- cAmA_uid95_fpAddSubTest_ieeeAdd(CONSTANT,94)
    cAmA_uid95_fpAddSubTest_ieeeAdd_q <= "11100";

    -- zs_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd(CONSTANT,159)
    zs_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "0000000000000000";

    -- signB_uid6_fpAddSubTest(BITSELECT,5)@0
    signB_uid6_fpAddSubTest_b <= STD_LOGIC_VECTOR(b(31 downto 31));

    -- invSignB_uid8_fpAddSubTest(LOGICAL,7)@0
    invSignB_uid8_fpAddSubTest_q <= not (signB_uid6_fpAddSubTest_b);

    -- muxSignB_uid9_fpAddSubTest(MUX,8)@0
    muxSignB_uid9_fpAddSubTest_s <= opSel;
    muxSignB_uid9_fpAddSubTest_combproc: PROCESS (muxSignB_uid9_fpAddSubTest_s, en, invSignB_uid8_fpAddSubTest_q, signB_uid6_fpAddSubTest_b)
    BEGIN
        CASE (muxSignB_uid9_fpAddSubTest_s) IS
            WHEN "0" => muxSignB_uid9_fpAddSubTest_q <= invSignB_uid8_fpAddSubTest_q;
            WHEN "1" => muxSignB_uid9_fpAddSubTest_q <= signB_uid6_fpAddSubTest_b;
            WHEN OTHERS => muxSignB_uid9_fpAddSubTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- restB_uid7_fpAddSubTest(BITSELECT,6)@0
    restB_uid7_fpAddSubTest_b <= b(30 downto 0);

    -- bOperand_uid10_fpAddSubTest(BITJOIN,9)@0
    bOperand_uid10_fpAddSubTest_q <= muxSignB_uid9_fpAddSubTest_q & restB_uid7_fpAddSubTest_b;

    -- sigY_uid20_fpAddSubTest_ieeeAdd(BITSELECT,19)@0
    sigY_uid20_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(bOperand_uid10_fpAddSubTest_q(31 downto 31));

    -- expY_uid19_fpAddSubTest_ieeeAdd(BITSELECT,18)@0
    expY_uid19_fpAddSubTest_ieeeAdd_b <= bOperand_uid10_fpAddSubTest_q(30 downto 23);

    -- fracY_uid18_fpAddSubTest_ieeeAdd(BITSELECT,17)@0
    fracY_uid18_fpAddSubTest_ieeeAdd_b <= bOperand_uid10_fpAddSubTest_q(22 downto 0);

    -- ypn_uid21_fpAddSubTest_ieeeAdd(BITJOIN,20)@0
    ypn_uid21_fpAddSubTest_ieeeAdd_q <= sigY_uid20_fpAddSubTest_ieeeAdd_b & expY_uid19_fpAddSubTest_ieeeAdd_b & fracY_uid18_fpAddSubTest_ieeeAdd_b;

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- expFracY_uid16_fpAddSubTest_ieeeAdd(BITSELECT,15)@0
    expFracY_uid16_fpAddSubTest_ieeeAdd_b <= bOperand_uid10_fpAddSubTest_q(30 downto 0);

    -- expFracX_uid15_fpAddSubTest_ieeeAdd(BITSELECT,14)@0
    expFracX_uid15_fpAddSubTest_ieeeAdd_b <= a(30 downto 0);

    -- xGTEy_uid17_fpAddSubTest_ieeeAdd(COMPARE,16)@0
    xGTEy_uid17_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("00" & expFracX_uid15_fpAddSubTest_ieeeAdd_b);
    xGTEy_uid17_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("00" & expFracY_uid16_fpAddSubTest_ieeeAdd_b);
    xGTEy_uid17_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(xGTEy_uid17_fpAddSubTest_ieeeAdd_a) - UNSIGNED(xGTEy_uid17_fpAddSubTest_ieeeAdd_b));
    xGTEy_uid17_fpAddSubTest_ieeeAdd_n(0) <= not (xGTEy_uid17_fpAddSubTest_ieeeAdd_o(32));

    -- bSig_uid26_fpAddSubTest_ieeeAdd(MUX,25)@0
    bSig_uid26_fpAddSubTest_ieeeAdd_s <= xGTEy_uid17_fpAddSubTest_ieeeAdd_n;
    bSig_uid26_fpAddSubTest_ieeeAdd_combproc: PROCESS (bSig_uid26_fpAddSubTest_ieeeAdd_s, en, a, ypn_uid21_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (bSig_uid26_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => bSig_uid26_fpAddSubTest_ieeeAdd_q <= a;
            WHEN "1" => bSig_uid26_fpAddSubTest_ieeeAdd_q <= ypn_uid21_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => bSig_uid26_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigB_uid60_fpAddSubTest_ieeeAdd(BITSELECT,59)@0
    sigB_uid60_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(bSig_uid26_fpAddSubTest_ieeeAdd_q(31 downto 31));

    -- redist15_sigB_uid60_fpAddSubTest_ieeeAdd_b_2(DELAY,281)
    redist15_sigB_uid60_fpAddSubTest_ieeeAdd_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => sigB_uid60_fpAddSubTest_ieeeAdd_b, xout => redist15_sigB_uid60_fpAddSubTest_ieeeAdd_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- aSig_uid25_fpAddSubTest_ieeeAdd(MUX,24)@0
    aSig_uid25_fpAddSubTest_ieeeAdd_s <= xGTEy_uid17_fpAddSubTest_ieeeAdd_n;
    aSig_uid25_fpAddSubTest_ieeeAdd_combproc: PROCESS (aSig_uid25_fpAddSubTest_ieeeAdd_s, en, ypn_uid21_fpAddSubTest_ieeeAdd_q, a)
    BEGIN
        CASE (aSig_uid25_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => aSig_uid25_fpAddSubTest_ieeeAdd_q <= ypn_uid21_fpAddSubTest_ieeeAdd_q;
            WHEN "1" => aSig_uid25_fpAddSubTest_ieeeAdd_q <= a;
            WHEN OTHERS => aSig_uid25_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigA_uid59_fpAddSubTest_ieeeAdd(BITSELECT,58)@0
    sigA_uid59_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(aSig_uid25_fpAddSubTest_ieeeAdd_q(31 downto 31));

    -- redist17_sigA_uid59_fpAddSubTest_ieeeAdd_b_2(DELAY,283)
    redist17_sigA_uid59_fpAddSubTest_ieeeAdd_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => sigA_uid59_fpAddSubTest_ieeeAdd_b, xout => redist17_sigA_uid59_fpAddSubTest_ieeeAdd_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- effSub_uid61_fpAddSubTest_ieeeAdd(LOGICAL,60)@2
    effSub_uid61_fpAddSubTest_ieeeAdd_q <= redist17_sigA_uid59_fpAddSubTest_ieeeAdd_b_2_q xor redist15_sigB_uid60_fpAddSubTest_ieeeAdd_b_2_q;

    -- exp_bSig_uid44_fpAddSubTest_ieeeAdd(BITSELECT,43)@0
    exp_bSig_uid44_fpAddSubTest_ieeeAdd_in <= bSig_uid26_fpAddSubTest_ieeeAdd_q(30 downto 0);
    exp_bSig_uid44_fpAddSubTest_ieeeAdd_b <= exp_bSig_uid44_fpAddSubTest_ieeeAdd_in(30 downto 23);

    -- redist27_exp_bSig_uid44_fpAddSubTest_ieeeAdd_b_1(DELAY,293)
    redist27_exp_bSig_uid44_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => exp_bSig_uid44_fpAddSubTest_ieeeAdd_b, xout => redist27_exp_bSig_uid44_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- exp_aSig_uid30_fpAddSubTest_ieeeAdd(BITSELECT,29)@0
    exp_aSig_uid30_fpAddSubTest_ieeeAdd_in <= aSig_uid25_fpAddSubTest_ieeeAdd_q(30 downto 0);
    exp_aSig_uid30_fpAddSubTest_ieeeAdd_b <= exp_aSig_uid30_fpAddSubTest_ieeeAdd_in(30 downto 23);

    -- redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_1(DELAY,299)
    redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => exp_aSig_uid30_fpAddSubTest_ieeeAdd_b, xout => redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- expAmExpB_uid69_fpAddSubTest_ieeeAdd(SUB,68)@1
    expAmExpB_uid69_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("0" & redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_1_q);
    expAmExpB_uid69_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("0" & redist27_exp_bSig_uid44_fpAddSubTest_ieeeAdd_b_1_q);
    expAmExpB_uid69_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(expAmExpB_uid69_fpAddSubTest_ieeeAdd_a) - UNSIGNED(expAmExpB_uid69_fpAddSubTest_ieeeAdd_b));
    expAmExpB_uid69_fpAddSubTest_ieeeAdd_q <= expAmExpB_uid69_fpAddSubTest_ieeeAdd_o(8 downto 0);

    -- cWFP2_uid70_fpAddSubTest_ieeeAdd(CONSTANT,69)
    cWFP2_uid70_fpAddSubTest_ieeeAdd_q <= "11001";

    -- shiftedOut_uid72_fpAddSubTest_ieeeAdd(COMPARE,71)@1 + 1
    shiftedOut_uid72_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("000000" & cWFP2_uid70_fpAddSubTest_ieeeAdd_q);
    shiftedOut_uid72_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("00" & expAmExpB_uid69_fpAddSubTest_ieeeAdd_q);
    shiftedOut_uid72_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            shiftedOut_uid72_fpAddSubTest_ieeeAdd_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                shiftedOut_uid72_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid72_fpAddSubTest_ieeeAdd_a) - UNSIGNED(shiftedOut_uid72_fpAddSubTest_ieeeAdd_b));
            END IF;
        END IF;
    END PROCESS;
    shiftedOut_uid72_fpAddSubTest_ieeeAdd_c(0) <= shiftedOut_uid72_fpAddSubTest_ieeeAdd_o(10);

    -- iShiftedOut_uid76_fpAddSubTest_ieeeAdd(LOGICAL,75)@2
    iShiftedOut_uid76_fpAddSubTest_ieeeAdd_q <= not (shiftedOut_uid72_fpAddSubTest_ieeeAdd_c);

    -- zeroOutCst_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(CONSTANT,227)
    zeroOutCst_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= "0000000000000000000000000000000000000000000000000";

    -- rightShiftStage2Idx3Pad3_uid224_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(CONSTANT,223)
    rightShiftStage2Idx3Pad3_uid224_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= "000";

    -- rightShiftStage2Idx3Rng3_uid223_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,222)@1
    rightShiftStage2Idx3Rng3_uid223_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q(48 downto 3);

    -- rightShiftStage2Idx3_uid225_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,224)@1
    rightShiftStage2Idx3_uid225_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage2Idx3Pad3_uid224_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q & rightShiftStage2Idx3Rng3_uid223_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- zs_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd(CONSTANT,179)
    zs_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "00";

    -- rightShiftStage2Idx2Rng2_uid220_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,219)@1
    rightShiftStage2Idx2Rng2_uid220_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q(48 downto 2);

    -- rightShiftStage2Idx2_uid222_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,221)@1
    rightShiftStage2Idx2_uid222_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= zs_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q & rightShiftStage2Idx2Rng2_uid220_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- rightShiftStage2Idx1Rng1_uid217_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,216)@1
    rightShiftStage2Idx1Rng1_uid217_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q(48 downto 1);

    -- rightShiftStage2Idx1_uid219_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,218)@1
    rightShiftStage2Idx1_uid219_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= GND_q & rightShiftStage2Idx1Rng1_uid217_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- rightShiftStage1Idx3Pad12_uid213_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(CONSTANT,212)
    rightShiftStage1Idx3Pad12_uid213_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= "000000000000";

    -- rightShiftStage1Idx3Rng12_uid212_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,211)@1
    rightShiftStage1Idx3Rng12_uid212_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q(48 downto 12);

    -- rightShiftStage1Idx3_uid214_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,213)@1
    rightShiftStage1Idx3_uid214_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage1Idx3Pad12_uid213_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q & rightShiftStage1Idx3Rng12_uid212_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- cstAllZWE_uid29_fpAddSubTest_ieeeAdd(CONSTANT,28)
    cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q <= "00000000";

    -- rightShiftStage1Idx2Rng8_uid209_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,208)@1
    rightShiftStage1Idx2Rng8_uid209_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q(48 downto 8);

    -- rightShiftStage1Idx2_uid211_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,210)@1
    rightShiftStage1Idx2_uid211_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q & rightShiftStage1Idx2Rng8_uid209_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- zs_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd(CONSTANT,173)
    zs_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "0000";

    -- rightShiftStage1Idx1Rng4_uid206_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,205)@1
    rightShiftStage1Idx1Rng4_uid206_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q(48 downto 4);

    -- rightShiftStage1Idx1_uid208_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,207)@1
    rightShiftStage1Idx1_uid208_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= zs_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q & rightShiftStage1Idx1Rng4_uid206_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- rightShiftStage0Idx3Pad48_uid202_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(CONSTANT,201)
    rightShiftStage0Idx3Pad48_uid202_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= "000000000000000000000000000000000000000000000000";

    -- rightShiftStage0Idx3Rng48_uid201_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,200)@1
    rightShiftStage0Idx3Rng48_uid201_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightPaddedIn_uid74_fpAddSubTest_ieeeAdd_q(48 downto 48);

    -- rightShiftStage0Idx3_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,202)@1
    rightShiftStage0Idx3_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage0Idx3Pad48_uid202_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q & rightShiftStage0Idx3Rng48_uid201_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- rightShiftStage0Idx2Pad32_uid199_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(CONSTANT,198)
    rightShiftStage0Idx2Pad32_uid199_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= "00000000000000000000000000000000";

    -- rightShiftStage0Idx2Rng32_uid198_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,197)@1
    rightShiftStage0Idx2Rng32_uid198_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightPaddedIn_uid74_fpAddSubTest_ieeeAdd_q(48 downto 32);

    -- rightShiftStage0Idx2_uid200_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,199)@1
    rightShiftStage0Idx2_uid200_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage0Idx2Pad32_uid199_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q & rightShiftStage0Idx2Rng32_uid198_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- rightShiftStage0Idx1Rng16_uid195_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITSELECT,194)@1
    rightShiftStage0Idx1Rng16_uid195_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= rightPaddedIn_uid74_fpAddSubTest_ieeeAdd_q(48 downto 16);

    -- rightShiftStage0Idx1_uid197_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(BITJOIN,196)@1
    rightShiftStage0Idx1_uid197_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= zs_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q & rightShiftStage0Idx1Rng16_uid195_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b;

    -- excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd(LOGICAL,45)@1
    excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q <= "1" WHEN redist27_exp_bSig_uid44_fpAddSubTest_ieeeAdd_b_1_q = cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd(LOGICAL,52)@1
    InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q <= not (excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q);

    -- cstZeroWF_uid28_fpAddSubTest_ieeeAdd(CONSTANT,27)
    cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q <= "00000000000000000000000";

    -- frac_bSig_uid45_fpAddSubTest_ieeeAdd(BITSELECT,44)@0
    frac_bSig_uid45_fpAddSubTest_ieeeAdd_in <= bSig_uid26_fpAddSubTest_ieeeAdd_q(22 downto 0);
    frac_bSig_uid45_fpAddSubTest_ieeeAdd_b <= frac_bSig_uid45_fpAddSubTest_ieeeAdd_in(22 downto 0);

    -- redist26_frac_bSig_uid45_fpAddSubTest_ieeeAdd_b_1(DELAY,292)
    redist26_frac_bSig_uid45_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => frac_bSig_uid45_fpAddSubTest_ieeeAdd_b, xout => redist26_frac_bSig_uid45_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- fracBz_uid65_fpAddSubTest_ieeeAdd(MUX,64)@1
    fracBz_uid65_fpAddSubTest_ieeeAdd_s <= excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q;
    fracBz_uid65_fpAddSubTest_ieeeAdd_combproc: PROCESS (fracBz_uid65_fpAddSubTest_ieeeAdd_s, en, redist26_frac_bSig_uid45_fpAddSubTest_ieeeAdd_b_1_q, cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (fracBz_uid65_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => fracBz_uid65_fpAddSubTest_ieeeAdd_q <= redist26_frac_bSig_uid45_fpAddSubTest_ieeeAdd_b_1_q;
            WHEN "1" => fracBz_uid65_fpAddSubTest_ieeeAdd_q <= cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => fracBz_uid65_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oFracB_uid68_fpAddSubTest_ieeeAdd(BITJOIN,67)@1
    oFracB_uid68_fpAddSubTest_ieeeAdd_q <= InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q & fracBz_uid65_fpAddSubTest_ieeeAdd_q;

    -- padConst_uid73_fpAddSubTest_ieeeAdd(CONSTANT,72)
    padConst_uid73_fpAddSubTest_ieeeAdd_q <= "0000000000000000000000000";

    -- rightPaddedIn_uid74_fpAddSubTest_ieeeAdd(BITJOIN,73)@1
    rightPaddedIn_uid74_fpAddSubTest_ieeeAdd_q <= oFracB_uid68_fpAddSubTest_ieeeAdd_q & padConst_uid73_fpAddSubTest_ieeeAdd_q;

    -- rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(MUX,204)@1
    rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s <= rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_b;
    rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_combproc: PROCESS (rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s, en, rightPaddedIn_uid74_fpAddSubTest_ieeeAdd_q, rightShiftStage0Idx1_uid197_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q, rightShiftStage0Idx2_uid200_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q, rightShiftStage0Idx3_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s) IS
            WHEN "00" => rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightPaddedIn_uid74_fpAddSubTest_ieeeAdd_q;
            WHEN "01" => rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage0Idx1_uid197_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN "10" => rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage0Idx2_uid200_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN "11" => rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage0Idx3_uid203_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(MUX,215)@1
    rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s <= rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_c;
    rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_combproc: PROCESS (rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s, en, rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q, rightShiftStage1Idx1_uid208_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q, rightShiftStage1Idx2_uid211_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q, rightShiftStage1Idx3_uid214_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s) IS
            WHEN "00" => rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage0_uid205_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN "01" => rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage1Idx1_uid208_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN "10" => rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage1Idx2_uid211_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN "11" => rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage1Idx3_uid214_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select(BITSELECT,260)@1
    rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_in <= expAmExpB_uid69_fpAddSubTest_ieeeAdd_q(5 downto 0);
    rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_b <= rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_in(5 downto 4);
    rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_c <= rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_in(3 downto 2);
    rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_d <= rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_in(1 downto 0);

    -- rightShiftStage2_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(MUX,226)@1 + 1
    rightShiftStage2_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s <= rightShiftStageSel5Dto4_uid204_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_merged_bit_select_d;
    rightShiftStage2_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            rightShiftStage2_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (rightShiftStage2_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s) IS
                    WHEN "00" => rightShiftStage2_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage1_uid216_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
                    WHEN "01" => rightShiftStage2_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage2Idx1_uid219_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
                    WHEN "10" => rightShiftStage2_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage2Idx2_uid222_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
                    WHEN "11" => rightShiftStage2_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage2Idx3_uid225_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
                    WHEN OTHERS => rightShiftStage2_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- wIntCst_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(CONSTANT,192)
    wIntCst_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= "110001";

    -- shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(COMPARE,193)@1 + 1
    shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("00" & expAmExpB_uid69_fpAddSubTest_ieeeAdd_q);
    shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("00000" & wIntCst_uid193_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q);
    shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_a) - UNSIGNED(shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_b));
            END IF;
        END IF;
    END PROCESS;
    shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_n(0) <= not (shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_o(10));

    -- r_uid229_alignmentShifter_uid73_fpAddSubTest_ieeeAdd(MUX,228)@2
    r_uid229_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s <= shiftedOut_uid194_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_n;
    r_uid229_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_combproc: PROCESS (r_uid229_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s, en, rightShiftStage2_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q, zeroOutCst_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (r_uid229_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => r_uid229_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= rightShiftStage2_uid227_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN "1" => r_uid229_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= zeroOutCst_uid228_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => r_uid229_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd(LOGICAL,76)@2
    alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((48 downto 1 => iShiftedOut_uid76_fpAddSubTest_ieeeAdd_q(0)) & iShiftedOut_uid76_fpAddSubTest_ieeeAdd_q));
    alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd_q <= r_uid229_alignmentShifter_uid73_fpAddSubTest_ieeeAdd_q and alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd_b;

    -- stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select(BITSELECT,261)@2
    stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_b <= alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd_q(22 downto 0);
    stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_c <= alignFracBPostShiftOut_uid77_fpAddSubTest_ieeeAdd_q(48 downto 23);

    -- fracBAddOp_uid89_fpAddSubTest_ieeeAdd(BITJOIN,88)@2
    fracBAddOp_uid89_fpAddSubTest_ieeeAdd_q <= GND_q & stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_c;

    -- fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd(LOGICAL,89)@2 + 1
    fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 1 => effSub_uid61_fpAddSubTest_ieeeAdd_q(0)) & effSub_uid61_fpAddSubTest_ieeeAdd_q));
    fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_qi <= fracBAddOp_uid89_fpAddSubTest_ieeeAdd_q xor fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_b;
    fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_qi, xout => fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- zocst_uid85_fpAddSubTest_ieeeAdd(CONSTANT,84)
    zocst_uid85_fpAddSubTest_ieeeAdd_q <= "01";

    -- frac_aSig_uid31_fpAddSubTest_ieeeAdd(BITSELECT,30)@0
    frac_aSig_uid31_fpAddSubTest_ieeeAdd_in <= aSig_uid25_fpAddSubTest_ieeeAdd_q(22 downto 0);
    frac_aSig_uid31_fpAddSubTest_ieeeAdd_b <= frac_aSig_uid31_fpAddSubTest_ieeeAdd_in(22 downto 0);

    -- redist32_frac_aSig_uid31_fpAddSubTest_ieeeAdd_b_3(DELAY,298)
    redist32_frac_aSig_uid31_fpAddSubTest_ieeeAdd_b_3 : dspba_delay
    GENERIC MAP ( width => 23, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => frac_aSig_uid31_fpAddSubTest_ieeeAdd_b, xout => redist32_frac_aSig_uid31_fpAddSubTest_ieeeAdd_b_3_q, ena => en(0), clk => clk, aclr => areset );

    -- cmpEQ_stickyBits_cZwF_uid80_fpAddSubTest_ieeeAdd(LOGICAL,79)@2
    cmpEQ_stickyBits_cZwF_uid80_fpAddSubTest_ieeeAdd_q <= "1" WHEN stickyBits_uid78_fpAddSubTest_ieeeAdd_merged_bit_select_b = cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- effSubInvSticky_uid83_fpAddSubTest_ieeeAdd(LOGICAL,82)@2 + 1
    effSubInvSticky_uid83_fpAddSubTest_ieeeAdd_qi <= effSub_uid61_fpAddSubTest_ieeeAdd_q and cmpEQ_stickyBits_cZwF_uid80_fpAddSubTest_ieeeAdd_q;
    effSubInvSticky_uid83_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => effSubInvSticky_uid83_fpAddSubTest_ieeeAdd_qi, xout => effSubInvSticky_uid83_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- fracAAddOp_uid86_fpAddSubTest_ieeeAdd(BITJOIN,85)@3
    fracAAddOp_uid86_fpAddSubTest_ieeeAdd_q <= zocst_uid85_fpAddSubTest_ieeeAdd_q & redist32_frac_aSig_uid31_fpAddSubTest_ieeeAdd_b_3_q & GND_q & effSubInvSticky_uid83_fpAddSubTest_ieeeAdd_q;

    -- fracAddResult_uid91_fpAddSubTest_ieeeAdd(ADD,90)@3
    fracAddResult_uid91_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("0" & fracAAddOp_uid86_fpAddSubTest_ieeeAdd_q);
    fracAddResult_uid91_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("0" & fracBAddOpPostXor_uid90_fpAddSubTest_ieeeAdd_q);
    fracAddResult_uid91_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(fracAddResult_uid91_fpAddSubTest_ieeeAdd_a) + UNSIGNED(fracAddResult_uid91_fpAddSubTest_ieeeAdd_b));
    fracAddResult_uid91_fpAddSubTest_ieeeAdd_q <= fracAddResult_uid91_fpAddSubTest_ieeeAdd_o(27 downto 0);

    -- rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd(BITSELECT,91)@3
    rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_in <= fracAddResult_uid91_fpAddSubTest_ieeeAdd_q(26 downto 0);
    rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_b <= rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_in(26 downto 0);

    -- invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd(LOGICAL,80)@2 + 1
    invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd_qi <= not (cmpEQ_stickyBits_cZwF_uid80_fpAddSubTest_ieeeAdd_q);
    invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd_qi, xout => invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- fracGRS_uid93_fpAddSubTest_ieeeAdd(BITJOIN,92)@3
    fracGRS_uid93_fpAddSubTest_ieeeAdd_q <= rangeFracAddResultMwfp3Dto0_uid92_fpAddSubTest_ieeeAdd_b & invCmpEQ_stickyBits_cZwF_uid81_fpAddSubTest_ieeeAdd_q;

    -- rVStage_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd(BITSELECT,160)@3
    rVStage_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b <= fracGRS_uid93_fpAddSubTest_ieeeAdd_q(27 downto 12);

    -- vCount_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd(LOGICAL,161)@3 + 1
    vCount_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_qi <= "1" WHEN rVStage_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b = zs_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q ELSE "0";
    vCount_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_qi, xout => vCount_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist3_vCount_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_2(DELAY,269)
    redist3_vCount_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q, xout => redist3_vCount_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- redist12_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_1(DELAY,278)
    redist12_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_1 : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracGRS_uid93_fpAddSubTest_ieeeAdd_q, xout => redist12_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd(BITSELECT,163)@4
    vStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_in <= redist12_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_1_q(11 downto 0);
    vStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b <= vStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_in(11 downto 0);

    -- mO_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd(CONSTANT,162)
    mO_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "1111";

    -- cStage_uid165_lzCountVal_uid94_fpAddSubTest_ieeeAdd(BITJOIN,164)@4
    cStage_uid165_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= vStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b & mO_uid163_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;

    -- redist4_rVStage_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1(DELAY,270)
    redist4_rVStage_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rVStage_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b, xout => redist4_rVStage_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid167_lzCountVal_uid94_fpAddSubTest_ieeeAdd(MUX,166)@4
    vStagei_uid167_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s <= vCount_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;
    vStagei_uid167_lzCountVal_uid94_fpAddSubTest_ieeeAdd_combproc: PROCESS (vStagei_uid167_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s, en, redist4_rVStage_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1_q, cStage_uid165_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (vStagei_uid167_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => vStagei_uid167_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= redist4_rVStage_uid161_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1_q;
            WHEN "1" => vStagei_uid167_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= cStage_uid165_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => vStagei_uid167_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select(BITSELECT,262)@4
    rVStage_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b <= vStagei_uid167_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(15 downto 8);
    rVStage_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c <= vStagei_uid167_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(7 downto 0);

    -- vCount_uid170_lzCountVal_uid94_fpAddSubTest_ieeeAdd(LOGICAL,169)@4
    vCount_uid170_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "1" WHEN rVStage_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b = cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- redist1_vCount_uid170_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1(DELAY,267)
    redist1_vCount_uid170_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid170_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q, xout => redist1_vCount_uid170_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd(MUX,172)@4
    vStagei_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s <= vCount_uid170_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;
    vStagei_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_combproc: PROCESS (vStagei_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s, en, rVStage_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b, rVStage_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => vStagei_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= rVStage_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b;
            WHEN "1" => vStagei_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= rVStage_uid169_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid175_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select(BITSELECT,263)@4
    rVStage_uid175_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b <= vStagei_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(7 downto 4);
    rVStage_uid175_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c <= vStagei_uid173_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(3 downto 0);

    -- vCount_uid176_lzCountVal_uid94_fpAddSubTest_ieeeAdd(LOGICAL,175)@4
    vCount_uid176_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "1" WHEN rVStage_uid175_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b = zs_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- redist0_vCount_uid176_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1(DELAY,266)
    redist0_vCount_uid176_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid176_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q, xout => redist0_vCount_uid176_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd(MUX,178)@4 + 1
    vStagei_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s <= vCount_uid176_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;
    vStagei_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            vStagei_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (vStagei_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s) IS
                    WHEN "0" => vStagei_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= rVStage_uid175_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b;
                    WHEN "1" => vStagei_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= rVStage_uid175_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c;
                    WHEN OTHERS => vStagei_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select(BITSELECT,264)@5
    rVStage_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b <= vStagei_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(3 downto 2);
    rVStage_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c <= vStagei_uid179_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(1 downto 0);

    -- vCount_uid182_lzCountVal_uid94_fpAddSubTest_ieeeAdd(LOGICAL,181)@5
    vCount_uid182_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "1" WHEN rVStage_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b = zs_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- vStagei_uid185_lzCountVal_uid94_fpAddSubTest_ieeeAdd(MUX,184)@5
    vStagei_uid185_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s <= vCount_uid182_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;
    vStagei_uid185_lzCountVal_uid94_fpAddSubTest_ieeeAdd_combproc: PROCESS (vStagei_uid185_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s, en, rVStage_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b, rVStage_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid185_lzCountVal_uid94_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => vStagei_uid185_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= rVStage_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_b;
            WHEN "1" => vStagei_uid185_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= rVStage_uid181_lzCountVal_uid94_fpAddSubTest_ieeeAdd_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid185_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid187_lzCountVal_uid94_fpAddSubTest_ieeeAdd(BITSELECT,186)@5
    rVStage_uid187_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b <= vStagei_uid185_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(1 downto 1);

    -- vCount_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd(LOGICAL,187)@5
    vCount_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= "1" WHEN rVStage_uid187_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b = GND_q ELSE "0";

    -- r_uid189_lzCountVal_uid94_fpAddSubTest_ieeeAdd(BITJOIN,188)@5
    r_uid189_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q <= redist3_vCount_uid162_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_2_q & redist1_vCount_uid170_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q & redist0_vCount_uid176_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q_1_q & vCount_uid182_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q & vCount_uid188_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;

    -- aMinusA_uid96_fpAddSubTest_ieeeAdd(LOGICAL,95)@5
    aMinusA_uid96_fpAddSubTest_ieeeAdd_q <= "1" WHEN r_uid189_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q = cAmA_uid95_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- invAMinusA_uid139_fpAddSubTest_ieeeAdd(LOGICAL,138)@5
    invAMinusA_uid139_fpAddSubTest_ieeeAdd_q <= not (aMinusA_uid96_fpAddSubTest_ieeeAdd_q);

    -- redist18_sigA_uid59_fpAddSubTest_ieeeAdd_b_5(DELAY,284)
    redist18_sigA_uid59_fpAddSubTest_ieeeAdd_b_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist17_sigA_uid59_fpAddSubTest_ieeeAdd_b_2_q, xout => redist18_sigA_uid59_fpAddSubTest_ieeeAdd_b_5_q, ena => en(0), clk => clk, aclr => areset );

    -- cstAllOWE_uid27_fpAddSubTest_ieeeAdd(CONSTANT,26)
    cstAllOWE_uid27_fpAddSubTest_ieeeAdd_q <= "11111111";

    -- expXIsMax_uid47_fpAddSubTest_ieeeAdd(LOGICAL,46)@1 + 1
    expXIsMax_uid47_fpAddSubTest_ieeeAdd_qi <= "1" WHEN redist27_exp_bSig_uid44_fpAddSubTest_ieeeAdd_b_1_q = cstAllOWE_uid27_fpAddSubTest_ieeeAdd_q ELSE "0";
    expXIsMax_uid47_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid47_fpAddSubTest_ieeeAdd_qi, xout => expXIsMax_uid47_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist23_expXIsMax_uid47_fpAddSubTest_ieeeAdd_q_4(DELAY,289)
    redist23_expXIsMax_uid47_fpAddSubTest_ieeeAdd_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => expXIsMax_uid47_fpAddSubTest_ieeeAdd_q, xout => redist23_expXIsMax_uid47_fpAddSubTest_ieeeAdd_q_4_q, ena => en(0), clk => clk, aclr => areset );

    -- invExpXIsMax_uid52_fpAddSubTest_ieeeAdd(LOGICAL,51)@5
    invExpXIsMax_uid52_fpAddSubTest_ieeeAdd_q <= not (redist23_expXIsMax_uid47_fpAddSubTest_ieeeAdd_q_4_q);

    -- redist19_InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q_4(DELAY,285)
    redist19_InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q, xout => redist19_InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q_4_q, ena => en(0), clk => clk, aclr => areset );

    -- excR_bSig_uid54_fpAddSubTest_ieeeAdd(LOGICAL,53)@5
    excR_bSig_uid54_fpAddSubTest_ieeeAdd_q <= redist19_InvExpXIsZero_uid53_fpAddSubTest_ieeeAdd_q_4_q and invExpXIsMax_uid52_fpAddSubTest_ieeeAdd_q;

    -- redist34_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_5(DELAY,300)
    redist34_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_5 : dspba_delay
    GENERIC MAP ( width => 8, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist33_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_1_q, xout => redist34_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_5_q, ena => en(0), clk => clk, aclr => areset );

    -- expXIsMax_uid33_fpAddSubTest_ieeeAdd(LOGICAL,32)@5
    expXIsMax_uid33_fpAddSubTest_ieeeAdd_q <= "1" WHEN redist34_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_5_q = cstAllOWE_uid27_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- invExpXIsMax_uid38_fpAddSubTest_ieeeAdd(LOGICAL,37)@5
    invExpXIsMax_uid38_fpAddSubTest_ieeeAdd_q <= not (expXIsMax_uid33_fpAddSubTest_ieeeAdd_q);

    -- excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd(LOGICAL,31)@5
    excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q <= "1" WHEN redist34_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_5_q = cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q ELSE "0";

    -- InvExpXIsZero_uid39_fpAddSubTest_ieeeAdd(LOGICAL,38)@5
    InvExpXIsZero_uid39_fpAddSubTest_ieeeAdd_q <= not (excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q);

    -- excR_aSig_uid40_fpAddSubTest_ieeeAdd(LOGICAL,39)@5
    excR_aSig_uid40_fpAddSubTest_ieeeAdd_q <= InvExpXIsZero_uid39_fpAddSubTest_ieeeAdd_q and invExpXIsMax_uid38_fpAddSubTest_ieeeAdd_q;

    -- signRReg_uid140_fpAddSubTest_ieeeAdd(LOGICAL,139)@5
    signRReg_uid140_fpAddSubTest_ieeeAdd_q <= excR_aSig_uid40_fpAddSubTest_ieeeAdd_q and excR_bSig_uid54_fpAddSubTest_ieeeAdd_q and redist18_sigA_uid59_fpAddSubTest_ieeeAdd_b_5_q and invAMinusA_uid139_fpAddSubTest_ieeeAdd_q;

    -- redist16_sigB_uid60_fpAddSubTest_ieeeAdd_b_5(DELAY,282)
    redist16_sigB_uid60_fpAddSubTest_ieeeAdd_b_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist15_sigB_uid60_fpAddSubTest_ieeeAdd_b_2_q, xout => redist16_sigB_uid60_fpAddSubTest_ieeeAdd_b_5_q, ena => en(0), clk => clk, aclr => areset );

    -- redist24_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_4(DELAY,290)
    redist24_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q, xout => redist24_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_4_q, ena => en(0), clk => clk, aclr => areset );

    -- excAZBZSigASigB_uid144_fpAddSubTest_ieeeAdd(LOGICAL,143)@5
    excAZBZSigASigB_uid144_fpAddSubTest_ieeeAdd_q <= excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q and redist24_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_4_q and redist18_sigA_uid59_fpAddSubTest_ieeeAdd_b_5_q and redist16_sigB_uid60_fpAddSubTest_ieeeAdd_b_5_q;

    -- excBZARSigA_uid145_fpAddSubTest_ieeeAdd(LOGICAL,144)@5
    excBZARSigA_uid145_fpAddSubTest_ieeeAdd_q <= redist24_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_4_q and excR_aSig_uid40_fpAddSubTest_ieeeAdd_q and redist18_sigA_uid59_fpAddSubTest_ieeeAdd_b_5_q;

    -- signRZero_uid146_fpAddSubTest_ieeeAdd(LOGICAL,145)@5
    signRZero_uid146_fpAddSubTest_ieeeAdd_q <= excBZARSigA_uid145_fpAddSubTest_ieeeAdd_q or excAZBZSigASigB_uid144_fpAddSubTest_ieeeAdd_q;

    -- fracXIsZero_uid48_fpAddSubTest_ieeeAdd(LOGICAL,47)@1 + 1
    fracXIsZero_uid48_fpAddSubTest_ieeeAdd_qi <= "1" WHEN cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q = redist26_frac_bSig_uid45_fpAddSubTest_ieeeAdd_b_1_q ELSE "0";
    fracXIsZero_uid48_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid48_fpAddSubTest_ieeeAdd_qi, xout => fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist22_fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q_4(DELAY,288)
    redist22_fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q, xout => redist22_fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q_4_q, ena => en(0), clk => clk, aclr => areset );

    -- excI_bSig_uid50_fpAddSubTest_ieeeAdd(LOGICAL,49)@5
    excI_bSig_uid50_fpAddSubTest_ieeeAdd_q <= redist23_expXIsMax_uid47_fpAddSubTest_ieeeAdd_q_4_q and redist22_fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q_4_q;

    -- sigBBInf_uid141_fpAddSubTest_ieeeAdd(LOGICAL,140)@5
    sigBBInf_uid141_fpAddSubTest_ieeeAdd_q <= redist16_sigB_uid60_fpAddSubTest_ieeeAdd_b_5_q and excI_bSig_uid50_fpAddSubTest_ieeeAdd_q;

    -- fracXIsZero_uid34_fpAddSubTest_ieeeAdd(LOGICAL,33)@3 + 1
    fracXIsZero_uid34_fpAddSubTest_ieeeAdd_qi <= "1" WHEN cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q = redist32_frac_aSig_uid31_fpAddSubTest_ieeeAdd_b_3_q ELSE "0";
    fracXIsZero_uid34_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid34_fpAddSubTest_ieeeAdd_qi, xout => fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist30_fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q_2(DELAY,296)
    redist30_fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q, xout => redist30_fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- excI_aSig_uid36_fpAddSubTest_ieeeAdd(LOGICAL,35)@5
    excI_aSig_uid36_fpAddSubTest_ieeeAdd_q <= expXIsMax_uid33_fpAddSubTest_ieeeAdd_q and redist30_fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q_2_q;

    -- sigAAInf_uid142_fpAddSubTest_ieeeAdd(LOGICAL,141)@5
    sigAAInf_uid142_fpAddSubTest_ieeeAdd_q <= redist18_sigA_uid59_fpAddSubTest_ieeeAdd_b_5_q and excI_aSig_uid36_fpAddSubTest_ieeeAdd_q;

    -- signRInf_uid143_fpAddSubTest_ieeeAdd(LOGICAL,142)@5
    signRInf_uid143_fpAddSubTest_ieeeAdd_q <= sigAAInf_uid142_fpAddSubTest_ieeeAdd_q or sigBBInf_uid141_fpAddSubTest_ieeeAdd_q;

    -- signRInfRZRReg_uid147_fpAddSubTest_ieeeAdd(LOGICAL,146)@5 + 1
    signRInfRZRReg_uid147_fpAddSubTest_ieeeAdd_qi <= signRInf_uid143_fpAddSubTest_ieeeAdd_q or signRZero_uid146_fpAddSubTest_ieeeAdd_q or signRReg_uid140_fpAddSubTest_ieeeAdd_q;
    signRInfRZRReg_uid147_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signRInfRZRReg_uid147_fpAddSubTest_ieeeAdd_qi, xout => signRInfRZRReg_uid147_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist5_signRInfRZRReg_uid147_fpAddSubTest_ieeeAdd_q_2(DELAY,271)
    redist5_signRInfRZRReg_uid147_fpAddSubTest_ieeeAdd_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signRInfRZRReg_uid147_fpAddSubTest_ieeeAdd_q, xout => redist5_signRInfRZRReg_uid147_fpAddSubTest_ieeeAdd_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- fracXIsNotZero_uid49_fpAddSubTest_ieeeAdd(LOGICAL,48)@5
    fracXIsNotZero_uid49_fpAddSubTest_ieeeAdd_q <= not (redist22_fracXIsZero_uid48_fpAddSubTest_ieeeAdd_q_4_q);

    -- excN_bSig_uid51_fpAddSubTest_ieeeAdd(LOGICAL,50)@5 + 1
    excN_bSig_uid51_fpAddSubTest_ieeeAdd_qi <= redist23_expXIsMax_uid47_fpAddSubTest_ieeeAdd_q_4_q and fracXIsNotZero_uid49_fpAddSubTest_ieeeAdd_q;
    excN_bSig_uid51_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excN_bSig_uid51_fpAddSubTest_ieeeAdd_qi, xout => excN_bSig_uid51_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist20_excN_bSig_uid51_fpAddSubTest_ieeeAdd_q_2(DELAY,286)
    redist20_excN_bSig_uid51_fpAddSubTest_ieeeAdd_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excN_bSig_uid51_fpAddSubTest_ieeeAdd_q, xout => redist20_excN_bSig_uid51_fpAddSubTest_ieeeAdd_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- fracXIsNotZero_uid35_fpAddSubTest_ieeeAdd(LOGICAL,34)@5
    fracXIsNotZero_uid35_fpAddSubTest_ieeeAdd_q <= not (redist30_fracXIsZero_uid34_fpAddSubTest_ieeeAdd_q_2_q);

    -- excN_aSig_uid37_fpAddSubTest_ieeeAdd(LOGICAL,36)@5 + 1
    excN_aSig_uid37_fpAddSubTest_ieeeAdd_qi <= expXIsMax_uid33_fpAddSubTest_ieeeAdd_q and fracXIsNotZero_uid35_fpAddSubTest_ieeeAdd_q;
    excN_aSig_uid37_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excN_aSig_uid37_fpAddSubTest_ieeeAdd_qi, xout => excN_aSig_uid37_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist28_excN_aSig_uid37_fpAddSubTest_ieeeAdd_q_2(DELAY,294)
    redist28_excN_aSig_uid37_fpAddSubTest_ieeeAdd_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => excN_aSig_uid37_fpAddSubTest_ieeeAdd_q, xout => redist28_excN_aSig_uid37_fpAddSubTest_ieeeAdd_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- excRNaN2_uid134_fpAddSubTest_ieeeAdd(LOGICAL,133)@7
    excRNaN2_uid134_fpAddSubTest_ieeeAdd_q <= redist28_excN_aSig_uid37_fpAddSubTest_ieeeAdd_q_2_q or redist20_excN_bSig_uid51_fpAddSubTest_ieeeAdd_q_2_q;

    -- redist14_effSub_uid61_fpAddSubTest_ieeeAdd_q_5(DELAY,280)
    redist14_effSub_uid61_fpAddSubTest_ieeeAdd_q_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC" )
    PORT MAP ( xin => effSub_uid61_fpAddSubTest_ieeeAdd_q, xout => redist14_effSub_uid61_fpAddSubTest_ieeeAdd_q_5_q, ena => en(0), clk => clk, aclr => areset );

    -- redist21_excI_bSig_uid50_fpAddSubTest_ieeeAdd_q_2(DELAY,287)
    redist21_excI_bSig_uid50_fpAddSubTest_ieeeAdd_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => excI_bSig_uid50_fpAddSubTest_ieeeAdd_q, xout => redist21_excI_bSig_uid50_fpAddSubTest_ieeeAdd_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- redist29_excI_aSig_uid36_fpAddSubTest_ieeeAdd_q_2(DELAY,295)
    redist29_excI_aSig_uid36_fpAddSubTest_ieeeAdd_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => excI_aSig_uid36_fpAddSubTest_ieeeAdd_q, xout => redist29_excI_aSig_uid36_fpAddSubTest_ieeeAdd_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- excAIBISub_uid135_fpAddSubTest_ieeeAdd(LOGICAL,134)@7
    excAIBISub_uid135_fpAddSubTest_ieeeAdd_q <= redist29_excI_aSig_uid36_fpAddSubTest_ieeeAdd_q_2_q and redist21_excI_bSig_uid50_fpAddSubTest_ieeeAdd_q_2_q and redist14_effSub_uid61_fpAddSubTest_ieeeAdd_q_5_q;

    -- excRNaN_uid136_fpAddSubTest_ieeeAdd(LOGICAL,135)@7
    excRNaN_uid136_fpAddSubTest_ieeeAdd_q <= excAIBISub_uid135_fpAddSubTest_ieeeAdd_q or excRNaN2_uid134_fpAddSubTest_ieeeAdd_q;

    -- invExcRNaN_uid148_fpAddSubTest_ieeeAdd(LOGICAL,147)@7
    invExcRNaN_uid148_fpAddSubTest_ieeeAdd_q <= not (excRNaN_uid136_fpAddSubTest_ieeeAdd_q);

    -- signRPostExc_uid149_fpAddSubTest_ieeeAdd(LOGICAL,148)@7
    signRPostExc_uid149_fpAddSubTest_ieeeAdd_q <= invExcRNaN_uid148_fpAddSubTest_ieeeAdd_q and redist5_signRInfRZRReg_uid147_fpAddSubTest_ieeeAdd_q_2_q;

    -- cRBit_uid108_fpAddSubTest_ieeeAdd(CONSTANT,107)
    cRBit_uid108_fpAddSubTest_ieeeAdd_q <= "01000";

    -- leftShiftStage2Idx1Rng1_uid256_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITSELECT,255)@5
    leftShiftStage2Idx1Rng1_uid256_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in <= leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(26 downto 0);
    leftShiftStage2Idx1Rng1_uid256_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b <= leftShiftStage2Idx1Rng1_uid256_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in(26 downto 0);

    -- leftShiftStage2Idx1_uid257_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITJOIN,256)@5
    leftShiftStage2Idx1_uid257_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage2Idx1Rng1_uid256_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b & GND_q;

    -- leftShiftStage1Idx3Rng6_uid251_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITSELECT,250)@5
    leftShiftStage1Idx3Rng6_uid251_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in <= leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(21 downto 0);
    leftShiftStage1Idx3Rng6_uid251_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b <= leftShiftStage1Idx3Rng6_uid251_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in(21 downto 0);

    -- leftShiftStage1Idx3Pad6_uid250_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(CONSTANT,249)
    leftShiftStage1Idx3Pad6_uid250_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= "000000";

    -- leftShiftStage1Idx3_uid252_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITJOIN,251)@5
    leftShiftStage1Idx3_uid252_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage1Idx3Rng6_uid251_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b & leftShiftStage1Idx3Pad6_uid250_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;

    -- leftShiftStage1Idx2Rng4_uid248_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITSELECT,247)@5
    leftShiftStage1Idx2Rng4_uid248_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in <= leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(23 downto 0);
    leftShiftStage1Idx2Rng4_uid248_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b <= leftShiftStage1Idx2Rng4_uid248_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in(23 downto 0);

    -- leftShiftStage1Idx2_uid249_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITJOIN,248)@5
    leftShiftStage1Idx2_uid249_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage1Idx2Rng4_uid248_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b & zs_uid174_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;

    -- leftShiftStage1Idx1Rng2_uid245_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITSELECT,244)@5
    leftShiftStage1Idx1Rng2_uid245_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in <= leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(25 downto 0);
    leftShiftStage1Idx1Rng2_uid245_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b <= leftShiftStage1Idx1Rng2_uid245_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in(25 downto 0);

    -- leftShiftStage1Idx1_uid246_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITJOIN,245)@5
    leftShiftStage1Idx1_uid246_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage1Idx1Rng2_uid245_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b & zs_uid180_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;

    -- leftShiftStage0Idx3Rng24_uid240_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITSELECT,239)@5
    leftShiftStage0Idx3Rng24_uid240_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in <= redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_2_q(3 downto 0);
    leftShiftStage0Idx3Rng24_uid240_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b <= leftShiftStage0Idx3Rng24_uid240_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in(3 downto 0);

    -- leftShiftStage0Idx3Pad24_uid239_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(CONSTANT,238)
    leftShiftStage0Idx3Pad24_uid239_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= "000000000000000000000000";

    -- leftShiftStage0Idx3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITJOIN,240)@5
    leftShiftStage0Idx3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage0Idx3Rng24_uid240_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b & leftShiftStage0Idx3Pad24_uid239_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;

    -- redist2_vStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1(DELAY,268)
    redist2_vStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b, xout => redist2_vStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- leftShiftStage0Idx2_uid238_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITJOIN,237)@5
    leftShiftStage0Idx2_uid238_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= redist2_vStage_uid164_lzCountVal_uid94_fpAddSubTest_ieeeAdd_b_1_q & zs_uid160_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q;

    -- leftShiftStage0Idx1Rng8_uid234_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITSELECT,233)@5
    leftShiftStage0Idx1Rng8_uid234_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in <= redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_2_q(19 downto 0);
    leftShiftStage0Idx1Rng8_uid234_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b <= leftShiftStage0Idx1Rng8_uid234_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_in(19 downto 0);

    -- leftShiftStage0Idx1_uid235_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(BITJOIN,234)@5
    leftShiftStage0Idx1_uid235_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage0Idx1Rng8_uid234_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_b & cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q;

    -- redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_2(DELAY,279)
    redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_2 : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist12_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_1_q, xout => redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(MUX,242)@5
    leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s <= leftShiftStageSel4Dto3_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_b;
    leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_combproc: PROCESS (leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s, en, redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_2_q, leftShiftStage0Idx1_uid235_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q, leftShiftStage0Idx2_uid238_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q, leftShiftStage0Idx3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s) IS
            WHEN "00" => leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= redist13_fracGRS_uid93_fpAddSubTest_ieeeAdd_q_2_q;
            WHEN "01" => leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage0Idx1_uid235_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN "10" => leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage0Idx2_uid238_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN "11" => leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage0Idx3_uid241_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(MUX,253)@5
    leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s <= leftShiftStageSel4Dto3_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_c;
    leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_combproc: PROCESS (leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s, en, leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q, leftShiftStage1Idx1_uid246_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q, leftShiftStage1Idx2_uid249_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q, leftShiftStage1Idx3_uid252_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s) IS
            WHEN "00" => leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage0_uid243_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN "01" => leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage1Idx1_uid246_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN "10" => leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage1Idx2_uid249_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN "11" => leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage1Idx3_uid252_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStageSel4Dto3_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select(BITSELECT,265)@5
    leftShiftStageSel4Dto3_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_b <= r_uid189_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(4 downto 3);
    leftShiftStageSel4Dto3_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_c <= r_uid189_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(2 downto 1);
    leftShiftStageSel4Dto3_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_d <= r_uid189_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q(0 downto 0);

    -- leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd(MUX,258)@5
    leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s <= leftShiftStageSel4Dto3_uid242_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_merged_bit_select_d;
    leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_combproc: PROCESS (leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s, en, leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q, leftShiftStage2Idx1_uid257_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_s) IS
            WHEN "0" => leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage1_uid254_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN "1" => leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= leftShiftStage2Idx1_uid257_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- LSB_uid106_fpAddSubTest_ieeeAdd(BITSELECT,105)@5
    LSB_uid106_fpAddSubTest_ieeeAdd_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(4 downto 0));
    LSB_uid106_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(LSB_uid106_fpAddSubTest_ieeeAdd_in(4 downto 4));

    -- Guard_uid105_fpAddSubTest_ieeeAdd(BITSELECT,104)@5
    Guard_uid105_fpAddSubTest_ieeeAdd_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(3 downto 0));
    Guard_uid105_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(Guard_uid105_fpAddSubTest_ieeeAdd_in(3 downto 3));

    -- Round_uid104_fpAddSubTest_ieeeAdd(BITSELECT,103)@5
    Round_uid104_fpAddSubTest_ieeeAdd_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(2 downto 0));
    Round_uid104_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(Round_uid104_fpAddSubTest_ieeeAdd_in(2 downto 2));

    -- Sticky1_uid103_fpAddSubTest_ieeeAdd(BITSELECT,102)@5
    Sticky1_uid103_fpAddSubTest_ieeeAdd_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(1 downto 0));
    Sticky1_uid103_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(Sticky1_uid103_fpAddSubTest_ieeeAdd_in(1 downto 1));

    -- Sticky0_uid102_fpAddSubTest_ieeeAdd(BITSELECT,101)@5
    Sticky0_uid102_fpAddSubTest_ieeeAdd_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(0 downto 0));
    Sticky0_uid102_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(Sticky0_uid102_fpAddSubTest_ieeeAdd_in(0 downto 0));

    -- rndBitCond_uid107_fpAddSubTest_ieeeAdd(BITJOIN,106)@5
    rndBitCond_uid107_fpAddSubTest_ieeeAdd_q <= LSB_uid106_fpAddSubTest_ieeeAdd_b & Guard_uid105_fpAddSubTest_ieeeAdd_b & Round_uid104_fpAddSubTest_ieeeAdd_b & Sticky1_uid103_fpAddSubTest_ieeeAdd_b & Sticky0_uid102_fpAddSubTest_ieeeAdd_b;

    -- rBi_uid109_fpAddSubTest_ieeeAdd(LOGICAL,108)@5 + 1
    rBi_uid109_fpAddSubTest_ieeeAdd_qi <= "1" WHEN rndBitCond_uid107_fpAddSubTest_ieeeAdd_q = cRBit_uid108_fpAddSubTest_ieeeAdd_q ELSE "0";
    rBi_uid109_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rBi_uid109_fpAddSubTest_ieeeAdd_qi, xout => rBi_uid109_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- roundBit_uid110_fpAddSubTest_ieeeAdd(LOGICAL,109)@6
    roundBit_uid110_fpAddSubTest_ieeeAdd_q <= not (rBi_uid109_fpAddSubTest_ieeeAdd_q);

    -- oneCST_uid99_fpAddSubTest_ieeeAdd(CONSTANT,98)
    oneCST_uid99_fpAddSubTest_ieeeAdd_q <= "00000001";

    -- expInc_uid100_fpAddSubTest_ieeeAdd(ADD,99)@5
    expInc_uid100_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("0" & redist34_exp_aSig_uid30_fpAddSubTest_ieeeAdd_b_5_q);
    expInc_uid100_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("0" & oneCST_uid99_fpAddSubTest_ieeeAdd_q);
    expInc_uid100_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(expInc_uid100_fpAddSubTest_ieeeAdd_a) + UNSIGNED(expInc_uid100_fpAddSubTest_ieeeAdd_b));
    expInc_uid100_fpAddSubTest_ieeeAdd_q <= expInc_uid100_fpAddSubTest_ieeeAdd_o(8 downto 0);

    -- expPostNorm_uid101_fpAddSubTest_ieeeAdd(SUB,100)@5 + 1
    expPostNorm_uid101_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("0" & expInc_uid100_fpAddSubTest_ieeeAdd_q);
    expPostNorm_uid101_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("00000" & r_uid189_lzCountVal_uid94_fpAddSubTest_ieeeAdd_q);
    expPostNorm_uid101_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            expPostNorm_uid101_fpAddSubTest_ieeeAdd_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                expPostNorm_uid101_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(expPostNorm_uid101_fpAddSubTest_ieeeAdd_a) - UNSIGNED(expPostNorm_uid101_fpAddSubTest_ieeeAdd_b));
            END IF;
        END IF;
    END PROCESS;
    expPostNorm_uid101_fpAddSubTest_ieeeAdd_q <= expPostNorm_uid101_fpAddSubTest_ieeeAdd_o(9 downto 0);

    -- fracPostNorm_uid98_fpAddSubTest_ieeeAdd(BITSELECT,97)@5
    fracPostNorm_uid98_fpAddSubTest_ieeeAdd_b <= leftShiftStage2_uid259_fracPostNormExt_uid97_fpAddSubTest_ieeeAdd_q(27 downto 1);

    -- fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd(BITSELECT,110)@5
    fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_in <= fracPostNorm_uid98_fpAddSubTest_ieeeAdd_b(25 downto 0);
    fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b <= fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_in(25 downto 2);

    -- redist10_fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b_1(DELAY,276)
    redist10_fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b, xout => redist10_fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- expFracR_uid112_fpAddSubTest_ieeeAdd(BITJOIN,111)@6
    expFracR_uid112_fpAddSubTest_ieeeAdd_q <= expPostNorm_uid101_fpAddSubTest_ieeeAdd_q & redist10_fracPostNormRndRange_uid111_fpAddSubTest_ieeeAdd_b_1_q;

    -- rndExpFrac_uid113_fpAddSubTest_ieeeAdd(ADD,112)@6
    rndExpFrac_uid113_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("0" & expFracR_uid112_fpAddSubTest_ieeeAdd_q);
    rndExpFrac_uid113_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("0000000000000000000000000000000000" & roundBit_uid110_fpAddSubTest_ieeeAdd_q);
    rndExpFrac_uid113_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(rndExpFrac_uid113_fpAddSubTest_ieeeAdd_a) + UNSIGNED(rndExpFrac_uid113_fpAddSubTest_ieeeAdd_b));
    rndExpFrac_uid113_fpAddSubTest_ieeeAdd_q <= rndExpFrac_uid113_fpAddSubTest_ieeeAdd_o(34 downto 0);

    -- expRPreExc_uid127_fpAddSubTest_ieeeAdd(BITSELECT,126)@6
    expRPreExc_uid127_fpAddSubTest_ieeeAdd_in <= rndExpFrac_uid113_fpAddSubTest_ieeeAdd_q(31 downto 0);
    expRPreExc_uid127_fpAddSubTest_ieeeAdd_b <= expRPreExc_uid127_fpAddSubTest_ieeeAdd_in(31 downto 24);

    -- redist7_expRPreExc_uid127_fpAddSubTest_ieeeAdd_b_1(DELAY,273)
    redist7_expRPreExc_uid127_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => expRPreExc_uid127_fpAddSubTest_ieeeAdd_b, xout => redist7_expRPreExc_uid127_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- rndExpFracOvfBits_uid118_fpAddSubTest_ieeeAdd(BITSELECT,117)@6
    rndExpFracOvfBits_uid118_fpAddSubTest_ieeeAdd_in <= rndExpFrac_uid113_fpAddSubTest_ieeeAdd_q(33 downto 0);
    rndExpFracOvfBits_uid118_fpAddSubTest_ieeeAdd_b <= rndExpFracOvfBits_uid118_fpAddSubTest_ieeeAdd_in(33 downto 32);

    -- rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd(COMPARE,118)@6 + 1
    rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_a <= STD_LOGIC_VECTOR("00" & rndExpFracOvfBits_uid118_fpAddSubTest_ieeeAdd_b);
    rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR("00" & zocst_uid85_fpAddSubTest_ieeeAdd_q);
    rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_o <= STD_LOGIC_VECTOR(UNSIGNED(rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_a) - UNSIGNED(rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_b));
            END IF;
        END IF;
    END PROCESS;
    rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_n(0) <= not (rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_o(3));

    -- wEP2AllOwE_uid114_fpAddSubTest_ieeeAdd(CONSTANT,113)
    wEP2AllOwE_uid114_fpAddSubTest_ieeeAdd_q <= "0011111111";

    -- rndExp_uid115_fpAddSubTest_ieeeAdd(BITSELECT,114)@6
    rndExp_uid115_fpAddSubTest_ieeeAdd_in <= rndExpFrac_uid113_fpAddSubTest_ieeeAdd_q(33 downto 0);
    rndExp_uid115_fpAddSubTest_ieeeAdd_b <= rndExp_uid115_fpAddSubTest_ieeeAdd_in(33 downto 24);

    -- rOvfEQMax_uid116_fpAddSubTest_ieeeAdd(LOGICAL,115)@6 + 1
    rOvfEQMax_uid116_fpAddSubTest_ieeeAdd_qi <= "1" WHEN rndExp_uid115_fpAddSubTest_ieeeAdd_b = wEP2AllOwE_uid114_fpAddSubTest_ieeeAdd_q ELSE "0";
    rOvfEQMax_uid116_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rOvfEQMax_uid116_fpAddSubTest_ieeeAdd_qi, xout => rOvfEQMax_uid116_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- rOvf_uid120_fpAddSubTest_ieeeAdd(LOGICAL,119)@7
    rOvf_uid120_fpAddSubTest_ieeeAdd_q <= rOvfEQMax_uid116_fpAddSubTest_ieeeAdd_q or rOvfExtraBits_uid119_fpAddSubTest_ieeeAdd_n;

    -- regInputs_uid128_fpAddSubTest_ieeeAdd(LOGICAL,127)@5 + 1
    regInputs_uid128_fpAddSubTest_ieeeAdd_qi <= excR_aSig_uid40_fpAddSubTest_ieeeAdd_q and excR_bSig_uid54_fpAddSubTest_ieeeAdd_q;
    regInputs_uid128_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => regInputs_uid128_fpAddSubTest_ieeeAdd_qi, xout => regInputs_uid128_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- redist6_regInputs_uid128_fpAddSubTest_ieeeAdd_q_2(DELAY,272)
    redist6_regInputs_uid128_fpAddSubTest_ieeeAdd_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => regInputs_uid128_fpAddSubTest_ieeeAdd_q, xout => redist6_regInputs_uid128_fpAddSubTest_ieeeAdd_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- rInfOvf_uid131_fpAddSubTest_ieeeAdd(LOGICAL,130)@7
    rInfOvf_uid131_fpAddSubTest_ieeeAdd_q <= redist6_regInputs_uid128_fpAddSubTest_ieeeAdd_q_2_q and rOvf_uid120_fpAddSubTest_ieeeAdd_q;

    -- excRInfVInC_uid132_fpAddSubTest_ieeeAdd(BITJOIN,131)@7
    excRInfVInC_uid132_fpAddSubTest_ieeeAdd_q <= rInfOvf_uid131_fpAddSubTest_ieeeAdd_q & redist20_excN_bSig_uid51_fpAddSubTest_ieeeAdd_q_2_q & redist28_excN_aSig_uid37_fpAddSubTest_ieeeAdd_q_2_q & redist21_excI_bSig_uid50_fpAddSubTest_ieeeAdd_q_2_q & redist29_excI_aSig_uid36_fpAddSubTest_ieeeAdd_q_2_q & redist14_effSub_uid61_fpAddSubTest_ieeeAdd_q_5_q;

    -- excRInf_uid133_fpAddSubTest_ieeeAdd(LOOKUP,132)@7
    excRInf_uid133_fpAddSubTest_ieeeAdd_combproc: PROCESS (excRInfVInC_uid132_fpAddSubTest_ieeeAdd_q)
    BEGIN
        -- Begin reserved scope level
        CASE (excRInfVInC_uid132_fpAddSubTest_ieeeAdd_q) IS
            WHEN "000000" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "000001" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "000010" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "000011" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "000100" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "000101" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "000110" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "000111" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001000" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001001" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001010" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001011" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001100" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001101" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001110" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "001111" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010000" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010001" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010010" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010011" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010100" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010101" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010110" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "010111" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011000" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011001" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011010" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011011" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011100" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011101" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011110" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "011111" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "100000" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "100001" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "100010" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "100011" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "100100" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "100101" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "100110" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "100111" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101000" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101001" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101010" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101011" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101100" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101101" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101110" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "101111" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110000" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110001" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110010" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110011" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110100" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110101" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110110" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "110111" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111000" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111001" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111010" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111011" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111100" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111101" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111110" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "111111" => excRInf_uid133_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN OTHERS => -- unreachable
                           excRInf_uid133_fpAddSubTest_ieeeAdd_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- redist11_aMinusA_uid96_fpAddSubTest_ieeeAdd_q_2(DELAY,277)
    redist11_aMinusA_uid96_fpAddSubTest_ieeeAdd_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => aMinusA_uid96_fpAddSubTest_ieeeAdd_q, xout => redist11_aMinusA_uid96_fpAddSubTest_ieeeAdd_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- rUdfExtraBit_uid124_fpAddSubTest_ieeeAdd(BITSELECT,123)@6
    rUdfExtraBit_uid124_fpAddSubTest_ieeeAdd_in <= STD_LOGIC_VECTOR(rndExpFrac_uid113_fpAddSubTest_ieeeAdd_q(33 downto 0));
    rUdfExtraBit_uid124_fpAddSubTest_ieeeAdd_b <= STD_LOGIC_VECTOR(rUdfExtraBit_uid124_fpAddSubTest_ieeeAdd_in(33 downto 33));

    -- redist9_rUdfExtraBit_uid124_fpAddSubTest_ieeeAdd_b_1(DELAY,275)
    redist9_rUdfExtraBit_uid124_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rUdfExtraBit_uid124_fpAddSubTest_ieeeAdd_b, xout => redist9_rUdfExtraBit_uid124_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- wEP2AllZ_uid121_fpAddSubTest_ieeeAdd(CONSTANT,120)
    wEP2AllZ_uid121_fpAddSubTest_ieeeAdd_q <= "0000000000";

    -- rUdfEQMin_uid123_fpAddSubTest_ieeeAdd(LOGICAL,122)@6 + 1
    rUdfEQMin_uid123_fpAddSubTest_ieeeAdd_qi <= "1" WHEN rndExp_uid115_fpAddSubTest_ieeeAdd_b = wEP2AllZ_uid121_fpAddSubTest_ieeeAdd_q ELSE "0";
    rUdfEQMin_uid123_fpAddSubTest_ieeeAdd_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rUdfEQMin_uid123_fpAddSubTest_ieeeAdd_qi, xout => rUdfEQMin_uid123_fpAddSubTest_ieeeAdd_q, ena => en(0), clk => clk, aclr => areset );

    -- rUdf_uid125_fpAddSubTest_ieeeAdd(LOGICAL,124)@7
    rUdf_uid125_fpAddSubTest_ieeeAdd_q <= rUdfEQMin_uid123_fpAddSubTest_ieeeAdd_q or redist9_rUdfExtraBit_uid124_fpAddSubTest_ieeeAdd_b_1_q;

    -- redist25_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_6(DELAY,291)
    redist25_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist24_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_4_q, xout => redist25_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_6_q, ena => en(0), clk => clk, aclr => areset );

    -- redist31_excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q_2(DELAY,297)
    redist31_excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q, xout => redist31_excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- excRZeroVInC_uid129_fpAddSubTest_ieeeAdd(BITJOIN,128)@7
    excRZeroVInC_uid129_fpAddSubTest_ieeeAdd_q <= redist11_aMinusA_uid96_fpAddSubTest_ieeeAdd_q_2_q & rUdf_uid125_fpAddSubTest_ieeeAdd_q & redist6_regInputs_uid128_fpAddSubTest_ieeeAdd_q_2_q & redist25_excZ_bSig_uid26_uid46_fpAddSubTest_ieeeAdd_q_6_q & redist31_excZ_aSig_uid25_uid32_fpAddSubTest_ieeeAdd_q_2_q;

    -- excRZero_uid130_fpAddSubTest_ieeeAdd(LOOKUP,129)@7
    excRZero_uid130_fpAddSubTest_ieeeAdd_combproc: PROCESS (excRZeroVInC_uid129_fpAddSubTest_ieeeAdd_q)
    BEGIN
        -- Begin reserved scope level
        CASE (excRZeroVInC_uid129_fpAddSubTest_ieeeAdd_q) IS
            WHEN "00000" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "00001" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "00010" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "00011" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "00100" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "00101" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "00110" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "00111" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "01000" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "01001" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "01010" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "01011" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "01100" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "01101" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "01110" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "01111" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "10000" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "10001" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "10010" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "10011" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "10100" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "10101" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "10110" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "10111" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "11000" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "11001" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "11010" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "11011" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "11100" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "1";
            WHEN "11101" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "11110" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN "11111" => excRZero_uid130_fpAddSubTest_ieeeAdd_q <= "0";
            WHEN OTHERS => -- unreachable
                           excRZero_uid130_fpAddSubTest_ieeeAdd_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- concExc_uid137_fpAddSubTest_ieeeAdd(BITJOIN,136)@7
    concExc_uid137_fpAddSubTest_ieeeAdd_q <= excRNaN_uid136_fpAddSubTest_ieeeAdd_q & excRInf_uid133_fpAddSubTest_ieeeAdd_q & excRZero_uid130_fpAddSubTest_ieeeAdd_q;

    -- excREnc_uid138_fpAddSubTest_ieeeAdd(LOOKUP,137)@7
    excREnc_uid138_fpAddSubTest_ieeeAdd_combproc: PROCESS (concExc_uid137_fpAddSubTest_ieeeAdd_q)
    BEGIN
        -- Begin reserved scope level
        CASE (concExc_uid137_fpAddSubTest_ieeeAdd_q) IS
            WHEN "000" => excREnc_uid138_fpAddSubTest_ieeeAdd_q <= "01";
            WHEN "001" => excREnc_uid138_fpAddSubTest_ieeeAdd_q <= "00";
            WHEN "010" => excREnc_uid138_fpAddSubTest_ieeeAdd_q <= "10";
            WHEN "011" => excREnc_uid138_fpAddSubTest_ieeeAdd_q <= "10";
            WHEN "100" => excREnc_uid138_fpAddSubTest_ieeeAdd_q <= "11";
            WHEN "101" => excREnc_uid138_fpAddSubTest_ieeeAdd_q <= "11";
            WHEN "110" => excREnc_uid138_fpAddSubTest_ieeeAdd_q <= "11";
            WHEN "111" => excREnc_uid138_fpAddSubTest_ieeeAdd_q <= "11";
            WHEN OTHERS => -- unreachable
                           excREnc_uid138_fpAddSubTest_ieeeAdd_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- expRPostExc_uid157_fpAddSubTest_ieeeAdd(MUX,156)@7
    expRPostExc_uid157_fpAddSubTest_ieeeAdd_s <= excREnc_uid138_fpAddSubTest_ieeeAdd_q;
    expRPostExc_uid157_fpAddSubTest_ieeeAdd_combproc: PROCESS (expRPostExc_uid157_fpAddSubTest_ieeeAdd_s, en, cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q, redist7_expRPreExc_uid127_fpAddSubTest_ieeeAdd_b_1_q, cstAllOWE_uid27_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (expRPostExc_uid157_fpAddSubTest_ieeeAdd_s) IS
            WHEN "00" => expRPostExc_uid157_fpAddSubTest_ieeeAdd_q <= cstAllZWE_uid29_fpAddSubTest_ieeeAdd_q;
            WHEN "01" => expRPostExc_uid157_fpAddSubTest_ieeeAdd_q <= redist7_expRPreExc_uid127_fpAddSubTest_ieeeAdd_b_1_q;
            WHEN "10" => expRPostExc_uid157_fpAddSubTest_ieeeAdd_q <= cstAllOWE_uid27_fpAddSubTest_ieeeAdd_q;
            WHEN "11" => expRPostExc_uid157_fpAddSubTest_ieeeAdd_q <= cstAllOWE_uid27_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => expRPostExc_uid157_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oneFracRPostExc2_uid150_fpAddSubTest_ieeeAdd(CONSTANT,149)
    oneFracRPostExc2_uid150_fpAddSubTest_ieeeAdd_q <= "00000000000000000000001";

    -- fracRPreExc_uid126_fpAddSubTest_ieeeAdd(BITSELECT,125)@6
    fracRPreExc_uid126_fpAddSubTest_ieeeAdd_in <= rndExpFrac_uid113_fpAddSubTest_ieeeAdd_q(23 downto 0);
    fracRPreExc_uid126_fpAddSubTest_ieeeAdd_b <= fracRPreExc_uid126_fpAddSubTest_ieeeAdd_in(23 downto 1);

    -- redist8_fracRPreExc_uid126_fpAddSubTest_ieeeAdd_b_1(DELAY,274)
    redist8_fracRPreExc_uid126_fpAddSubTest_ieeeAdd_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracRPreExc_uid126_fpAddSubTest_ieeeAdd_b, xout => redist8_fracRPreExc_uid126_fpAddSubTest_ieeeAdd_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- fracRPostExc_uid153_fpAddSubTest_ieeeAdd(MUX,152)@7
    fracRPostExc_uid153_fpAddSubTest_ieeeAdd_s <= excREnc_uid138_fpAddSubTest_ieeeAdd_q;
    fracRPostExc_uid153_fpAddSubTest_ieeeAdd_combproc: PROCESS (fracRPostExc_uid153_fpAddSubTest_ieeeAdd_s, en, cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q, redist8_fracRPreExc_uid126_fpAddSubTest_ieeeAdd_b_1_q, oneFracRPostExc2_uid150_fpAddSubTest_ieeeAdd_q)
    BEGIN
        CASE (fracRPostExc_uid153_fpAddSubTest_ieeeAdd_s) IS
            WHEN "00" => fracRPostExc_uid153_fpAddSubTest_ieeeAdd_q <= cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q;
            WHEN "01" => fracRPostExc_uid153_fpAddSubTest_ieeeAdd_q <= redist8_fracRPreExc_uid126_fpAddSubTest_ieeeAdd_b_1_q;
            WHEN "10" => fracRPostExc_uid153_fpAddSubTest_ieeeAdd_q <= cstZeroWF_uid28_fpAddSubTest_ieeeAdd_q;
            WHEN "11" => fracRPostExc_uid153_fpAddSubTest_ieeeAdd_q <= oneFracRPostExc2_uid150_fpAddSubTest_ieeeAdd_q;
            WHEN OTHERS => fracRPostExc_uid153_fpAddSubTest_ieeeAdd_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- R_uid158_fpAddSubTest_ieeeAdd(BITJOIN,157)@7
    R_uid158_fpAddSubTest_ieeeAdd_q <= signRPostExc_uid149_fpAddSubTest_ieeeAdd_q & expRPostExc_uid157_fpAddSubTest_ieeeAdd_q & fracRPostExc_uid153_fpAddSubTest_ieeeAdd_q;

    -- xOut(GPOUT,4)@7
    q <= R_uid158_fpAddSubTest_ieeeAdd_q;

END normal;
