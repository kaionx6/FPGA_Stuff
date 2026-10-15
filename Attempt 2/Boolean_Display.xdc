# Real Digital Boolean board: xc7s50csga324-1
# Top module: displayTestBoolean
# Pins verified against the manufacturer's Boolean master constraints and schematic.
# Reference: https://www.realdigital.org/hardware/boolean
# Course segment order is [7:0] = a b c d e f g dot.
# This differs from native D0_SEG/D1_SEG numbering; pins below handle that mapping.

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# 100 MHz board oscillator. The supplied clockReset generates 5 MHz internally.
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports {clk100}]
create_clock -name sys_clk_pin -period 10.000 -waveform {0.000 5.000} [get_ports {clk100}]

# BTN0: active-high user reset button.
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {rstPB}]

# Switches SW0-SW5. SW4 or SW5 controls the fifth dot through displayTest.
set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports {sw[0]}]
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {sw[1]}]
set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS33} [get_ports {sw[2]}]
set_property -dict {PACKAGE_PIN T2 IOSTANDARD LVCMOS33} [get_ports {sw[3]}]
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports {sw[4]}]
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {sw[5]}]

# LEFT bank D0: logical digit positions 4-7.
set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVCMOS33} [get_ports {digit0[0]}]
set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports {digit0[1]}]
set_property -dict {PACKAGE_PIN C7 IOSTANDARD LVCMOS33} [get_ports {digit0[2]}]
set_property -dict {PACKAGE_PIN A8 IOSTANDARD LVCMOS33} [get_ports {digit0[3]}]

# RIGHT bank D1: logical digit positions 0-3, counted from the right.
set_property -dict {PACKAGE_PIN H3 IOSTANDARD LVCMOS33} [get_ports {digit1[0]}]
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports {digit1[1]}]
set_property -dict {PACKAGE_PIN F3 IOSTANDARD LVCMOS33} [get_ports {digit1[2]}]
set_property -dict {PACKAGE_PIN E4 IOSTANDARD LVCMOS33} [get_ports {digit1[3]}]

# LEFT bank segments: a, b, c, d, e, f, g, dot.
set_property -dict {PACKAGE_PIN D7 IOSTANDARD LVCMOS33} [get_ports {segment0[7]}]
set_property -dict {PACKAGE_PIN C5 IOSTANDARD LVCMOS33} [get_ports {segment0[6]}]
set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVCMOS33} [get_ports {segment0[5]}]
set_property -dict {PACKAGE_PIN B7 IOSTANDARD LVCMOS33} [get_ports {segment0[4]}]
set_property -dict {PACKAGE_PIN A7 IOSTANDARD LVCMOS33} [get_ports {segment0[3]}]
set_property -dict {PACKAGE_PIN D6 IOSTANDARD LVCMOS33} [get_ports {segment0[2]}]
set_property -dict {PACKAGE_PIN B5 IOSTANDARD LVCMOS33} [get_ports {segment0[1]}]
set_property -dict {PACKAGE_PIN A6 IOSTANDARD LVCMOS33} [get_ports {segment0[0]}]

# RIGHT bank segments: a, b, c, d, e, f, g, dot.
set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVCMOS33} [get_ports {segment1[7]}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {segment1[6]}]
set_property -dict {PACKAGE_PIN D2 IOSTANDARD LVCMOS33} [get_ports {segment1[5]}]
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports {segment1[4]}]
set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports {segment1[3]}]
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports {segment1[2]}]
set_property -dict {PACKAGE_PIN D1 IOSTANDARD LVCMOS33} [get_ports {segment1[1]}]
set_property -dict {PACKAGE_PIN C1 IOSTANDARD LVCMOS33} [get_ports {segment1[0]}]

