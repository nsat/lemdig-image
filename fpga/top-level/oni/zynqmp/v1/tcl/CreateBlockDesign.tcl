# ---------------------------------------------
# Create Block Design
# ---------------------------------------------
source $::env(TOP_SRC_DIR)/tcl/ad_ip/ad_board.tcl

set_property -dict [list \
  CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {IOPLL} \
  CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {100} \
  CONFIG.PSU__FPGA_PL1_ENABLE  {1} \
  CONFIG.PSU__CRL_APB__PL1_REF_CTRL__SRCSEL {RPLL} \
  CONFIG.PSU__CRL_APB__PL1_REF_CTRL__FREQMHZ {200} \
  \
  CONFIG.PSU__USE__M_AXI_GP2 {1} \
  CONFIG.PSU__USE__IRQ0      {1} \
  CONFIG.PSU__USE__IRQ1      {1} \
  CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__GPIO_EMIO__PERIPHERAL__IO {17} \
  \
  CONFIG.PSU__CAN0__PERIPHERAL__ENABLE {1}            \
  CONFIG.PSU__CAN0__PERIPHERAL__IO     {MIO 62 .. 63} \
  CONFIG.PSU__CAN1__PERIPHERAL__ENABLE {1}            \
  CONFIG.PSU__CAN1__PERIPHERAL__IO     {MIO 60 .. 61} \
  CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1}            \
  CONFIG.PSU__I2C0__PERIPHERAL__IO     {MIO 38 .. 39} \
  CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1}            \
  CONFIG.PSU__I2C1__PERIPHERAL__IO     {MIO 40 .. 41} \
  CONFIG.PSU__SPI0__PERIPHERAL__ENABLE {1} \
  CONFIG.PSU__SPI0__PERIPHERAL__IO     {EMIO} \
  CONFIG.PSU__SPI0__GRP_SS1__ENABLE    {1} \
  CONFIG.PSU__SPI0__GRP_SS2__ENABLE    {1} \
  CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__FREQMHZ 100 \
  \
  CONFIG.PSU__NAND_COHERENCY            {0}            \
  CONFIG.PSU__NAND__CHIP_ENABLE__ENABLE {1}            \
  CONFIG.PSU__NAND__CHIP_ENABLE__IO     {MIO 26}       \
  CONFIG.PSU__NAND__DATA_STROBE__ENABLE {1}            \
  CONFIG.PSU__NAND__DATA_STROBE__IO     {MIO 32}       \
  CONFIG.PSU__NAND__PERIPHERAL__ENABLE  {1}            \
  CONFIG.PSU__NAND__PERIPHERAL__IO      {MIO 13 .. 25} \
  CONFIG.PSU__NAND__READY0_BUSY__ENABLE {1}            \
  CONFIG.PSU__NAND__READY0_BUSY__IO     {MIO 27}       \
  CONFIG.PSU__NAND__READY1_BUSY__ENABLE {1}            \
  CONFIG.PSU__NAND__READY1_BUSY__IO     {MIO 28}       \
  \
  CONFIG.PSU__SD0__PERIPHERAL__ENABLE   {0}            \
  CONFIG.PSU__SD1__PERIPHERAL__ENABLE   {1}            \
  CONFIG.PSU__SD1__PERIPHERAL__IO       {MIO 46 .. 51} \
  CONFIG.PSU__SD1__GRP_CD__ENABLE       {0}            \
  CONFIG.PSU__SD1__GRP_WP__ENABLE       {0}            \
  \
  CONFIG.PSU__UART1__BAUD_RATE          {115200}       \
  CONFIG.PSU__UART1__MODEM__ENABLE      {0}            \
  CONFIG.PSU__UART1__PERIPHERAL__ENABLE {1}            \
  CONFIG.PSU__UART1__PERIPHERAL__IO     {MIO 44 .. 45} \
  \
  CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1}            \
  CONFIG.PSU__ENET3__PERIPHERAL__IO     {MIO 64 .. 75} \
  CONFIG.PSU__ENET3__FIFO__ENABLE       {0}            \
  CONFIG.PSU__ENET3__GRP_MDIO__ENABLE   {1}            \
  CONFIG.PSU__ENET3__GRP_MDIO__IO       {MIO 76 .. 77} \
  CONFIG.PSU__ENET3__PTP__ENABLE        {0}            \
  CONFIG.PSU__ENET3__TSU__ENABLE        {0}            \
  \
  CONFIG.PSU__USE__AUDIO                {0}            \
  CONFIG.PSU__PCIE__PERIPHERAL__ENABLE  {0}            \
  CONFIG.PSU__SATA__PERIPHERAL__ENABLE  {0}            \
  CONFIG.PSU__USB0__PERIPHERAL__ENABLE  {0}            \
  CONFIG.PSU__PJTAG__PERIPHERAL__ENABLE {0}            \
  \
  CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {0}        \
  \
  CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE   {1}        \
  CONFIG.PSU_MIO_31_PULLUPDOWN                {pulldown} \
] [get_bd_cells sys_ps8]

