# ---------------------------------------------
# Load configuration
# ---------------------------------------------
if {![info exists configuration_file_loaded]} {
source $::env(TOP_SRC_DIR)/tcl/Configuration.tcl
}

# ---------------------------------------------
# Create Makefile
# ---------------------------------------------
set fd [open "Makefile.build_fpga" w]
puts $fd "

# The following is necessary to avoid dash on ubuntu.
SHELL = /bin/bash

# Constants
project_dir         = $project_dir
wrapper_vhd_file    = $wrapper_verilog_file
bit_file            = $bit_file
hdf_file            = $hdf_file

IP_XML_FILES = hdl/axi_ad9361/component.xml \\
							 hdl/axi_dmac/component.xml \\
							 hdl/util_cdc/component.xml \\
							 hdl/util_axis_fifo/component.xml \\
							 hdl/util_axis_resize/component.xml \\
							 hdl/util_clkdiv/component.xml \\
							 hdl/util_cpack/component.xml \\
							 hdl/util_tdd_sync/component.xml \\
							 hdl/util_wfifo/component.xml \\
							 hdl/util_rfifo/component.xml \\
							 hdl/util_upack/component.xml

LOG_PACKAGE_IP_DMACONTROLLER = log_package_ip_dmacontroller.text
LOG_PACKAGE_IP_AD9361 = log_package_ip_ad9361.text
LOG_PACKAGE_IP_CDC = log_package_ip_cdc.text
LOG_PACKAGE_IP_FIFO = log_package_ip_fifo.text
LOG_PACKAGE_IP_RESIZE = log_package_ip_resize.text
LOG_PACKAGE_IP_CLKDIV = log_package_ip_clkdiv.text
LOG_PACKAGE_IP_CPACK = log_package_ip_cpack.text
LOG_PACKAGE_IP_TDD = log_package_ip_tdd.text
LOG_PACKAGE_IP_WFIFO = log_package_ip_wfifo.text
LOG_PACKAGE_IP_RFIFO = log_package_ip_rfifo.text
LOG_PACKAGE_IP_UPACK = log_package_ip_upack.text
LOG_CREATE_PROJECT = log_create_project.text
LOG_GENERATE_BITSTREAM = log_generate_bitstream.text
LOG_CREATE_HARDWARE_PROJECT = log_create_hardware_project.text

HDL_SRC_DIR = $::env(TOP_SRC_DIR)/hdl

# Target definitions
all: build/\$(notdir \$(bit_file)) build/\$(notdir \$(hdf_file))

