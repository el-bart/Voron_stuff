# commands to run from printer console

## misc
`FIRMWARE_RESTART` - restart RT board (BTT Octopus)
`RESTART` - restart `klipper`
`M114` - return current XYZE positions

## move steppers around
`STEPPER_BUZZ STEPPER=stepper_x`
`STEPPER_BUZZ STEPPER=stepper_y`
`STEPPER_BUZZ STEPPER=stepper_z`
`STEPPER_BUZZ STEPPER=stepper_z1`
`STEPPER_BUZZ STEPPER=stepper_z2`
`STEPPER_BUZZ STEPPER=stepper_z3`
`STEPPER_BUZZ STEPPER=extruder`

## status
`STATUS` - `klipper` status (connected/disconnected)
`QUERY_ENDSTOPS` - XYZ
`QUERY_PROBE` - bed leveling probe

## calibration

### heaters
`TURN_OFF_HEATERS`
`PID_CALIBRATE HEATER=extruder TARGET=200`
`PID_CALIBRATE HEATER=heater_bed TARGET=80`
`SAVE_CONFIG` to save new PID settings

### probe
`PROBE` - check the Z height when probe hits the bed
