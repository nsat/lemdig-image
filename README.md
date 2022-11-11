# Spire Linux for LEMDIG 1.5 (marsupial)

This project contains utility scripts and the Yocto bitBake layers used for building the spire Spire Linux image for the Lemdig 1.5 board. The build produces an SD card image that can be used to flash the Marsupial.

**Requirements**

+ PC running Ubuntu 20.04.4 (Other Linux distributions may work but are not officially tested/supported)
+ PSU set to 8V, 3A max 
+ Minidock V3 board connected to PSU via banana plug power cables
+ Lemdig 1.5 (Marsupial) board plugged into Minidock V3
+ Min 8GB micro SD card and optionally SD to micro SD adapter
+ Micro USB cable for serial connection between the marsupial and the Ubuntu PC

## Quickstart

The following information should allow quick installation and building of the Spire Linux for LEMDIG 1.5

### Installation

The Ubuntu PC is required to have git installed in order to retreive the Spire Linux for LEMDIG 1.5 repo

    sudo apt install git
    
Once git is installed the repository can be cloned using

    git clone https://github.com/nsat/lemdig-image.git
    
This should create a git repository in the directory `lemdig-image`

The build runs inside a Docker container and therefore Docker is required to be installed and the user added to the docker group.

To install Docker (only required once) execute the following commands:
    
    sudo apt-get install -y docker.io
    sudo usermod -a -G docker ${USER}
    
**NB: You must now reboot your Ubuntu PC to complete the installation of Docker**

To Build docker container (only required once) execute the following commands:
    
    docker build -t yocto-lemdig .
    
### Building

The Yocto build takes place in the `/opt/lemdig-image/lemsdr/poky` directory on the Ubuntu PC and this is mapped into a volume in the Docker container, making the build system and its output accessible to both.

1. **Build the Spire Linux image**

    `cd lemdig-image`  
    `./run.sh build`  

    This will run the full build  
    
    Alternatively the build can be run manually from within the Docker shell
    
    `./run.sh shell`  
    
    Then from within the docker shell  
    
    `./configure.sh`  
    `./build.sh`  
    `exit`

    Both methods generate the file  
    
    `/opt/lemdig-image/lemsdr/poky/build/tmp/deploy/images/marsupial-zynqmp/lemdig-image-bootstrap-complete-marsupial-zynqmp.wic` 

    This file can be written to a micro SD card and flashed to the marsupial as described in step 2  
    
2. **Flash the board using a micro SD card (Requires Min 8GB micro SD card)**

+ Ensure that the Marsupial, Minidock V3 and PSU are connected as described in the requirements. There is a toggle switch on the Minidock V3 that can be used to power on/off the Marsupial.

+  Make sure the Marsupial is switched off (All LEDs on Minidock are off)

+ On your Ubuntu PC insert the micro SD card and find out which device it has been detected as (usually **`/dev/mmcblk0`** or similar) 

    **WARNING: Ensure that ***ALL*** volumes of the SD card that have been auto-mounted by Ubuntu are removed by using and use umount to remove them as shown below** 

    `sudo umount <path to mounted volume>`  
    
    And any other mounted volumes of `/dev/mmcblk0`

+ Use the following command to write the image to the SD card
    
    `dd if=/opt/lemdig-image/lemsdr/poky/build/tmp/deploy/images/marsupial-zynqmp/lemdig-image-bootstrap-complete-marsupial-zynqmp.wic of=/dev/mmcblk0 bs=1M`
   
+ Eject the micro SD card from the Ubuntu PC and insert it into the Marsupial board
   
+ Connect a micro-USB cable between the Ubuntu PC and the Marsupial. Note the name of the tty device that appears by checking the ouput of dmesg (This should only be required once to get the tty)
   
+ Open a serial terminal on your Ubuntu PC using the tty device found above at 115200 baud, 8N1.
   
+ Power on the Marsupial - The following text should be shown in the  serial terminal