# Optimize layout
regenerate_bd_layout

# Save
save_bd_design

create_bd_port -dir O -from 2 -to 0 spi0_csn
create_bd_port -dir O spi0_sclk
create_bd_port -dir O spi0_mosi
create_bd_port -dir I spi0_miso

create_bd_port -dir I -from 16 -to 0 gpio_i
create_bd_port -dir O -from 16 -to 0 gpio_o
create_bd_port -dir O -from 16 -to 0 gpio_t

ad_ip_instance proc_sys_reset sys_rstgen
ad_ip_parameter sys_rstgen CONFIG.C_EXT_RST_WIDTH 1

ad_connect  sys_cpu_clk sys_ps8/pl_clk0
ad_connect  sys_200m_clk sys_ps8/pl_clk1
ad_connect  sys_cpu_reset sys_rstgen/peripheral_reset
ad_connect  sys_cpu_resetn sys_rstgen/peripheral_aresetn
ad_connect  sys_cpu_clk sys_rstgen/slowest_sync_clk

# gpio

ad_connect  gpio_i sys_ps8/emio_gpio_i
ad_connect  gpio_o sys_ps8/emio_gpio_o
ad_connect  gpio_t sys_ps8/emio_gpio_t

# spi

ad_ip_instance xlconcat spi0_csn_concat
ad_ip_parameter spi0_csn_concat CONFIG.NUM_PORTS 3
ad_connect  sys_ps8/emio_spi0_ss_o_n spi0_csn_concat/In0
ad_connect  sys_ps8/emio_spi0_ss1_o_n spi0_csn_concat/In1
ad_connect  sys_ps8/emio_spi0_ss2_o_n spi0_csn_concat/In2
ad_connect  spi0_csn_concat/dout spi0_csn
ad_connect  sys_ps8/emio_spi0_sclk_o spi0_sclk
ad_connect  sys_ps8/emio_spi0_m_o spi0_mosi
ad_connect  sys_ps8/emio_spi0_m_i spi0_miso
ad_connect  sys_ps8/emio_spi0_ss_i_n VCC
ad_connect  sys_ps8/emio_spi0_sclk_i GND
ad_connect  sys_ps8/emio_spi0_s_i GND

# interrupts

ad_ip_instance xlconcat sys_concat_intc_0
ad_ip_parameter sys_concat_intc_0 CONFIG.NUM_PORTS 8

ad_ip_instance xlconcat sys_concat_intc_1
ad_ip_parameter sys_concat_intc_1 CONFIG.NUM_PORTS 8

ad_connect  sys_concat_intc_0/dout sys_ps8/pl_ps_irq0
ad_connect  sys_concat_intc_1/dout sys_ps8/pl_ps_irq1

ad_connect  sys_concat_intc_1/In7 GND
ad_connect  sys_concat_intc_1/In6 GND
ad_connect  sys_concat_intc_1/In5 GND
ad_connect  sys_concat_intc_1/In4 GND
ad_connect  sys_concat_intc_1/In3 GND
ad_connect  sys_concat_intc_1/In2 GND
ad_connect  sys_concat_intc_1/In1 GND
ad_connect  sys_concat_intc_1/In0 GND
#ad_connect  sys_concat_intc_0/In7 GND
#ad_connect  sys_concat_intc_0/In6 GND
ad_connect  sys_concat_intc_0/In5 GND
ad_connect  sys_concat_intc_0/In4 GND
ad_connect  sys_concat_intc_0/In3 GND
ad_connect  sys_concat_intc_0/In2 GND
ad_connect  sys_concat_intc_0/In1 GND
ad_connect  sys_concat_intc_0/In0 GND

create_bd_port -dir I rx_clk_in_p
create_bd_port -dir I rx_clk_in_n
create_bd_port -dir I rx_frame_in_p
create_bd_port -dir I rx_frame_in_n
create_bd_port -dir I -from 5 -to 0 rx_data_in_p
create_bd_port -dir I -from 5 -to 0 rx_data_in_n

