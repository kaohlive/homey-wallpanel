# Enclosures

3D models for putting a panel on a wall, or on a desk.

Mounting is two printed parts: a **cup** that holds the panel and carries half of a bayonet, and
a **base** it twists into. The cup is always the same, so a panel moves from the wall to a desk
and back by twisting it off one base and onto another.

![The printed cup around the panel, seated on the base, seen from the
side](../images/panel-mount.jpg)

A base is more than a printed part. It decides how 5 V reaches the panel, and that differs per
base, so a base that needs building has its own page next to its print files.

## CrowPanel 2.1" rotary (`crowpanel21`)

Print settings and what they share: [crowpanel21/](crowpanel21/)

| Part | What it is | Power | Build |
| --- | --- | --- | --- |
| Cup | Holds the panel. Print this one whatever you are building. | | Clip in, twist on |
| Flush base | Drops into a Dutch wall box, front level with the wall | 230 V to 5 V behind the panel | [flush.md](crowpanel21/flush.md) |
| Desk stand | Holds the panel at an angle on a desk | A USB adapter, with the cable from the box | Nothing to build |

## File names

Print files are named `homey-panel-<board>-<part>-v<n>`, lowercase, so a file still says what it is
once it sits in a downloads folder. The `v<n>` is the revision of that part and has nothing to do
with a firmware version: it goes up whenever the geometry changes, so you can tell which one you
printed. STL is what you print. Where a STEP is published it carries the same basename, so the
part can be changed in a CAD package. Pages like `flush.md` are the build instructions and are not
versioned.

These models are CC BY-SA 4.0; see the licence in the repository root.
