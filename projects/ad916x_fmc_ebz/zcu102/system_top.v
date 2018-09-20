// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

/*
Interface to FMC connector overview

system_top     916x_FMC_EBZ    FMC                            FPGA
               -------------|------------------------------|------------------------
// JESD204B
tx_data_n[0]   SERDIN0_N       C03  FMC_HPC0_DP0_C2M_N        G3     MGTHTXN2_229_G3
tx_data_p[0]   SERDIN0_P       C02  FMC_HPC0_DP0_C2M_P        G4     MGTHTXP2_229_G4
tx_data_n[1]   SERDIN1_N       A23  FMC_HPC0_DP1_C2M_N        H5     MGTHTXN1_229_H5
tx_data_p[1]   SERDIN1_P       A22  FMC_HPC0_DP1_C2M_P        H6     MGTHTXP1_229_H6
tx_data_n[2]   SERDIN2_N       A27  FMC_HPC0_DP2_C2M_N        F5     MGTHTXN3_229_F5
tx_data_p[2]   SERDIN2_P       A26  FMC_HPC0_DP2_C2M_P        F6     MGTHTXP3_229_F6
tx_data_n[3]   SERDIN3_N       A31  FMC_HPC0_DP3_C2M_N        K5     MGTHTXN0_229_K5
tx_data_p[3]   SERDIN3_P       A30  FMC_HPC0_DP3_C2M_P        K6     MGTHTXP0_229_K6 
tx_data_p[4]   SERDIN4_N       B32  FMC_HPC0_DP7_C2M_P        N4     MGTHTXP2_228_N4
tx_data_n[4]   SERDIN4_P       B33  FMC_HPC0_DP7_C2M_N        N3     MGTHTXN2_228_N3
tx_data_p[5]   SERDIN5_N       A34  FMC_HPC0_DP4_C2M_P        M6     MGTHTXP3_228_M6
tx_data_n[5]   SERDIN5_P       A35  FMC_HPC0_DP4_C2M_N        M5     MGTHTXN3_228_M5 
tx_data_p[6]   SERDIN6_N       B36  FMC_HPC0_DP6_C2M_P        R4     MGTHTXP0_228_R4
tx_data_n[6]   SERDIN6_P       B37  FMC_HPC0_DP6_C2M_N        R3     MGTHTXN0_228_R3
tx_data_p[7]   SERDIN7_N       A38  FMC_HPC0_DP5_C2M_P        P6     MGTHTXP1_228_P6
tx_data_n[7]   SERDIN7_P       A39  FMC_HPC0_DP5_C2M_N        P5     MGTHTXN1_228_P5
tx_sync_n      SYNC_N          D09  FMC_HPC0_LA01_CC_N        AC4    IO_L16N_T2U_N7_QBC_AD3N_66_AC4
tx_sync_p      SYNC_P          D08  FMC_HPC0_LA01_CC_P        AB4    IO_L16P_T2U_N6_QBC_AD3P_66_AB4
tx_sysref_n    SYSREF2_N       H08  FMC_HPC0_LA02_N           V1     IO_L23N_T3U_N9_66_V1
tx_sysref_p    SYSREF2_P       H07  FMC_HPC0_LA02_P           V2     IO_L23P_T3U_N8_66_V2 
tx_ref_clk_n   GBTCLK0_M2C_N   D05  FMC_HPC0_GBTCLK0_M2C_C_N  G7     MGTREFCLK0N_229_G7
tx_ref_clk_p   GBTCLK0_M2C_P   D04  FMC_HPC0_GBTCLK0_M2C_C_P  G8     MGTREFCLK0P_229_G8
 
// SPI
spi_csn_dac    FMC_CS1         H11  FMC_HPC0_LA04_N           AA1    IO_L21N_T3L_N5_AD8N_66_AA1
spi_csn_clkbuf FMC_CS2         D11  FMC_HPC0_LA05_P           AB3    IO_L20P_T3L_N2_AD1P_66_AB3
spi_csn_clkgen FMC_CS3         D14  FMC_HPC0_LA09_P           W2     IO_L24P_T3U_N10_66_W2
spi_en_n       FMC_SPI_EN      D12  FMC_HPC0_LA05_N           AC3    IO_L20N_T3L_N3_AD1N_66_AC3
spi_clk        FMC_SCK         G09  FMC_HPC0_LA03_P           Y2     IO_L22P_T3U_N6_DBC_AD0P_66_Y2
spi_mosi       FMC_MOSI        G10  FMC_HPC0_LA03_N           Y1     IO_L22N_T3U_N7_DBC_AD0N_66_Y1 
spi_miso       FMC_MISO        H10  FMC_HPC0_LA04_P           AA2    IO_L21P_T3L_N4_AD8P_66_AA2

// Others
hmc849vctl     FMC_HMC849VCTL  D15  FMC_HPC0_LA09_N           W1     IO_L24N_T3U_N11_66_W1
txen_0         FMC_TXEN_0      H13  FMC_HPC0_LA07_P           U5     IO_L18P_T2U_N10_AD2P_66_U5

*/

