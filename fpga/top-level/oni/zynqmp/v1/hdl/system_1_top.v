// ***************************************************************************
// ***************************************************************************
// Copyright 2011(c) Analog Devices, Inc.
//
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//     - Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     - Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in
//       the documentation and/or other materials provided with the
//       distribution.
//     - Neither the name of Analog Devices, Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//     - The use of this software may or may not infringe the patent rights
//       of one or more patent holders.  This license does not release you
//       from the requirement that you obtain separate licenses from these
//       patent holders to use this software.
//     - Use of the software either in source or binary form, must be run
//       on or directly connected to an Analog Devices Inc. component.
//
// THIS SOFTWARE IS PROVIDED BY ANALOG DEVICES "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE ARE DISCLAIMED.
//
// IN NO EVENT SHALL ANALOG DEVICES BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, INTELLECTUAL PROPERTY
// RIGHTS, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module system_1_top (
  rx_clk_in_p,
  rx_clk_in_n,
  rx_frame_in_p,
  rx_frame_in_n,
  rx_data_in_p,
  rx_data_in_n,

  tx_clk_out_p,
  tx_clk_out_n,
  tx_frame_out_p,
  tx_frame_out_n,
  tx_data_out_p,
  tx_data_out_n,

  //txnrx,
  //enable,

  gpio_resetb,
  gpio_sync,
  gpio_en_agc,
  //gpio_ctl,
  //gpio_status,
  gpio,

  spi_csn,
  spi_clk,
  spi_mosi,
  spi_miso);

  inout   [11:0]  gpio;

  input           rx_clk_in_p;
  input           rx_clk_in_n;
  input           rx_frame_in_p;
  input           rx_frame_in_n;
  input   [ 5:0]  rx_data_in_p;
  input   [ 5:0]  rx_data_in_n;
  output          tx_clk_out_p;
  output          tx_clk_out_n;
  output          tx_frame_out_p;
  output          tx_frame_out_n;
  output  [ 5:0]  tx_data_out_p;
  output  [ 5:0]  tx_data_out_n;

  //output          txnrx;
  //output          enable;

  inout           gpio_resetb;
  inout           gpio_sync;
  inout           gpio_en_agc;
  //inout   [ 3:0]  gpio_ctl;
  //inout   [ 7:0]  gpio_status;

  output          spi_csn;
  output          spi_clk;
  output          spi_mosi;
  input           spi_miso;

  // internal signals

  wire    [16:0]  gpio_i;
  wire    [16:0]  gpio_o;
  wire    [16:0]  gpio_t;
  wire    [ 2:0]  spi0_csn;

  assign spi_csn = spi0_csn[0];

  // instantiations

  ad_iobuf #(.DATA_WIDTH(15)) i_iobuf_gpio (
    .dio_t ({gpio_t[16:15], gpio_t[12:0]}),
    .dio_i ({gpio_o[16:15], gpio_o[12:0]}),
    .dio_o ({gpio_i[16:15], gpio_i[12:0]}),
    .dio_p ({ gpio_resetb,
              gpio_sync,
              gpio_en_agc,
              gpio}));

  system_1_wrapper i_system_1_wrapper (
    //.enable (enable),
    .gpio_i (gpio_i),
    .gpio_o (gpio_o),
    .gpio_t (gpio_t),
    .rx_clk_in_n (rx_clk_in_n),
    .rx_clk_in_p (rx_clk_in_p),
    .rx_data_in_n (rx_data_in_n),
    .rx_data_in_p (rx_data_in_p),
    .rx_frame_in_n (rx_frame_in_n),
    .rx_frame_in_p (rx_frame_in_p),
    .spi0_csn(spi0_csn),
    .spi0_miso(spi_miso),
    .spi0_mosi(spi_mosi),
    .spi0_sclk(spi_clk),
    .tdd_sync_i(1'b0),
    .tdd_sync_o(),
    .tdd_sync_t(),
    .tx_clk_out_n(tx_clk_out_n),
    .tx_clk_out_p(tx_clk_out_p),
    .tx_data_out_n(tx_data_out_n),
    .tx_data_out_p(tx_data_out_p),
    .tx_frame_out_n(tx_frame_out_n),
    .tx_frame_out_p(tx_frame_out_p),
    //.txnrx(txnrx),
    .up_enable(gpio_o[13]),
    .up_txnrx(gpio_o[14]));
endmodule


// ***************************************************************************
// ***************************************************************************
