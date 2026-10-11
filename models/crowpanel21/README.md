# Enclosures for the CrowPanel 2.1" rotary

## Print the cup, then a base

The cup (`homey-panel-crowpanel21-cup-v4.stl`, 53 x 17.5 mm) holds the panel and carries one half
of the bayonet. Print it whatever you are building.

Three M3 bolts through its back wall hold it to the panel's own standoffs, through 4 mm clearance
holes on a 12.2 mm circle in a wall 2 mm thick. Elecrow publishes no figure for those standoffs, so
M3 is what fits rather than what is specified, and the clearance holes will take a little less. Any
length that clears the 2 mm wall and still bites will do. Around that back wall sit three spokes, placed to
leave the buttons and the connectors clear, and the power cable runs between them into the
connector. The cup says which way is up: a notch at its top edge, and an arrow on its base. Follow
it, because the panel has a top too, and a cup fitted a third of a turn out puts the screen
sideways in the base and the cable somewhere other than the opening meant for it.

Then print one base for it to twist into:

| Base | What it is | Power |
| --- | --- | --- |
| `homey-panel-crowpanel21-flush-v6.stl` | 82 x 33.3 mm. Drops into a Dutch wall box, front level with the wall. [How to build it](flush.md). | Makes its own 5 V from the mains behind the panel |
| `homey-panel-crowpanel21-deskstand-v3.stl` | 78 x 77 x 51 mm. Holds the panel at an angle on a desk or a shelf. Nothing to build. | A USB adapter, with the cable from the box |

The cup clicks into a base and twists off again, so the same panel moves from the wall to a desk
and back.

Those two power lines are what each base was drawn for, not a rule. The stand assumes the adapter
that came in the box, the flush mount assumes a supply built into it, and either can be fed
another way if you would rather. They are models; change them.

## Printing

PETG, and not only because of the heat. The bayonet clicks shut because PETG bends a little, and
that click is what holds the panel in its base.

- 0.2 mm layer height, 0.4 mm nozzle
- 3 perimeters, 20% infill

PLA is out: the flush mount sits against a supply that is warm all day, and a panel on a sunlit
wall gets warm on its own. Whether a stiffer material still clicks has not been tried, and ASA or
PC may simply be too rigid to give, so if you go there, print a cup and a base first and feel it
before you fit anything to a wall.

## If your printer prints tight or loose

All three parts come from one OpenSCAD file,
[`homey-panel-crowpanel21-mounts.scad`](homey-panel-crowpanel21-mounts.scad). Set `part` to
`"cup"`, `"base"` or `"desk"` and export an STL; `"preview"` shows the flush mount assembled in its
wall box, cut in half.

The bayonet is drawn with clearances that suit one printer. If a cup will not go in, rocks once it
is in, or turns without a click, these are the numbers to change, in mm, and their names are listed
again at the top of the file:

| Parameter | Default | What it does |
| --- | --- | --- |
| `fit` | 0.30 | Gap all round between the cup and the sleeve. Up if the cup will not go in, down if it rocks |
| `slack` | 0.35 | Gap in the bayonet slots, along the axis. Up if the twist is stiff |
| `detent_p` | 0.55 | How far the click bumps stand out. Up for a firmer click, down if it will not turn at all |
| `desk_fit`, `desk_slack`, `desk_detent_p` | 0.30, 0.22, 0.65 | The same three for the desk stand, which prints tilted and comes out of the printer differently |
| `hole_d` | 4.0 | The bolt holes in the cup |
| `clip_slack`, `wago_fit` | 0.45, 0.40 | The holder for the HLK-PM01 and the clamp for the Wago connectors |

Change one at a time, print a cup and a base, and feel it before you change the next. The
board's own dimensions, for an enclosure of your own, are on the
[board page](../../boards/crowpanel21/README.md#dimensions-for-designing-your-own-enclosure).

The file renders in any recent OpenSCAD. Set the backend to Manifold (Preferences > Advanced, in
2024 and newer) and it takes seconds instead of minutes.

## What they all need

The board wants 5 V at 1 A and the screen is on all day, so whatever feeds it should be something
you would leave running permanently. See the [board notes](../../boards/crowpanel21/README.md) for
the electrical side. The flush mount knowingly sits under that figure, for a module small enough
to fit; its page says what that means.

A supply that is too weak does not show as a dark screen. The display stays lit while the panel
restarts every few minutes, so judge it from the device page in Homey, not from the wall. Thin or
long wire between the supply and the panel does the same thing.
