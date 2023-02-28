# ---------------------------------------------
# Load configuration
# ---------------------------------------------
if {![info exists configuration_file_loaded]} {
source $::env(TOP_SRC_DIR)/tcl/Configuration.tcl
}

clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S} -gmt true

# Set the number of threads
set_param synth.maxThreads 8

# ---------------------------------------------
# Open project
# ---------------------------------------------
open_project $build_root_dir/$project_name/$project_name.xpr

# ---------------------------------------------
# Synthesize
# ---------------------------------------------
set_property synth_checkpoint_mode None [get_files $bd_file]
reset_run -quiet $synth_name
launch_runs $synth_name -jobs 8
wait_on_run $synth_name

# ---------------------------------------------
# Implement
# ---------------------------------------------
reset_run -quiet $impl_name
launch_runs $impl_name -to_step write_bitstream -jobs 8
wait_on_run $impl_name

# ---------------------------------------------
# Export Hardware
# ---------------------------------------------
if {![file exists $sdk_dir]} {
file mkdir $sdk_dir
}
file copy -force $sysdef_file $hdf_file

clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S} -gmt true
