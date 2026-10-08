# Board display constraints; hardware top: displayTestNexys
# FPGA: xc7a100tcsg324-1 (100T); choose the actual board variant
# Pin source: https://github.com/Digilent/digilent-xdc/blob/master/Nexys-A7-100T-Master.xdc
# Core segment order: [7:0] = A B C D E F G DP.
# Add ONLY the file for the board you are using.

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports {clk100}]
set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports {rstPBn}]
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {sw[0]}]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports {sw[1]}]
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports {sw[2]}]
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports {sw[3]}]
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports {sw[4]}]
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {sw[5]}]
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {digit[0]}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {digit[1]}]
set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports {digit[2]}]
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {digit[3]}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {digit[4]}]
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {digit[5]}]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {digit[6]}]
set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports {digit[7]}]
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports {segment[0]}]
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports {segment[1]}]
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports {segment[2]}]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports {segment[3]}]
set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports {segment[4]}]
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports {segment[5]}]
set_property -dict {PACKAGE_PIN R10 IOSTANDARD LVCMOS33} [get_ports {segment[6]}]
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {segment[7]}]

# Both boards have a 100 MHz input oscillator (10 ns period).
create_clock -name board_clk100 -period 10.000 [get_ports {clk100}]
# Vivado derives the 5 MHz generated clock from MMCME2_BASE.
# Do not declare the board input to be a 200 ns / 5 MHz clock.

# The pushbutton drives asynchronous MMCM/reset-synchronizer controls.
set_false_path -from [get_ports {rstPBn}]

# Every raw switch input drives only the first synchronizer stage.
# This excludes asynchronous input arrival, not the path between stages.
set_false_path -from [get_ports {sw[*]}]