module system_top (

  input   [12:0]  gpio_bd_i,
  output  [ 7:0]  gpio_bd_o,

  input           tx_ref_clk_p,
  input           tx_ref_clk_n,
  input           tx_sysref_p,
  input           tx_sysref_n,
  input           tx_sync_p,
  input           tx_sync_n,
  output  [ 7:0]  tx_data_p,
  output  [ 7:0]  tx_data_n,

  output          spi_csn_dac,
  output          spi_csn_clkbuf,
  output          spi_csn_clkgen,
  input           spi_miso,
  output          spi_mosi,
  output          spi_clk,
  output          spi_en_n,

  output          hmc849vctl,
  output          txen_0

);

  // internal signals

  wire    [94:0]  gpio_i;
  wire    [94:0]  gpio_o;
  wire    [ 2:0]  spi_csn;
  wire            tx_ref_clk;
  wire            tx_sysref;
  wire            tx_sync;

  // spi

  assign spi_csn_dac = spi_csn[0];
  assign spi_csn_clkbuf = spi_csn[1];
  assign spi_csn_clkgen = spi_csn[2];

  // instantiations

  IBUFDS_GTE4 i_ibufds_tx_ref_clk (
    .CEB (1'd0),
    .I (tx_ref_clk_p),
    .IB (tx_ref_clk_n),
    .O (tx_ref_clk),
    .ODIV2 ());

  IBUFDS i_ibufds_tx_sysref (
    .I (tx_sysref_p),
    .IB (tx_sysref_n),
    .O (tx_sysref));

  IBUFDS i_ibufds_tx_sync (
    .I (tx_sync_p),
    .IB (tx_sync_n),
    .O (tx_sync));

  assign gpio_bd_o  = gpio_o[7:0];
  assign hmc849vctl = gpio_o[21];
  assign txen_0     = gpio_o[22];
  assign spi_en_n   = 1'b0; // make FPGA master on SPI

  assign gpio_i[94:21] = gpio_o[94:21];
  assign gpio_i[20: 8] = gpio_bd_i;
  assign gpio_i[ 7: 0] = gpio_o[7:0];

  system_wrapper i_system_wrapper (
    .gpio_i (gpio_i),
    .gpio_o (gpio_o),
    .spi0_csn (spi_csn),
    .spi0_miso (spi_miso),
    .spi0_mosi (spi_mosi),
    .spi0_sclk (spi_clk),
    .spi1_csn (),
    .spi1_miso (1'd0),
    .spi1_mosi (),
    .spi1_sclk (),
    .tx_data_0_n (tx_data_n[0]),
    .tx_data_0_p (tx_data_p[0]),
    .tx_data_1_n (tx_data_n[1]),
    .tx_data_1_p (tx_data_p[1]),
    .tx_data_2_n (tx_data_n[2]),
    .tx_data_2_p (tx_data_p[2]),
    .tx_data_3_n (tx_data_n[3]),
    .tx_data_3_p (tx_data_p[3]),
    .tx_data_4_n (tx_data_n[4]),
    .tx_data_4_p (tx_data_p[4]),
    .tx_data_5_n (tx_data_n[5]),
    .tx_data_5_p (tx_data_p[5]),
    .tx_data_6_n (tx_data_n[6]),
    .tx_data_6_p (tx_data_p[6]),
    .tx_data_7_n (tx_data_n[7]),
    .tx_data_7_p (tx_data_p[7]),
    .tx_ref_clk_0 (tx_ref_clk),
    .tx_sync_0 (tx_sync),
    .tx_sysref_0 (tx_sysref));

endmodule

// ***************************************************************************
// ***************************************************************************