create_bd_port -dir O tx_clk_out_p
create_bd_port -dir O tx_clk_out_n
create_bd_port -dir O tx_frame_out_p
create_bd_port -dir O tx_frame_out_n
create_bd_port -dir O -from 5 -to 0 tx_data_out_p
create_bd_port -dir O -from 5 -to 0 tx_data_out_n

#create_bd_port -dir O enable
#create_bd_port -dir O txnrx
create_bd_port -dir I up_enable
create_bd_port -dir I up_txnrx

create_bd_port -dir O tdd_sync_o
create_bd_port -dir I tdd_sync_i
create_bd_port -dir O tdd_sync_t

# ad9361 core

ad_ip_instance axi_ad9361 axi_ad9361

# set to 1 for CORDIC or 2 for POLYNOMIAL
ad_ip_parameter axi_ad9361 CONFIG.DAC_DDS_TYPE 1
ad_ip_parameter axi_ad9361 CONFIG.DAC_DDS_CORDIC_DW 14
ad_ip_parameter axi_ad9361 CONFIG.ID 0
ad_ip_parameter axi_ad9361 CONFIG.DEVICE_TYPE 2
ad_ip_parameter axi_ad9361 CONFIG.ADC_INIT_DELAY 11
ad_connect sys_200m_clk axi_ad9361/delay_clk
ad_connect axi_ad9361/l_clk axi_ad9361/clk
ad_connect rx_clk_in_p axi_ad9361/rx_clk_in_p
ad_connect rx_clk_in_n axi_ad9361/rx_clk_in_n
ad_connect rx_frame_in_p axi_ad9361/rx_frame_in_p
ad_connect rx_frame_in_n axi_ad9361/rx_frame_in_n
ad_connect rx_data_in_p axi_ad9361/rx_data_in_p
ad_connect rx_data_in_n axi_ad9361/rx_data_in_n
ad_connect tx_clk_out_p axi_ad9361/tx_clk_out_p
ad_connect tx_clk_out_n axi_ad9361/tx_clk_out_n
ad_connect tx_frame_out_p axi_ad9361/tx_frame_out_p
ad_connect tx_frame_out_n axi_ad9361/tx_frame_out_n
ad_connect tx_data_out_p axi_ad9361/tx_data_out_p
ad_connect tx_data_out_n axi_ad9361/tx_data_out_n
#ad_connect enable axi_ad9361/enable
#ad_connect txnrx axi_ad9361/txnrx
ad_connect up_enable axi_ad9361/up_enable
ad_connect up_txnrx axi_ad9361/up_txnrx

# tdd-sync

ad_ip_instance util_tdd_sync util_ad9361_tdd_sync
ad_ip_parameter util_ad9361_tdd_sync CONFIG.TDD_SYNC_PERIOD 10000000
ad_connect sys_cpu_clk util_ad9361_tdd_sync/clk
ad_connect sys_cpu_resetn util_ad9361_tdd_sync/rstn
ad_connect util_ad9361_tdd_sync/sync_out axi_ad9361/tdd_sync
ad_connect util_ad9361_tdd_sync/sync_mode axi_ad9361/tdd_sync_cntr
ad_connect tdd_sync_t axi_ad9361/tdd_sync_cntr
ad_connect tdd_sync_o util_ad9361_tdd_sync/sync_out
ad_connect tdd_sync_i util_ad9361_tdd_sync/sync_in

# interface clock divider to generate sampling clock
# interface runs at 4x in 2r2t mode, and 2x in 1r1t mode

ad_ip_instance xlconcat util_ad9361_divclk_sel_concat
ad_ip_parameter util_ad9361_divclk_sel_concat CONFIG.NUM_PORTS 2
ad_connect axi_ad9361/adc_r1_mode util_ad9361_divclk_sel_concat/In0
ad_connect axi_ad9361/dac_r1_mode util_ad9361_divclk_sel_concat/In1

ad_ip_instance util_reduced_logic util_ad9361_divclk_sel
ad_ip_parameter util_ad9361_divclk_sel CONFIG.C_SIZE 2
ad_connect util_ad9361_divclk_sel_concat/dout util_ad9361_divclk_sel/Op1

ad_ip_instance util_clkdiv util_ad9361_divclk
ad_connect util_ad9361_divclk_sel/Res util_ad9361_divclk/clk_sel
ad_connect axi_ad9361/l_clk util_ad9361_divclk/clk
ad_ip_parameter util_ad9361_divclk CONFIG.SIM_DEVICE ULTRASCALE