```
       (\-"""-/)
        |     |
        \ ^ ^ /  .-.
         \_o_/  / /
        /`   `\/  |
       /       \  |
       \ (   ) /  |
      / \_) (_/ \ /
     |   (\-/)   |
     \  --^o^--  /
      \ '.___.' /
     .'  \-=-/  '.
    /   /`   `\   \
   (//./       \.\\)
    `"`         `"`

 __  __    _    ____  ____  _   _ ____ ___    _    _     
|  \/  |  / \  |  _ \/ ___|| | | |  _ \_ _|  / \  | |    
| |\/| | / _ \ | |_) \___ \| | | | |_) | |  / _ \ | |    
| |  | |/ ___ \|  _ < ___) | |_| |  __/| | / ___ \| |___ 
|_|  |_/_/   \_\_| \_\____/ \___/|_|  |___/_/   \_\_____|

Built on Aug 19 2021 at 12:55:02

Available commands:
r - reset stm32
s - read sensors
o - Switch on DIG peripherals
f - Switch off DIG peripherals
n - Set NAND boot
e - enable ethernet
q - Emergency power off
p - Enter UART passthrough (no return!)
1 - Boot Som QSPI
2 - Boot Som SD
h - this help

Will autoboot from QSPI after 3000 milliseconds, press any key to interrupt autoboot

```

+ Before the 3s timeout has passed press '2' in the serial terminal to get the marsupial to boot from the micro SD card. If you miss the 3s timeout simply power the unit off then on again and retry

+ The following text should be shown in the serial terminal

```
Autoboot interrupted
booting from SD
Setting up SOM - stage 1
TCA95XX: Set 0040
33
TCA95XX: Set 0001
Power good!
18
Setting up SOM - stage 2
TCA95XX: Set 8000
TCA95XX: Set 4000
TCA95XX: Set 0002
Power good!
TCA95XX: Set 0004
Power not good yet
Power good!
TCA95XX: Set 0008
Power good!
TCA95XX: Set 0010
Power good!
TCA95XX: Set 0020
Power good!
TCA95XX: Set 0080
DONE: False
INIT_B: False
ERR_STATUS: False
ERR_OUT: False
PG_33V: True
EN_18V: True

TCA95XX: Read FFFF
EN_LPD:  Enabled
LP_GOOD: True
EN_FPD:  Enabled
PG_FPD:  True
EN_PL:   Enabled
PG_PL:   True
EN_DDR:  Enabled
PG_DDR:  True
EN_PSGT: Enabled
PG_PGST: True
EN_GT_R: Enabled
PG_GT_R: True
MR:      Enabled
EN_10V:  Enabled
NAND_EN: Enabled
SD_EN:   Enabled

Reading INA219s from MCU_I2C
INA219 MCU 1.8V: 1.808 V 12.600 mA
INA219 MCU 3.3V: 3.312 V 4.600 mA
INA219 SOM 1.8V: 1.812 V 31.000 mA
INA219 SOM 3.3V: 3.288 V 535.000 mA
Done setting up SOM

```
+ Now press 'p' to boot into the u-boot on SD card

+ During the u-boot countdown press ENTER to drop into the u-boot prompt then run the following command to boot the system from the SD card

    `run bootcmd_mmc0`  
   
+ Once linux is running, login at the prompt with user `root` and an empty password.
   
+ Run the following commands to flash the SD card image to NAND
      
    `cd /`  
    `./flash_filesystem_without_sd_flash.sh`
   
+ Power cycle the board.

The board should now boot into the image from the NAND flash  

3. **Building bitbake recipes manually**  
    
    Within docker shell you can open a normal bitbake environment and build individual recipes for development purposes  
    
    For example to build the opencv recipe - 

    Open the Docker shell

    `./run.sh shell`  
    
    Then from within the docker shell. 
    
    `./configure.sh`  
    `cd /opt/lemdig-image/lemsdr/poky`  
    `source ./oe-init-build-env`  
    `bitbake opencv`  
    
   
