# UART TX ASIC Physical Design: Floorplan, Placement and Timing Repair

## Project Overview

This project implements the floorplanning, placement, static timing analysis (STA), and hold timing repair stages of a UART transmitter ASIC using OpenROAD and the Nangate45 standard-cell library.

## Tools and Technology

- OpenROAD
- Yosys synthesis
- Nangate45 standard-cell library
- Verilog RTL
- Tcl automation
- Linux / WSL

## Design Constraints

| Parameter | Value |
|---|---|
| Clock frequency | 50 MHz |
| Clock period | 20 ns |
| Clock uncertainty | 0.2 ns |
| Input delay | 2.0 ns |
| Output delay | 2.0 ns |
| Target utilization | 40% |
| Technology | Nangate45 |

## Physical Design Flow

1. RTL and synthesized netlist preparation
2. Floorplan initialization
3. Standard-cell row creation
4. I/O pin placement
5. Global placement
6. Detailed placement and legalization
7. Post-placement static timing analysis
8. Hold timing repair
9. Post-repair timing verification

## Timing Results

| Metric | Before Repair | After Repair |
|---|---|---|
| Hold WNS | -0.12 ns | 0.00 ns |
| Setup WNS | +17.63 ns | +17.61 ns |
| Hold violations in reported paths | Present | 0 |
| Inserted hold buffers | 0 | 174 |

The hold repair stage eliminated the reported negative hold slack while preserving positive setup timing slack.

## Floorplan Information

- Die dimensions: 42.865 × 42.865 µm
- Core area: 1052.296 µm²
- Initial instances: 207
- Initial effective utilization: 41.1%

## Project Structure

```text
uart_floorplan/
├── rtl/
│   └── uart_tx.v
├── netlist/
│   └── uart_tx_nangate.v
├── constraints/
│   └── uart_tx.sdc
├── scripts/
│   ├── run_floorplan.tcl
│   ├── run_placement.tcl
│   ├── run_post_place_sta.tcl
│   └── run_hold_fix.tcl
├── reports/
├── results/
│   ├── floorplan.odb
│   ├── global_place.odb
│   ├── detail_place.odb
│   └── hold_fixed.odb
└── README.md
```

## Current Status

Completed:
- Floorplanning
- I/O pin placement
- Global and detailed placement
- Post-placement STA
- Hold timing repair

Future work:
- Clock Tree Synthesis (CTS)
- Global routing
- Detailed routing
- Post-route timing analysis
- Physical verification

## Conclusion

The UART TX design successfully completed floorplanning, placement, and hold timing repair using OpenROAD. The final timing reports show a hold WNS of 0.00 ns and a setup WNS of +17.61 ns.

This project demonstrates an introductory ASIC physical design workflow from synthesized netlist to timing-repaired placement.