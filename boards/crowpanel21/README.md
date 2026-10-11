# Elecrow CrowPanel 2.1" rotary

Board id `crowpanel21`. An ESP32-S3 with a 480×480 round IPS touchscreen and a rotary
encoder ring around it. Nothing has to be soldered or modified.

- **Where to buy:** [Elecrow](https://www.elecrow.com/crowpanel-2-1inch-hmi-esp32-rotary-display-480-480-ips-round-touch-knob-screen.html)
  sells it directly; it also shows up on the usual marketplaces.
- **What it runs:** ESP32-S3 with 16 MB flash and 8 MB PSRAM, ST7701 display controller,
  capacitive touch, rotary encoder with a push.
- **Power and data on one connector:** the board takes both on a 4-pin MX1.25 header, and the
  cable in the box turns that into a USB plug. There is no USB-C on it, so a USB-C supply is of no
  use without that cable.
- **Power:** 5 V at 1 A from a USB supply. The screen is on all day, so use one you would trust to
  run permanently. Each mount in
  [`models/crowpanel21/`](../../models/crowpanel21/) says which supply it is built around and
  how that one is wired.

## Dimensions, for designing your own enclosure

Elecrow gives the panel as **79 × 79 × 30 mm and 80 g**, and publishes the whole assembly,
board and shell, as a STEP file:
[`3D file/00-irad-21.stp`](https://github.com/Elecrow-RD/CrowPanel-2.1inch-HMI-ESP32-Rotary-Display-480-480-IPS-Round-Touch-Knob-Screen/tree/master/3D%20file).
That is the reference to model against. What it does not say is what an enclosure has to leave
room for, and those are the figures below. They are what the printed
[cup](../../models/crowpanel21/) is built around, and a panel fits it, so they are proven to fit
rather than measured to a tenth.

Angles are seen from the front, through the screen: 0° is 3 o'clock, they run anticlockwise, and
90° is the top of the screen. Seen from the back, left and right swap.

| What | Figure |
| --- | --- |
| Back of the panel | goes into a pocket Ø49 mm across and 14 mm deep |
| Mounting points | three threaded standoffs on a Ø12.2 mm circle, 120° apart, the first at 0°: a triangle pointing right |
| Screws | M3 fits, through 4 mm clearance holes. Elecrow publishes no figure for the standoffs |
| Buttons and connector | in the ring between 11 and 23 mm from the centre. A back wall that is solid there will press them |
| Free spokes | 14 mm wide at 90°, 215° and 315°: the cup's spokes sit there and clear everything |
| Power and data | one 4-pin MX1.25 header, at the bottom (270°). The plug is about 6.3 × 4.5 mm, so a 9 mm hole lets it through |

The panel has a top. An enclosure that can be fitted a third of a turn out will be, so mark
north on it; the cup carries a notch in its rim and an arrow on its back for that.

The [OpenSCAD source](../../models/crowpanel21/homey-panel-crowpanel21-mounts.scad) of the
printed parts holds all of these as named parameters, so it is also the quickest way to start a
design of your own.

## Flashing

Use the [web flasher](https://kaohlive.github.io/homey-wallpanel/flash/), or write the
factory image from a [release](https://github.com/kaohlive/homey-wallpanel/releases):

```bash
esptool.py --chip esp32s3 --port COM3 --baud 921600 write_flash 0x0 homey-panel-crowpanel21-<version>-factory.bin
```

The `-ota.bin` in the same release is the app partition only. Homey sends that one to a panel
that is already running; you never need to download it yourself.

## Notes from the wall

- **It desenses its own receiver at full transmit power.** The firmware runs the radio at
  11 dBm, which measured 112× the throughput of the default.
- **That one connector doubles as the serial console.** If the panel stops appearing as a serial
  device, unplug it, hold BOOT while plugging it back in, and flash again.
- **The screen keeps working even when the panel is otherwise unhappy**, because the display
  needs no help from the expander to stay lit. A picture on the wall is not proof that all is
  well; the device page in Homey is.