# resets at divided clock

ad_ip_instance proc_sys_reset util_ad9361_divclk_reset
ad_connect sys_rstgen/peripheral_aresetn util_ad9361_divclk_reset/ext_reset_in
ad_connect util_ad9361_divclk/clk_out util_ad9361_divclk_reset/slowest_sync_clk

ad_connect sys_rstgen/ext_reset_in sys_ps8/pl_resetn0

# adc-path wfifo

ad_ip_instance util_wfifo util_ad9361_adc_fifo
ad_ip_parameter util_ad9361_adc_fifo CONFIG.NUM_OF_CHANNELS 4
ad_ip_parameter util_ad9361_adc_fifo CONFIG.DIN_ADDRESS_WIDTH 4
ad_ip_parameter util_ad9361_adc_fifo CONFIG.DIN_DATA_WIDTH 16
ad_ip_parameter util_ad9361_adc_fifo CONFIG.DOUT_DATA_WIDTH 16
ad_connect axi_ad9361/l_clk util_ad9361_adc_fifo/din_clk
ad_connect axi_ad9361/rst util_ad9361_adc_fifo/din_rst
ad_connect util_ad9361_divclk/clk_out util_ad9361_adc_fifo/dout_clk
ad_connect util_ad9361_divclk_reset/peripheral_aresetn util_ad9361_adc_fifo/dout_rstn
ad_connect axi_ad9361/adc_enable_i0 util_ad9361_adc_fifo/din_enable_0
ad_connect axi_ad9361/adc_valid_i0 util_ad9361_adc_fifo/din_valid_0
ad_connect axi_ad9361/adc_data_i0 util_ad9361_adc_fifo/din_data_0
ad_connect axi_ad9361/adc_enable_q0 util_ad9361_adc_fifo/din_enable_1
ad_connect axi_ad9361/adc_valid_q0 util_ad9361_adc_fifo/din_valid_1
ad_connect axi_ad9361/adc_data_q0 util_ad9361_adc_fifo/din_data_1
ad_connect axi_ad9361/adc_enable_i1 util_ad9361_adc_fifo/din_enable_2
ad_connect axi_ad9361/adc_valid_i1 util_ad9361_adc_fifo/din_valid_2
ad_connect axi_ad9361/adc_data_i1 util_ad9361_adc_fifo/din_data_2
ad_connect axi_ad9361/adc_enable_q1 util_ad9361_adc_fifo/din_enable_3
ad_connect axi_ad9361/adc_valid_q1 util_ad9361_adc_fifo/din_valid_3
ad_connect axi_ad9361/adc_data_q1 util_ad9361_adc_fifo/din_data_3
ad_connect util_ad9361_adc_fifo/din_ovf axi_ad9361/adc_dovf

# adc-path channel pack

ad_ip_instance util_cpack util_ad9361_adc_pack
ad_ip_parameter util_ad9361_adc_pack CONFIG.NUM_OF_CHANNELS 4
ad_ip_parameter util_ad9361_adc_pack CONFIG.CHANNEL_DATA_WIDTH 16
ad_connect util_ad9361_divclk/clk_out util_ad9361_adc_pack/adc_clk
ad_connect util_ad9361_divclk_reset/peripheral_reset util_ad9361_adc_pack/adc_rst
ad_connect util_ad9361_adc_fifo/dout_enable_0 util_ad9361_adc_pack/adc_enable_0
ad_connect util_ad9361_adc_fifo/dout_valid_0 util_ad9361_adc_pack/adc_valid_0
ad_connect util_ad9361_adc_fifo/dout_data_0 util_ad9361_adc_pack/adc_data_0
ad_connect util_ad9361_adc_fifo/dout_enable_1 util_ad9361_adc_pack/adc_enable_1
ad_connect util_ad9361_adc_fifo/dout_valid_1 util_ad9361_adc_pack/adc_valid_1
ad_connect util_ad9361_adc_fifo/dout_data_1 util_ad9361_adc_pack/adc_data_1
ad_connect util_ad9361_adc_fifo/dout_enable_2 util_ad9361_adc_pack/adc_enable_2
ad_connect util_ad9361_adc_fifo/dout_valid_2 util_ad9361_adc_pack/adc_valid_2
ad_connect util_ad9361_adc_fifo/dout_data_2 util_ad9361_adc_pack/adc_data_2
ad_connect util_ad9361_adc_fifo/dout_enable_3 util_ad9361_adc_pack/adc_enable_3
ad_connect util_ad9361_adc_fifo/dout_valid_3 util_ad9361_adc_pack/adc_valid_3
ad_connect util_ad9361_adc_fifo/dout_data_3 util_ad9361_adc_pack/adc_data_3

