# Flush mount

`homey-panel-crowpanel21-flush-v6.stl`, 82 mm across and 33.3 mm deep. The body drops into a
wall box, the front sits level with the wall, and the cup with the panel in it twists into the
bayonet. Nothing stands out from the wall and no cable is in sight, because the 5 V is made behind
the panel. This is the base that takes real work.

## What you need

- The print, in PETG, and the cup that goes with it. See the [print settings](README.md).
- An **HLK-PM01**, the 230 V to 5 V module the holder is drawn around. Another module will not
  sit in it. It is a 3 W part, so 0.6 A, under the 1 A the board is specified for. It was picked
  because it is small enough to disappear behind the panel, and 0.6 A proved to be enough at a
  normal backlight. That is one panel at one brightness rather than a specification met, so if you
  run the screen bright, or a panel starts restarting by itself, this is the first thing to suspect.
- **Two flexible mains rated conductors**, blue and brown.
- **Two Wago 221-2411** lever connectors.
- **Heatshrink** for the soldered joints.
- **The 4-pin cable that came with the panel**, the one meant for the expansion header. It fits
  the same connector as the supplied USB cable, so cutting it leaves the USB cable whole for
  flashing. The panel has no USB-C: both cables go to one 4-pin MX1.25 header.
- A standard Dutch flush mounting box, an *inbouwdoos*: the round type with 53 mm between the
  screws. Boxes elsewhere in Europe are often 60 mm (DIN 49073), where the screws do not line
  up, so measure before you print.

## Before you start

- **Switch the circuit off at the breaker, and check that it is dead** in the box you are going
  to work in, not in another one.
- **Work on the mains side is work for someone qualified to do it**, under whatever the rules
  are where you live. In many places that is not a choice.
- **The printed part is not an enclosure for mains.** PETG around live pins is not insulation.
  Every mains joint is insulated on its own, and the print only holds things in place.

## The 230 V side

1. Solder the blue and the brown conductor to the AC pins of the HLK-PM01, and pull heatshrink
   over each joint. Those pins end up inside a printed holder, and they stay live.
2. Strip the other end of each conductor, and **do not tin it**. Solder creeps under a clamping
   terminal and the connection works loose, which is not something you want in a closed wall box.
3. Lower the HLK into its holder from the front, so it is in place before anything is clamped.
4. Put each conductor into a Wago 221-2411. Then stack the two connectors on their side, clips
   facing outwards, into the clamp under the mount. On their side is what makes them fit.

## The 5 V side

Cut the 4-pin cable, keep the end that plugs into the panel, and solder its 5 V and ground to the
DC side of the HLK. Work out which conductor is which before you connect it: reversed 5 V does
not announce itself.

The cable passes through the round hole at the bottom of the mount, which is sized for it, and
comes out where the panel reaches it.

## Checking it

Put the breaker back on and measure at the plug before the panel goes near it. It should read
close to 5 V with nothing connected, and stay there once the panel is drawing. A reading that
sags under load means the module or the wiring to it, and will come back later as a panel that
restarts every few minutes while the screen stays lit.

Flash and set up the panel before the box goes back together, as in the
[main instructions](../../README.md): the setup network, the knob and the USB port are all
easier to reach while the panel is still in your hand.
