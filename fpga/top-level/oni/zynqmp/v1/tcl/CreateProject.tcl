# ---------------------------------------------
# Load configuration
# ---------------------------------------------
if {![info exists configuration_file_loaded]} {
source $::env(TOP_SRC_DIR)/tcl/Configuration.tcl
}

# ---------------------------------------------
# Create project
# ---------------------------------------------
create_project $project_name $build_root_dir/$project_name -part $target_device -force
set_property board_part_repo_paths $board_file_dir [current_project]
set_property board_part $target_board [current_project]
set_property target_language Verilog [current_project]

# ---------------------------------------------
# Register IP Repos
# ---------------------------------------------
set_property  ip_repo_paths  "$custom_ip_dirs" [current_project]
update_ip_catalog

# ---------------------------------------------
# Add constraint file
# ---------------------------------------------
add_files -fileset $constrs_name -norecurse $constraint_file
import_files -fileset $constrs_name $constraint_file

# ---------------------------------------------
# Create Block Design
# ---------------------------------------------
create_bd_design $design_name
source $::env(TOP_SRC_DIR)/tcl/CreateTrenzBlockDesign.tcl
source $::env(TOP_SRC_DIR)/tcl/CreateBlockDesign.tcl

# ---------------------------------------------
# Implementation setting
# ---------------------------------------------
set_property STEPS.OPT_DESIGN.ARGS.DIRECTIVE ExploreWithRemap [get_runs impl_1]
set_property STEPS.PLACE_DESIGN.ARGS.DIRECTIVE ExtraTimingOpt [get_runs impl_1]

# ---------------------------------------------
# Create wrapper HDL
# ---------------------------------------------
make_wrapper -files [get_files $bd_file] -top
add_files -norecurse $wrapper_verilog_file
update_compile_order -fileset $sources_name
update_compile_order -fileset $sim_name

# ---------------------------------------------
# Add top system file
# ---------------------------------------------
add_files -norecurse -fileset sources_1 $top_level_files
set_property top system_1_top [current_fileset]