# adc-path dma

ad_ip_instance axi_dmac axi_ad9361_adc_dma
ad_ip_parameter axi_ad9361_adc_dma CONFIG.DMA_TYPE_SRC 2
ad_ip_parameter axi_ad9361_adc_dma CONFIG.DMA_TYPE_DEST 0
ad_ip_parameter axi_ad9361_adc_dma CONFIG.CYCLIC 0
ad_ip_parameter axi_ad9361_adc_dma CONFIG.SYNC_TRANSFER_START 1
ad_ip_parameter axi_ad9361_adc_dma CONFIG.AXI_SLICE_SRC 0
ad_ip_parameter axi_ad9361_adc_dma CONFIG.AXI_SLICE_DEST 0
ad_ip_parameter axi_ad9361_adc_dma CONFIG.DMA_2D_TRANSFER 0
ad_ip_parameter axi_ad9361_adc_dma CONFIG.DMA_DATA_WIDTH_SRC 64
ad_connect util_ad9361_divclk/clk_out axi_ad9361_adc_dma/fifo_wr_clk
ad_connect util_ad9361_adc_pack/adc_valid axi_ad9361_adc_dma/fifo_wr_en
ad_connect util_ad9361_adc_pack/adc_sync axi_ad9361_adc_dma/fifo_wr_sync
ad_connect util_ad9361_adc_pack/adc_data axi_ad9361_adc_dma/fifo_wr_din
ad_connect axi_ad9361_adc_dma/fifo_wr_overflow util_ad9361_adc_fifo/dout_ovf
ad_connect sys_cpu_resetn axi_ad9361_adc_dma/m_dest_axi_aresetn

# dac-path rfifo

ad_ip_instance util_rfifo axi_ad9361_dac_fifo
ad_ip_parameter axi_ad9361_dac_fifo CONFIG.DIN_DATA_WIDTH 16
ad_ip_parameter axi_ad9361_dac_fifo CONFIG.DOUT_DATA_WIDTH 16
ad_ip_parameter axi_ad9361_dac_fifo CONFIG.DIN_ADDRESS_WIDTH 4
ad_connect axi_ad9361/l_clk axi_ad9361_dac_fifo/dout_clk
ad_connect axi_ad9361/rst axi_ad9361_dac_fifo/dout_rst
ad_connect util_ad9361_divclk/clk_out axi_ad9361_dac_fifo/din_clk
ad_connect util_ad9361_divclk_reset/peripheral_aresetn axi_ad9361_dac_fifo/din_rstn
ad_connect axi_ad9361_dac_fifo/dout_enable_0 axi_ad9361/dac_enable_i0
ad_connect axi_ad9361_dac_fifo/dout_valid_0 axi_ad9361/dac_valid_i0
ad_connect axi_ad9361_dac_fifo/dout_data_0 axi_ad9361/dac_data_i0
ad_connect axi_ad9361_dac_fifo/dout_enable_1 axi_ad9361/dac_enable_q0
ad_connect axi_ad9361_dac_fifo/dout_valid_1 axi_ad9361/dac_valid_q0
ad_connect axi_ad9361_dac_fifo/dout_data_1 axi_ad9361/dac_data_q0
ad_connect axi_ad9361_dac_fifo/dout_enable_2 axi_ad9361/dac_enable_i1
ad_connect axi_ad9361_dac_fifo/dout_valid_2 axi_ad9361/dac_valid_i1
ad_connect axi_ad9361_dac_fifo/dout_data_2 axi_ad9361/dac_data_i1
ad_connect axi_ad9361_dac_fifo/dout_enable_3 axi_ad9361/dac_enable_q1
ad_connect axi_ad9361_dac_fifo/dout_valid_3 axi_ad9361/dac_valid_q1
ad_connect axi_ad9361_dac_fifo/dout_data_3 axi_ad9361/dac_data_q1
ad_connect axi_ad9361_dac_fifo/dout_unf axi_ad9361/dac_dunf

# dac-path channel unpack

