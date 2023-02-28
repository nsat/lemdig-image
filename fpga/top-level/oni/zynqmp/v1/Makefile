SUBMAKEFILE = Makefile.build_fpga

BIT_FILE = build/system_1_top.bit
BIN_FILE = build/system_1_top.bin

HDL_LIB_COMMON = $(FPGA_SRC_ROOT_DIR)/lib
HDL_ARCHIVE = $(TOP_SRC_DIR)/hdl

all: $(BIN_FILE) extract_hdl

$(BIN_FILE): $(BIT_FILE)
	bootgen -image $(TOP_SRC_DIR)/bif/system_1_top.bif -arch zynqmp -o $@ -w

$(BIT_FILE): $(SUBMAKEFILE)
	date
	+make --no-print-directory -f $(SUBMAKEFILE)
	date

$(SUBMAKEFILE): $(TOP_SRC_DIR)/tcl/CreateMakefile.tcl
	tclsh $^

extract_hdl: $(HDL_LIB_COMMON)/ad_ip_cores_v1.tar.gz
	tar xf $< -C $(HDL_ARCHIVE)

.PHONY: extract_hdl

clean:
	rm -f $(SUBMAKEFILE)
	rm -rf hdl/*/
	rm -rf tmp
	rm -f *.text
	rm -f vivado*log vivado*jou 2> /dev/null
	rm -f build
