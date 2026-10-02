# Elecrow CrowPanel 2.1" rotary

Board id `crowpanel21`. An ESP32-S3 with a 480×480 round IPS touchscreen and a rotary
encoder ring around it. Nothing has to be soldered or modified.

- **Where to buy:** [Elecrow](https://www.elecrow.com/crowpanel-esp32-display-2-1-inch-hmi-display-round-screen-touch-lcd.html)
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
