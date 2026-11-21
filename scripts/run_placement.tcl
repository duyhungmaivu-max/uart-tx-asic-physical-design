# Project 2 - UART TX Placement
# Nangate45 / OpenROAD

set project_dir [file normalize [file join [file dirname [info script]] ..]]
set platform_dir [file normalize [file join $project_dir .. OpenROAD-flow-scripts flow platforms nangate45]]

# Load floorplan database
read_db [file join $project_dir results floorplan.odb]

# Load timing library and constraints
read_liberty [file join $platform_dir lib NangateOpenCellLibrary_typical.lib]
read_sdc [file join $project_dir constraints uart_tx.sdc]

# Global placement
global_placement -density 0.40

write_db [file join $project_dir results global_place.odb]

# Detailed placement
detailed_placement

# Check placement legality
check_placement -verbose

# Save final placement
write_db [file join $project_dir results detail_place.odb]

puts "UART TX PLACEMENT COMPLETED"
