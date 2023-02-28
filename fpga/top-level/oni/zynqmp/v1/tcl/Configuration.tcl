# ---------------------------------------------
# Set variables
# ---------------------------------------------
if { [ info exists ::env(TOP_SRC_DIR) ] ==0 || $::env(TOP_SRC_DIR) == "" } then {
	puts "Error: Please set TOP_SRC_DIR environment variable before running this script"
	exit 1
}

# Source directory
set src_dir              $::env(TOP_SRC_DIR)
# Build directory
set build_root_dir       [exec pwd]
# Project directory will be created as ${build_root_dir}/project_name
set project_name         zynqmpONI.vivado
# Target device
set target_device        xczu4cg-sfvc784-1-e
# Target board
set target_board         trenz.biz:te0803_4cg_1e_tebf0808:part0:2.0
# IP Core dirs
set hdl_dir     $src_dir/hdl
set ip_lib_dir  $::env(TOP_SRC_DIR)/ip_lib
set adi_clkdiv  $hdl_dir/util_clkdiv
set adi_cpack	  $hdl_dir/util_cpack
set adi_tddsync	$hdl_dir/util_tdd_sync
set adi_wfifo	  $hdl_dir/util_wfifo
set axi_ad9361  $hdl_dir/axi_ad9361
set axi_dmac    $hdl_dir/axi_dmac
set adi_fifo    $hdl_dir/util_axis_fifo
set adi_fifo_resize  $hdl_dir/util_axis_resize
set adi_cdc     $hdl_dir/util_cdc
set adi_rfifo   $hdl_dir/util_rfifo
set adi_upack   $hdl_dir/util_upack
set system_1_top  $src_dir/hdl/system_1_top.v
set ad_iobuf		  $src_dir/hdl/ad_iobuf.v
set interfaces    $src_dir/hdl/axi_dmac/interfaces

# Constraint file
set constraints_dir      $src_dir/constraints
set constraint_file      $constraints_dir/lemdig.xdc

set custom_ip_dirs   "$adi_clkdiv $adi_cpack $adi_tddsync $adi_wfifo $axi_ad9361 $axi_dmac $adi_fifo $adi_fifo_resize $interfaces
										  $adi_cdc $adi_rfifo $adi_upack"
set top_level_files  "$system_1_top $ad_iobuf"

# Board file
set board_file_dir $::env(FPGA_SRC_ROOT_DIR)/lib/board_files

# ---------------------------------------------
# Do not change the following lines unless it
# is necessary and you are sure what these are.
# ---------------------------------------------

# Directories
set project_dir      $build_root_dir/$project_name
set srcs_dir         $project_dir/$project_name.srcs
set runs_dir         $project_dir/$project_name.runs
set sdk_dir          $project_dir/$project_name.sdk

# "Set" names
set sources_name                    sources_1
set constrs_name                    constrs_1
set sim_name                        sim_1
set impl_name                       impl_1
set design_name                     system_1
append design_wrapper_name $design_name _wrapper
append design_hw_platform_name $design_name _hw_platform_0
set synth_name                      synth_1

# Files
set wrapper_verilog_file $srcs_dir/$sources_name/bd/$design_name/hdl/$design_wrapper_name.v
set bd_file              $srcs_dir/$sources_name/bd/$design_name/$design_name.bd
append bit_file          $runs_dir/$impl_name/$design_name _top.bit
append sysdef_file       $runs_dir/$impl_name/$design_name _top.sysdef
set hdf_file             $sdk_dir/$design_name.hdf

# Set guard flag
set configuration_file_loaded yes
