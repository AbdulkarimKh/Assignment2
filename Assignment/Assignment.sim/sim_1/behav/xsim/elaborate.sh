#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Wed Dec 04 23:23:12 +03 2024
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto c32e7cce36494601a482e8e64d7b0d07 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_bresenham_circle_behav xil_defaultlib.tb_bresenham_circle xil_defaultlib.glbl -log elaborate.log"
xelab -wto c32e7cce36494601a482e8e64d7b0d07 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_bresenham_circle_behav xil_defaultlib.tb_bresenham_circle xil_defaultlib.glbl -log elaborate.log

