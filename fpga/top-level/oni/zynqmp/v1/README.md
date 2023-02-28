# ZynqMP_LEMSDRONI HDL

## Overview

- The FPGA design for LEMSDRONI board for Marsupial
- It interfaces Analog Devices (AD9364) and allows for transmission and reception of RF IQ data

## Prerequisites

- Vivado HLS WebPack 2018.2
- Vivado SDK 2018.2

## Tcl scripts

See `tcl/Configuration.tcl` for project-specific configurations.

## Build

The following explains how to compile ZynqMP for LEMSDRONI.

The build script will do all necessary tasks to build a FPGA bitstream file and ZynqMP-PS configuration files.

```
> cd fpga/scripts
> ./build.sh oni zynqmp v1

```

Build process will take approximately 30 mins.

## Output products

When build completes successfully, the output files will be in local build directory:

```
../build/oni_zynqmp_v1/

```