## Introduction to BitBake and The Yocto Project
Spire Linux is built with the
[BitBake](https://en.wikipedia.org/wiki/BitBake) tool, which is a build tool
used to compile and package a full Linux distribution from source. BitBake is
used in conjunction with *recipes* provided by the [Yocto Project](https://www.yoctoproject.org/), which encode information on
how to build the packages that constitute a Linux distribution.

BitBake recipes are organized into *layers*, which represent slices of
functionality, much like layers in a cake. Most of the recipes required to
build a basic Linux distribution are provided in the so-called "meta" layer,
which is the foundational layer provided by Yocto Project. In order to build
Spire Linux, we add a *BSP layer*, which provides hardware support
for the target architecture, and a *board-specific layer*, which adds
customizations specific to a actual board and mission.

## Where do I Put my Recipe?

We currently have the recipes structured in the following layers:

```
layer                 path                                   
===============================================
meta
meta-adi
meta-openembedded
meta-poky
meta-selftest
meta-skeleton
meta-xilinx
meta-yocto-bsp
meta-spire            <repo>/lemdig-image/meta-spire 
meta-lemdig2          <repo>/lemdig-image/meta-lemdig2
meta-lemsdr           <repo>/lemdig-image/meta-lemsdr 
```

Only the `meta-spire`, `meta-lemdig2` and `meta-lemsdr` layers are sourced in this repository. The other layers are pulled from external repositories during the configuration process.

`meta-spire`    - the Spire Linux BitBake layer  
`meta-lemdig2` - the Spire Lemdig specific BitBake layer  
`meta-lemsdr`  - the Spire Lemsdr specific BitBake layer  

### Spire Layers

In general your recipe (.bb .bblayer .bbclass) should be added to the appropriate layer from the list below

[`meta-spire`](https://github.com/nsat/air/tree/master/bitbake/meta-spire) is the Spire Linux layer, is
intended to be the common layer between all boards using Bitbake

[`meta-lemdig2`](https://github.com/nsat/lemdig-image/meta-lemdig2) is the lemdig2 specific layer, intended to be used for all lemdig based boards

[`meta-lemsdr`](https://github.com/nsat/lemdig-image/meta-lemsdr) is the lemdig2 lemsdr board specific layer

The name of your recipe should then be added to the packagegroup for the lemsdr in `lemdig-image/meta-lemsdr/recipes-payload/packagegroups/packagegroup-lemsdr-system.bb` 

### Updating the FPGA image

The default FPGA bitfile can be updated by updating the file  
 
   `lemdig-image/meta-lemdsdr/recipes-bsp/bootbin-onthefly/files/design_1_wrapper.bit`

with your own design
### Adding Python Dependencies

Python dependencies are added to the meta-spire layer.

To add a python pip package, add a bb file to meta-spire/recipes-python/python-dependencies directory.
The filename should conform to the following format: `python-<package_name>_<version_number>.bb`.

Required variables within the file (with format VAR_NAME = "field_value"; one variable per line):

* `DESCRIPTION`: the package name without the version number should suffice.
* `LICENSE`: The list of source licenses for the recipe.
* `LIC_FILES_CHKSUM`: The filename should be the license file of the python package. To get the md5 value, do not include it, and run bitbake on this recipe. A warning will output the value that can then be added to this field.
* `SRC_URI`: The list of source files - local or remote. The same process of leaving these fields blank and letting bitbake output the value in a warning can be performed.
* `PV`: The Package version. 
* `inherit pypi setuptools`: standard required line for all python-dependencies files
(Just place this line directly as is in the bb file (does not conform to format mentioned above))

More details on the variables can be found in the [BitBake manual](https://www.yoctoproject.org/docs/2.1/bitbake-user-manual/bitbake-user-manual.html).

## Spire Mirror

Sources are mirrored to the Spire yocto-source-mirror S3 bucket on Amazon AWS to prevent issues with packages disappearing and/or temporary service disruptions from sources.
