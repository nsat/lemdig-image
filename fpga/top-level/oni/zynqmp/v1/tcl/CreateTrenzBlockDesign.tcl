#---------------------------------------------
# This file has been taken from Trenz's Reference Design.
# See https://wiki.trenz-electronic.de/display/PD/TE0803+StarterKit
#---------------------------------------------

proc create_block_design {} {
  # Create instance: sys_ps8, and set properties
  set sys_ps8 [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.2 sys_ps8 ]

  # Configure DDRC before applying preset.xml in apply_bd_automation
  set_property -dict [list \
  	CONFIG.PSU__DDRC__CL {16} \
  	CONFIG.PSU__DDRC__CWL {12} \
  	CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
  	CONFIG.PSU__DDRC__DEVICE_CAPACITY {4096 MBits} \
  	CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
  	CONFIG.PSU__DDRC__ROW_ADDR_COUNT {15} \
  	CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2400R} \
  	CONFIG.PSU__DDRC__T_FAW {30} \
  	CONFIG.PSU__DDRC__T_RAS_MIN {32} \
  	CONFIG.PSU__DDRC__T_RC {45.32} \
  	CONFIG.PSU__DDRC__T_RCD {16} \
  	CONFIG.PSU__DDRC__T_RP {16} \
  	CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1200}] [get_bd_cells sys_ps8]
  apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells sys_ps8]

  # Create port connections
  connect_bd_net -net sys_ps8_pl_resetn0 [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins proc_sys_reset_1/ext_reset_in] [get_bd_pins sys_ps8/pl_resetn0]

  save_bd_design
}

create_block_design
