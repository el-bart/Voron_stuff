# commands to run from printer console

## misc
`RESTART` - restart `klipper`
`FIRMWARE_RESTART` - restart RT board (BTT Octopus)

## move steppers around
`STEPPER_BUZZ STEPPER=stepper_x`
`STEPPER_BUZZ STEPPER=stepper_y`
`STEPPER_BUZZ STEPPER=stepper_z`
`STEPPER_BUZZ STEPPER=stepper_z1`
`STEPPER_BUZZ STEPPER=stepper_z2`
`STEPPER_BUZZ STEPPER=stepper_z3`
`STEPPER_BUZZ STEPPER=extruder`

## kliper status
`STATUS`
`QUERY_ENDSTOPS`

## heaters
`TURN_OFF_HEATERS`

### calibration
`PID_CALIBRATE HEATER=extruder TARGET=200`
`PID_CALIBRATE HEATER=heater_bed TARGET=80`
`SAVE_CONFIG` to save new PID settings