hdl/axi_ad9361/component.xml: \$(wildcard \$(HDL_SRC_DIR)/axi_ad9361/*.v)
	@echo \"Packaging a AD9361 IP\"
	@vivado -m64 -mode batch -source \$(HDL_SRC_DIR)/axi_ad9361/PackageAD9361IP.tcl &> \$(LOG_PACKAGE_IP_AD9361)

hdl/axi_dmac/component.xml: \$(wildcard \$(HDL_SRC_DIR)/axi_dmac/*.v)
	@echo \"Packaging a DMA IP\"
	@vivado -m64 -mode batch -source \$(HDL_SRC_DIR)/axi_dmac/PackageDMAIP.tcl &> \$(LOG_PACKAGE_IP_DMACONTROLLER)

hdl/util_cdc/component.xml: \$(wildcard \$(HDL_SRC_DIR)/util_cdc/*.v)
	@echo \"Packaging a CDC IP\"
	@vivado -m64 -mode batch -source \$(HDL_SRC_DIR)/util_cdc/PackageUtilCdc.tcl &> \$(LOG_PACKAGE_IP_CDC)

hdl/util_axis_fifo/component.xml: \$(wildcard \$(HDL_SRC_DIR)/util_axis_fifo/*.v)
	@echo \"Packaging a FIFO IP\"
	@vivado -m64 -mode batch -source \$(HDL_SRC_DIR)/util_axis_fifo/PackageUtilAxiFifoIP.tcl &> \$(LOG_PACKAGE_IP_FIFO)

hdl/util_axis_resize/component.xml: \$(wildcard \$(HDL_SRC_DIR)/util_axis_resize/*.v)
	@echo \"Packaging a RESIZE IP\"
	@vivado -m64 -mode batch -source \$(HDL_SRC_DIR)/util_axis_resize/PackageUtilAxiResizeIP.tcl &> \$(LOG_PACKAGE_IP_RESIZE)

hdl/util_clkdiv/component.xml: \$(wildcard \$(HDL_SRC_DIR)/util_clkdiv/*.v)
	@echo \"Packaging a CLKDIV IP\"
	@vivado -m64 -mode batch -source \$(HDL_SRC_DIR)/util_clkdiv/PackageClkDivIP.tcl &> \$(LOG_PACKAGE_IP_CLKDIV)

hdl/util_cpack/component.xml: \$(wildcard \$(HDL_SRC_DIR)/util_cpack/*.v)
	@echo \"Packaging a CPACK IP\"
	@vivado -m64 -mode batch -source \$(HDL_SRC_DIR)/util_cpack/PackageCpackIP.tcl &> \$(LOG_PACKAGE_IP_CPACK)

hdl/util_tdd_sync/component.xml: \$(wildcard \$(HDL_SRC_DIR)/util_tdd_sync/*.v)
	@echo \"Packaging a TDD_SYNC IP\"
	@vivado -m64 -mode batch -source \$(HDL_SRC_DIR)/util_tdd_sync/PackageTDDSyncIP.tcl &> \$(LOG_PACKAGE_IP_TDD)

hdl/util_wfifo/component.xml: \$(wildcard \$(HDL_SRC_DIR)/util_wfifo/*.v)
	@echo \"Packaging a WFIFO IP\"
	@vivado -m64 -mode batch -source \$(HDL_SRC_DIR)/util_wfifo/PackageWriteFIFOIP.tcl &> \$(LOG_PACKAGE_IP_WFIFO)

hdl/util_rfifo/component.xml: \$(wildcard \$(HDL_SRC_DIR)/util_rfifo/*.v)
	@echo \"Packaging a RFIFO IP\"
	@vivado -m64 -mode batch -source \$(HDL_SRC_DIR)/util_rfifo/PackageReadFIFOIP.tcl &> \$(LOG_PACKAGE_IP_RFIFO)

hdl/util_upack/component.xml: \$(wildcard \$(HDL_SRC_DIR)/util_upack/*.v)
	@echo \"Packaging a UPACK IP\"
	@vivado -m64 -mode batch -source \$(HDL_SRC_DIR)/util_upack/PackageUpackIP.tcl &> \$(LOG_PACKAGE_IP_UPACK)

\$(wrapper_vhd_file): \$(IP_XML_FILES)
	@echo \"Creating a Vivado project\"
	@echo \" Log: \$(LOG_CREATE_PROJECT)\"
	@vivado -m64 -mode batch -source $::env(TOP_SRC_DIR)/tcl/CreateProject.tcl &> \$(LOG_CREATE_PROJECT)

\$(bit_file): \$(wrapper_vhd_file)
	@echo \"Generating a bitstream file\"
	@echo \" Log: log_generate_bitstream.text\"
	@vivado -m64 -mode batch -source $::env(TOP_SRC_DIR)/tcl/GenerateBitstream.tcl &> log_generate_bitstream.text

\$(hdf_file): \$(bit_file)

build/\$(notdir \$(bit_file)): \$(bit_file)
	@install -d build
	@cp \$(bit_file) build
	@echo \"Bitstream \$(notdir \$(bit_file)) copied to \$@/\"

build/\$(notdir \$(hdf_file)): \$(hdf_file)
	@install -d build
	@cp \$(hdf_file) build
	@echo \"Hardware Design File \$(notdir \$(hdf_file)) copied to \$@/\"
"
