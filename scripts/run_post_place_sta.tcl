# UART TX - Post-Placement STA

set project_dir [file normalize [file join [pwd]]]
set platform_dir [file normalize \
    [file join $project_dir .. OpenROAD-flow-scripts flow platforms nangate45]]

# 1. Read technology and standard-cell library
read_lef [file join $platform_dir lef NangateOpenCellLibrary.tech.lef]
read_lef [file join $platform_dir lef NangateOpenCellLibrary.macro.lef]
read_liberty [file join $platform_dir lib NangateOpenCellLibrary_typical.lib]

# 2. Load detailed-placement database
read_db [file join $project_dir results detail_place.odb]

# 3. Load timing constraints
read_sdc [file join $project_dir constraints uart_tx.sdc]

# 4. Initialize timing estimation
source [file join $platform_dir setRC.tcl]
estimate_parasitics -placement

# 5. Generate timing reports
set report_dir [file join $project_dir reports]
file mkdir $report_dir

report_checks -path_delay max -group_path_count 10 \
    -format full_clock_expanded \
    > [file join $report_dir post_place_setup.rpt]

report_checks -path_delay min -group_path_count 10 \
    -format full_clock_expanded \
    > [file join $report_dir post_place_hold.rpt]

report_worst_slack -max \
    > [file join $report_dir post_place_wns_setup.rpt]

report_worst_slack -min \
    > [file join $report_dir post_place_wns_hold.rpt]

report_tns \
    > [file join $report_dir post_place_tns.rpt]

puts "=================================="
puts "UART TX POST-PLACEMENT STA COMPLETED"
puts "=================================="
