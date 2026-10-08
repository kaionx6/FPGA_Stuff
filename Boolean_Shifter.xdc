# Real Digital Boolean Board: constraints for the original lab shifter.
# FPGA part: xc7s50csga324-1
# Pin source: https://www.realdigital.org/downloads/8d5c167add28c014173edcf51db78bb9.txt

# Configuration voltage settings from the official Boolean constraints.
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# 100 MHz oscillator -> clk
set_property -dict { PACKAGE_PIN F14 IOSTANDARD LVCMOS33 } [get_ports {clk}]
create_clock -name sys_clk -period 10.000 [get_ports {clk}]

# SW0 -> A
set_property -dict { PACKAGE_PIN V2 IOSTANDARD LVCMOS33 } [get_ports {A}]

# Sixteen active-high LEDs -> led[15:0]
set_property -dict { PACKAGE_PIN G1 IOSTANDARD LVCMOS33 } [get_ports {led[0]}]
set_property -dict { PACKAGE_PIN G2 IOSTANDARD LVCMOS33 } [get_ports {led[1]}]
set_property -dict { PACKAGE_PIN F1 IOSTANDARD LVCMOS33 } [get_ports {led[2]}]
set_property -dict { PACKAGE_PIN F2 IOSTANDARD LVCMOS33 } [get_ports {led[3]}]
set_property -dict { PACKAGE_PIN E1 IOSTANDARD LVCMOS33 } [get_ports {led[4]}]
set_property -dict { PACKAGE_PIN E2 IOSTANDARD LVCMOS33 } [get_ports {led[5]}]
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {led[6]}]
set_property -dict { PACKAGE_PIN E5 IOSTANDARD LVCMOS33 } [get_ports {led[7]}]
set_property -dict { PACKAGE_PIN E6 IOSTANDARD LVCMOS33 } [get_ports {led[8]}]
set_property -dict { PACKAGE_PIN C3 IOSTANDARD LVCMOS33 } [get_ports {led[9]}]
set_property -dict { PACKAGE_PIN B2 IOSTANDARD LVCMOS33 } [get_ports {led[10]}]
set_property -dict { PACKAGE_PIN A2 IOSTANDARD LVCMOS33 } [get_ports {led[11]}]
set_property -dict { PACKAGE_PIN B3 IOSTANDARD LVCMOS33 } [get_ports {led[12]}]
set_property -dict { PACKAGE_PIN A3 IOSTANDARD LVCMOS33 } [get_ports {led[13]}]
set_property -dict { PACKAGE_PIN B4 IOSTANDARD LVCMOS33 } [get_ports {led[14]}]
set_property -dict { PACKAGE_PIN A4 IOSTANDARD LVCMOS33 } [get_ports {led[15]}]