ad_ip_instance util_upack util_ad9361_dac_upack
ad_ip_parameter util_ad9361_dac_upack CONFIG.NUM_OF_CHANNELS 4
ad_ip_parameter util_ad9361_dac_upack CONFIG.CHANNEL_DATA_WIDTH 16
ad_connect util_ad9361_divclk/clk_out util_ad9361_dac_upack/dac_clk
ad_connect util_ad9361_dac_upack/dac_enable_0 axi_ad9361_dac_fifo/din_enable_0
ad_connect util_ad9361_dac_upack/dac_valid_0 axi_ad9361_dac_fifo/din_valid_0
ad_connect util_ad9361_dac_upack/dac_valid_out_0 axi_ad9361_dac_fifo/din_valid_in_0
ad_connect util_ad9361_dac_upack/dac_data_0 axi_ad9361_dac_fifo/din_data_0
ad_connect util_ad9361_dac_upack/dac_enable_1 axi_ad9361_dac_fifo/din_enable_1
ad_connect util_ad9361_dac_upack/dac_valid_1 axi_ad9361_dac_fifo/din_valid_1
ad_connect util_ad9361_dac_upack/dac_valid_out_1 axi_ad9361_dac_fifo/din_valid_in_1
ad_connect util_ad9361_dac_upack/dac_data_1 axi_ad9361_dac_fifo/din_data_1
ad_connect util_ad9361_dac_upack/dac_enable_2 axi_ad9361_dac_fifo/din_enable_2
ad_connect util_ad9361_dac_upack/dac_valid_2 axi_ad9361_dac_fifo/din_valid_2
ad_connect util_ad9361_dac_upack/dac_valid_out_2 axi_ad9361_dac_fifo/din_valid_in_2
ad_connect util_ad9361_dac_upack/dac_data_2 axi_ad9361_dac_fifo/din_data_2
ad_connect util_ad9361_dac_upack/dac_enable_3 axi_ad9361_dac_fifo/din_enable_3
ad_connect util_ad9361_dac_upack/dac_valid_3 axi_ad9361_dac_fifo/din_valid_3
ad_connect util_ad9361_dac_upack/dac_valid_out_3 axi_ad9361_dac_fifo/din_valid_in_3
ad_connect util_ad9361_dac_upack/dac_data_3 axi_ad9361_dac_fifo/din_data_3

# dac-path dma

ad_ip_instance axi_dmac axi_ad9361_dac_dma
ad_ip_parameter axi_ad9361_dac_dma CONFIG.DMA_TYPE_SRC 0
ad_ip_parameter axi_ad9361_dac_dma CONFIG.DMA_TYPE_DEST 2
ad_ip_parameter axi_ad9361_dac_dma CONFIG.CYCLIC 1
ad_ip_parameter axi_ad9361_dac_dma CONFIG.AXI_SLICE_SRC 0
ad_ip_parameter axi_ad9361_dac_dma CONFIG.AXI_SLICE_DEST 1
ad_ip_parameter axi_ad9361_dac_dma CONFIG.DMA_2D_TRANSFER 0
ad_ip_parameter axi_ad9361_dac_dma CONFIG.DMA_DATA_WIDTH_DEST 64
ad_connect util_ad9361_divclk/clk_out axi_ad9361_dac_dma/fifo_rd_clk
ad_connect axi_ad9361_dac_dma/fifo_rd_en util_ad9361_dac_upack/dac_valid
ad_connect axi_ad9361_dac_dma/fifo_rd_dout util_ad9361_dac_upack/dac_data
ad_connect axi_ad9361_dac_dma/fifo_rd_underflow axi_ad9361_dac_fifo/din_unf
ad_connect sys_cpu_resetn axi_ad9361_dac_dma/m_src_axi_aresetn

# interconnects

ad_cpu_interconnect 0x79020000 axi_ad9361
ad_cpu_interconnect 0x7C400000 axi_ad9361_adc_dma
ad_cpu_interconnect 0x7C420000 axi_ad9361_dac_dma
ad_mem_hp1_interconnect sys_cpu_clk sys_ps8/S_AXI_HP1
ad_mem_hp1_interconnect sys_cpu_clk axi_ad9361_adc_dma/m_dest_axi
ad_mem_hp2_interconnect sys_cpu_clk sys_ps8/S_AXI_HP2
ad_mem_hp2_interconnect sys_cpu_clk axi_ad9361_dac_dma/m_src_axi

# Save

save_bd_design

# interrupts

ad_cpu_interrupt ps-6 mb-12 axi_ad9361_adc_dma/irq
ad_cpu_interrupt ps-7 mb-13 axi_ad9361_dac_dma/irq
