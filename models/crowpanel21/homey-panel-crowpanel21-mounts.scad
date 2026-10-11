/* ============================================================
   CrowPanel 2.1" rotary  -  bayonet mounts
   ------------------------------------------------------------
   The source of the published print files:

     part = "cup"   homey-panel-crowpanel21-cup-v4.stl
     part = "base"  homey-panel-crowpanel21-flush-v6.stl
     part = "desk"  homey-panel-crowpanel21-deskstand-v3.stl

     "cup"   holds the panel. Three M3 bolts through its back
             wall into the panel's own standoffs, on the bench.
             Measured from Elecrow's own stand for this panel.
     "base"  flush mount for a Dutch wall box: flange, bayonet
             sleeve, snap clip for an HLK-PM01.
     "desk"  desk stand with the same bayonet. No 230 V, only a
             cable exit at the back.

   part = "cup" | "base" | "desk" | "doos" | "assy" | "preview"
   ("doos" is the wall box, for reference only; "assy" and
   "preview" show the parts together, cut in half.)

   The bayonet lives in shared modules (receiver_tube,
   bayonet_cuts, tongue_cuts, detents), so the flush mount and
   the desk stand can never drift apart.

   ORIENTATION: the three PCB holes form a triangle pointing
   right, so hole 1 is at 0 degrees. In the locked position that
   is horizontal. Angles run anticlockwise, 90 = north = the top
   of the screen.

   FIT: if your printer prints tight or loose, these are the
   numbers to change, in mm. Change one, print a cup and a base,
   and feel it before you change the next.
     fit            radial gap between cup and sleeve (wall)
     slack          axial gap in the bayonet slots (wall)
     detent_p       how far the click bumps stand out (wall)
     desk_fit, desk_slack, desk_detent_p
                    the same three for the desk stand, which
                    prints tilted and so comes out different
     hole_d         the bolt holes in the cup
     clip_slack, clip_slack_l, wago_fit
                    the HLK-PM01 clip and the Wago clamp

   SPEED: set Preferences > Advanced > backend to Manifold
   (OpenSCAD 2024 or newer). The 2021 release renders it too,
   only slowly.

   PETG. No PLA in the flush mount: the HLK sits in it.

   Licence: CC BY-SA 4.0, see the repository root.
   ============================================================ */

part = "base";

turn = 0;      // 0 = locked, -lock_angle = insertion position
cut  = true;   // section view in "assy" and "preview"

$fn = $preview ? 48 : 160;

/* ---------- 1. MEASURED FROM THE STL ------------------------ */

cup_od        = 53.0;
cup_id        = 49.0;
cup_floor     =  2.0;
cup_inner_h   = 14.0;
cup_h         = cup_inner_h + cup_floor;   // 16.0

hole_d        =  4.0;    // 3x, clearance for M3
hole_circle_d = 12.2;
hole_a0       =  0;      // triangle points right, FIXED

relief_ri     = 11.0;
relief_ro     = 23.0;
/* Spoke angles, each one adjustable. If one lands on a button,
   turn ONLY that one; the other two stay where they are.
   The cut-outs are whatever is left between them. */
spoke_a       = [90, 215, 315];   // 90 = north, gives top/bottom
spoke_w       = 14;      // do NOT narrow, the spokes are thin already

/* Optional pocket in the top of a spoke, for a button that falls
   just underneath it. [angle, radius, width, depth].
   Empty list = none. */
pockets       = [];      // e.g. [[75, 19, 7, 1.2]]
rib_h         =  1.5;    // stiffening rib on the back
rib_inset     =  2.0;

/* North mark on spoke_a[0]: an arrow in the rib on the back, for
   fitting the PCB, and a small notch in the top edge, visible
   from the side while inserting. */
mark_depth    =  0.6;

/* ---------- 2. The wall box --------------------------------- */

box_bore_d      = 60.0;
box_depth       = 35.0;
box_flange_d    = 68.0;
box_screw_pitch = 60.0;
box_screw_d     =  3.5;

boss_a          = [0, 90, 180, 270];
boss_w          = 11.0;
boss_protrude   =  3.0;
boss_h          = 12.0;

/* ---------- 3. Components ----------------------------------- */

/* WAGO 221-2411, two stacked on the north side. If yours lie the
   other way round, swap wago_w and wago_h. */
wago_l  = 35.5;
wago_w  =  8.9;  // radial, in the y direction
wago_h  =  8.1;  // in depth, each
wago_n  =  2;
wago_y  = 18.0;  // centre of the stack
wago_fit  = 0.4;
wago_bar  = 1.2; // thickness of the bracket above and below the stack
wago_bw   = 5.0; // width of the bracket, across the middle of the
                 // WAGOs so it stays clear of the levers
wago_web  = 1.6; // the two uprights at the sides

hlk_l  = 34.0;   // HLK-PM01: 5 V, 600 mA continuous, 1 A peak
hlk_w  = 20.0;
hlk_h  = 15.0;
plate_t = 1.6;   // carrier plate, the ceiling above the supply
jst_hole_d = 9.0;// 5 V pass-through: the 4-pin plug must fit through
label_h    = 3.5;// height of the 5V text
label_d    = 0.4;// relief height: two layers at 0.2 mm
label_pos  = [-12, -18];  // left of the plug hole; on the right, at
                          // 315 degrees, runs a rib of the cup
screw_cb_d = 8.0;// counterbore for the screw head
screw_cb_t = 0.8;// depth of that counterbore

/* ---------- 4. Bayonet -------------------------------------- */

lug_n      =  4;
lug_a0     = 45;    // 45/135/225/315: halfway between the box lugs
lug_t      =  4.5;  // DIAMETER of the pin
lug_r      =  2.6;
lug_z0     =  2.0;
lock_angle = 20;
slack      =  0.35;

/* The desk stand prints with its sleeve tilted 35 degrees, and
   then the slots come out of the printer slightly looser than in
   the flush mount, which stands upright. Hence its own fit. */
desk_slack    = 0.22;   // axial:   does it go in and out
desk_detent_p = 0.65;   // rotation: does it turn back and forth
desk_fit      = 0.30;   // radial:  does it tilt or rock

/* Which side of the slot carries the click bump. It must point
   UP in the PRINTER, or it is an overhang that comes out as a
   blob and holds nothing.
     flush  prints with the flange on the bed  -> "ceiling"
     desk   prints with the foot on the bed    -> "floor"          */
desk_detent_side = "floor";
desk_ring_ext    = 2.5;  // ring extended downwards, room for the
                         // tongue below the slot

corner_relief = 0.0;  // 0 = square corner

detent_d    =  2.4;
detent_p    =  0.55;
detent_back =  8.5;
tongue_w    = 20;
tongue_t    =  2.2;
tongue_gap  =  1.2;
tongue_slit =  1.2;
tongue_lead =  2.5;

/* ---------- 5. Grip tabs ------------------------------------ */

grip_n     =  4;
grip_ext   =  5.0;
grip_w     = 16;
grip_t     =  3.0;
grip_pin_d =  3.0;

/* ---------- 6. Snap clip ------------------------------------ */

clip_wall  =  2.0;
clip_lip   =  1.0;
clip_slack   = 0.45; // play in the WIDTH, per side
clip_slack_l = 1.50; // play in the LENGTH, per side: that is where
                     // the solder joints and the bent wires are
clip_end_f   = 0.35; // end wall: what fraction of the depth, measured
                     // from the carrier plate. Keep it low, so the
                     // wires at the solder joints can pass it.
clip_lead  =  1.2;  // funnel at the top of the plate, to lead it in
clip_lip_t =  1.2;  // thickness of the ledge the supply rests on   // overlaps the carrier plate; face-on-face
                    // gives two separate bodies

/* ---------- 7. Flush mount ---------------------------------- */

flange_d      = 82.0;
flange_t      =  2.5;
flange_t_edge =  1.2;
flange_taper  = 34.0;
cup_sink      = 10.0;
fit           =  0.3;
wall          =  2.6;

/* ---------- 8. Desk stand ----------------------------------- */

tilt        = 35;     // viewing angle, as on the original Elecrow stand
collar      =  2.0;   // material around the sleeve; the collar is
                      // solid, not double-walled
foot_x      = 78.0;
foot_y      = 76.0;
foot_t      =  3.0;
foot_r      =  8.0;   // rounding of the foot
skirt_wall  =  2.6;   // the stand is a hollow skirt, not a wedge
cable_d     =  8.0;   // slot in the back wall, at the bottom
cable_pinch =  1.2;   // how much narrower the entry is; grips the cable

/* ============================================================
   DERIVED
   ------------------------------------------------------------
   The receiver has its own coordinate system: z = 0 is the top
   edge of the sleeve, the cup enters it from +z.
   ============================================================ */

sleeve_id   = cup_od + 2*fit;
sleeve_od   = sleeve_id + 2*wall;        // 59.2
function lugw(sl)   = 2 * asin((lug_t/2 + sl) / (cup_od/2));
// floor of the slot, local, symmetric around the pin for any slack
function slotzl(sl) = z_cup + lug_z0 - sl - flange_t;
lug_w       = lugw(slack);

z_cup       = -cup_sink;                 // flush mount, wall face = 0
slot_z      = z_cup + lug_z0 - slack;
// top of the carrier plate: just below the ribs of the cup, which
// stick out rib_h below the cup floor
comp_z      = z_cup - rib_h - 0.3;

recv_bottom = comp_z - flange_t;         // local, negative
slot_zl     = slot_z - flange_t;         // local
collar_od   = sleeve_od + 2*collar;

/* ---------- tools ------------------------------------------- */

module sector(ri, ro, a1, a2, h) {
  n = max(3, ceil(abs(a2 - a1) / 4));
  outer = [for (i = [0 : n])
             let (a = a1 + (a2 - a1) * i / n) [ro*cos(a), ro*sin(a)]];
  inner = [for (i = [n : -1 : 0])
             let (a = a1 + (a2 - a1) * i / n) [ri*cos(a), ri*sin(a)]];
  linear_extrude(height = h) polygon(concat(outer, inner));
}

module lug(a_mid) {
  len = lug_r + 1.2;
  rotate([0, 0, a_mid])
    translate([cup_od/2 - 1.2, 0, lug_z0 + lug_t/2])
      rotate([0, 90, 0])
        hull() {
          cylinder(d = lug_t, h = 0.01, $fn = 24);
          translate([0, 0, len - lug_t/2]) sphere(d = lug_t, $fn = 16);
        }
}

/* "5V" from polygons. text() depends on a font that OpenSCAD
   does not always find, and then silently yields nothing. */

module label_5v(h) {
  sc = h / 6;
  scale([sc, sc]) {
    translate([0, 4.8]) square([4.0, 1.2]);     // 5: top bar
    translate([0, 2.4]) square([1.2, 3.6]);     //    left leg
    translate([0, 2.4]) square([4.0, 1.2]);     //    middle bar
    translate([2.8, 0]) square([1.2, 3.6]);     //    right leg
    translate([0, 0])   square([4.0, 1.2]);     //    bottom bar
    translate([5.2, 0])                          // V
      polygon([[0, 6], [1.2, 6], [2.4, 1.6], [3.6, 6],
               [4.8, 6], [2.9, 0], [1.9, 0]]);
  }
}

/* A tray without a bottom. The lips on the deep side point
   inwards and form the ledge the supply rests on; the open front
   is where you put it in and take it out again. */

module clip(l, w, h) {
  lw = l + 2*clip_slack_l;
  ww = w + 2*clip_slack;
  for (s = [-1, 1]) {
    translate([0, s*(ww/2 + clip_wall/2), (h + clip_lip_t)/2])
      cube([lw + 2*clip_wall, clip_wall, h + clip_lip_t], center = true);
    translate([0, s*(ww/2 - clip_lip/2), h + clip_lip_t/2])
      cube([lw*0.55, clip_lip, clip_lip_t], center = true);
    // end wall against the carrier plate, kept low
    translate([s*(lw/2 + clip_wall/2), 0, h*clip_end_f/2])
      cube([clip_wall, ww, h*clip_end_f], center = true);
  }
}

/* ============================================================
   SHARED BAYONET  -  local coordinates, z = 0 is the top edge
   ============================================================ */

module receiver_tube(rb = recv_bottom) {
  translate([0, 0, rb]) cylinder(d = sleeve_od, h = -rb);
}

/* below: how far the bore continues BELOW the bottom of the
   sleeve. The desk stand wants it to go right through (cable),
   the flush mount does not: the carrier plate is there, and it
   would otherwise be cut away. */

module receiver_bore(bd = sleeve_id, rb = recv_bottom, below = 1) {
  translate([0, 0, rb - below]) cylinder(d = bd, h = -rb + below + 3);
}

/* ro: how far outwards to cut. The desk stand has a collar
   around it, so there it goes further. */

module bayonet_cuts(ro, sl = slack) {
  lw = lugw(sl);
  sz = slotzl(sl);
  for (i = [0 : lug_n - 1]) {
    a_in = lug_a0 - lock_angle + i * 360/lug_n;

    translate([0, 0, sz - corner_relief])
      sector(sleeve_id/2 - 1, ro,
             a_in - lw/2 - sl, a_in + lw/2 + sl,
             -sz + corner_relief + 2);

    translate([0, 0, sz])
      sector(sleeve_id/2 - 1, ro,
             a_in - lw/2 - sl,
             a_in + lock_angle + lw/2,         // stop exactly at lug_a0
             lug_t + 2*sl);
  }
}

module tongue_cuts(ro, sl = slack, side = "ceiling") {
  sz = slotzl(sl);
  for (i = [0 : lug_n - 1]) {
    ad     = lug_a0 - detent_back + i * 360/lug_n;
    a_free = ad - tongue_lead;
    a_fix  = a_free + tongue_w;

    // z_t: underside of the tongue. z_g: underside of the spring gap
    z_t = side == "ceiling" ? sz + lug_t + 2*sl        : sz - tongue_t;
    z_g = side == "ceiling" ? z_t + tongue_t           : z_t - tongue_gap;

    translate([0, 0, z_g])                    // spring gap
      sector(sleeve_id/2 - 1, ro, a_free - tongue_slit, a_fix, tongue_gap);

    rotate([0, 0, a_fix])                     // rounded root
      translate([sleeve_id/2 - 1, 0, z_g + tongue_gap/2])
        rotate([0, 90, 0])
          cylinder(d = tongue_gap, h = ro - sleeve_id/2 + 2, $fn = 20);

    translate([0, 0, min(z_t, z_g)])          // slit at the free end
      sector(sleeve_id/2 - 1, ro, a_free - tongue_slit, a_free,
             tongue_t + tongue_gap);
  }
}

module detents(sl = slack, dp = detent_p, side = "ceiling") {
  sz = slotzl(sl);
  zc = side == "ceiling" ? sz + lug_t + 2*sl + detent_d/2 - dp   // hangs
                         : sz - detent_d/2 + dp;                 // stands
  for (i = [0 : lug_n - 1])
    rotate([0, 0, lug_a0 - detent_back + i * 360/lug_n])
      translate([(sleeve_id + sleeve_od)/4, 0, zc])
        sphere(d = detent_d, $fn = 20);
}

/* ============================================================
   PART 1: the cup
   ============================================================ */

module cup() {
  difference() {
    union() {
      cylinder(d = cup_od, h = cup_h);
      for (i = [0 : lug_n - 1]) lug(lug_a0 + i * 360/lug_n);
      for (i = [0 : grip_n - 1])
        translate([0, 0, cup_h - grip_t])
          sector(cup_od/2 - 1, cup_od/2 + grip_ext,
                 lug_a0 - grip_w/2 + i * 360/grip_n,
                 lug_a0 + grip_w/2 + i * 360/grip_n, grip_t);
    }
    union() {
      translate([0, 0, cup_floor]) cylinder(d = cup_id, h = cup_inner_h + 1);

      translate([0, 0, -0.5])
        for (i = [0 : 2])
          sector(relief_ri, relief_ro,
                 spoke_a[i] + spoke_w/2,
                 spoke_a[(i + 1) % 3] - spoke_w/2 + (i == 2 ? 360 : 0),
                 cup_floor + 1);

      // pockets for buttons on the back of the board
      for (pk = pockets)
        rotate([0, 0, pk[0]])
          translate([pk[1], 0, cup_floor - pk[3]])
            cylinder(d = pk[2], h = pk[3] + 1, $fn = 32);

      for (i = [0 : 2])
        rotate([0, 0, hole_a0 + i * 120])
          translate([hole_circle_d/2, 0, -1])
            cylinder(d = hole_d, h = cup_floor + 2);

      for (i = [0 : grip_n - 1])
        rotate([0, 0, lug_a0 + i * 360/grip_n])
          translate([cup_od/2 + grip_ext/2, 0, cup_h - grip_t/2])
            cylinder(d = grip_pin_d, h = grip_t);

      // north notch in the top edge, between two grip tabs
      rotate([0, 0, spoke_a[0]])
        translate([cup_od/2, 0, cup_h - 1.5])
          rotate([0, 0, 45])
            cube([2.2, 2.2, 3.2], center = true);
    }
  }
  difference() { spoke_ribs(); north_arrow(); }
}

module north_arrow() {
  rotate([0, 0, spoke_a[0]])
    translate([0, 0, -rib_h - 0.01])
      linear_extrude(height = mark_depth + 0.01)
        polygon([[13, -0.5], [17, -0.5], [17, -1.3],
                 [21,  0.0],
                 [17,  1.3], [17,  0.5], [13,  0.5]]);
}

module spoke_ribs() {
  for (i = [0 : 2])
    translate([0, 0, -rib_h])
      sector(relief_ri - 1.5, relief_ro + 1.5,
             spoke_a[i] - spoke_w/2 + rib_inset,
             spoke_a[i] + spoke_w/2 - rib_inset, rib_h + 0.01);
}

/* ============================================================
   PART 2: flush mount
   ============================================================ */

module flange() {
  rotate_extrude()
    polygon([[0, 0], [flange_d/2, 0], [flange_d/2, flange_t_edge],
             [flange_taper, flange_t], [0, flange_t]]);
}

module base() {
  difference() {
    union() {
      flange();
      translate([0, 0, flange_t]) receiver_tube();
      translate([0, 0, comp_z - plate_t])      // solid carrier plate
        cylinder(d = sleeve_od, h = plate_t);
      // the clip goes into the union right away: otherwise it
      // fills the funnel again, which is only cut out after this
      translate([0, 0, comp_z]) rotate([180, 0, 0]) clip(hlk_l, hlk_w, hlk_h);
    }
    union() {
      translate([0, 0, flange_t]) receiver_bore(sleeve_id, recv_bottom, 0);
      translate([0, 0, flange_t]) bayonet_cuts(sleeve_od/2 + 1);
      translate([0, 0, flange_t]) tongue_cuts(sleeve_od/2 + 1);

      for (a = boss_a)                        // box lugs, full depth
        rotate([0, 0, a])
          translate([box_bore_d/2 - boss_protrude/2 + fit, 0, (comp_z - 4)/2])
            cube([boss_protrude + 2*fit + 4, boss_w + 2*fit,
                  abs(comp_z - 4)], center = true);

      for (x = [-box_screw_pitch/2, box_screw_pitch/2]) {
        hull() for (dx = [-1.5, 1.5])
          translate([x + dx, 0, -1])
            cylinder(d = box_screw_d + 0.6, h = flange_t + 2, $fn = 24);
        // flat counterbore, so the screw head lands on a flat face
        // and you do not have to pull it into the plastic
        hull() for (dx = [-1.5, 1.5])
          translate([x + dx, 0, flange_t - screw_cb_t])
            cylinder(d = screw_cb_d, h = screw_cb_t + 1, $fn = 32);
      }

      // NORTH: an opening right through, in which the WAGOs lie and
      // along which the installation wire runs. The bracket below
      // bridges it, so the stack reaches into the plate thickness.
      intersection() {
        // exactly as large as the stack itself; outside it the
        // plate stays, so the bracket has something to hold on to
        translate([0, (13.0 + 23.0)/2, comp_z - plate_t/2])
          cube([44, 23.0 - 13.0, plate_t + 2], center = true);
        // stay inside the plate edge
        translate([0, 0, comp_z - plate_t - 1])
          cylinder(r = 29.2, h = plate_t + 3);
      }
      // Opening above the supply, right through the plate, with a
      // funnel at the front so it leads itself in instead of
      // catching on the edge.
      hull() {
        translate([0, 0, comp_z - 0.01])
          cube([hlk_l + 2*clip_slack_l + 2*clip_lead,
                hlk_w + 2*clip_slack + 2*clip_lead, 0.02], center = true);
        translate([0, 0, comp_z - plate_t])
          cube([hlk_l + 2*clip_slack_l, hlk_w + 2*clip_slack, 0.02],
               center = true);
      }
      translate([0, 0, comp_z - plate_t - 1 + 1.01/2])
        cube([hlk_l + 2*clip_slack_l, hlk_w + 2*clip_slack, 1.01],
             center = true);

      // SOUTH: 5 V pass-through, on the side where the connector
      // sits on the PCB. Large enough for the 4-pin plug (about
      // 6.3 x 4.5, 7.7 across the diagonal), and far enough out
      // that the hole does not cut into the wall of the clip.
      translate([0, -18, comp_z - plate_t - 1])
        cylinder(d = jst_hole_d, h = plate_t + 2);


    }
  }
  /* "5V" raised on the front of the plate, left of the hole.
     Raised prints cleaner than engraved, and left because no rib
     of the cup runs over it there. */
  translate([label_pos[0] - 10*label_h/12, label_pos[1] - label_h/2, comp_z])
    linear_extrude(height = label_d) label_5v(label_h);

  /* Clamp for the two WAGOs: a bracket that presses the stack
     against the underside of the plate. Walls all round do not
     fit, because the stack already reaches 28.6 mm from the
     centre and the plate ends at 29.4. */
  wago_clamp();

  translate([0, 0, flange_t]) detents();
  /* The clip hangs below the solid plate. Push the supply in from
     below (from inside the box) until it is against the plate;
     the lips then click in behind its back. */
}

/* One bracket, across the middle of the WAGOs so it leaves the
   levers free. It runs through the opening in the plate: the top
   bar is level with the top face, so the stack ends up within
   the plate thickness instead of below it. */

module wago_clamp() {
  y0 = wago_y - wago_w/2 - wago_fit;
  y1 = wago_y + wago_w/2 + wago_fit;
  zt = comp_z - wago_bar;                       // top of the stack
  zb = zt - (wago_n * wago_h + wago_fit);       // bottom of the stack

  /* Top bar. On the inside it stops at the upright, so it does
     not reach into the opening above the supply; on the outside
     it continues into the plate. */
  yi = y0 - wago_web;
  yo = 24.5;   // into the plate, but inside the cut-out for the
               // box lugs, which starts at 25.3
  translate([0, (yi + yo)/2, comp_z - wago_bar/2])
    cube([wago_bw, yo - yi, wago_bar], center = true);

  // uprights at the sides
  for (sy = [-1, 1])
    translate([0, sy < 0 ? y0 - wago_web/2 : y1 + wago_web/2,
               (zt + zb - wago_bar)/2])
      cube([wago_bw, wago_web, zt - zb + wago_bar], center = true);

  // bottom bar
  translate([0, wago_y, zb - wago_bar/2])
    cube([wago_bw, (y1 - y0) + 2*wago_web, wago_bar], center = true);
}

/* ============================================================
   PART 3: desk stand
   ============================================================ */

// how high the receiver origin sits above the table, such that
// the lowest corner of the collar just stays clear
desk_rb = recv_bottom - desk_ring_ext;
desk_z  = collar_od/2 * sin(tilt) - desk_rb * cos(tilt) + 2;
desk_y = -4;

module desk_place() {
  translate([0, desk_y, desk_z]) rotate([-tilt, 0, 0]) children();
}

module foot_shape(inset) {
  linear_extrude(height = 0.1)
    offset(r = foot_r + inset)
      square([foot_x - 2*foot_r, foot_y - 2*foot_r], center = true);
}

/* Hollow skirt. No floor, no wall behind the cup and no cable
   channel: the back of the PCB is already in the cup, and you
   simply drop the USB plug in through the open bottom. At the
   bottom of the back wall sits a keyhole that just holds the
   cable, so the stand does not rock on it. */

module desk() {
  difference() {
    union() {
      difference() {
        hull() {                                   // outside
          foot_shape(0);
          desk_place() translate([0, 0, desk_rb])
            cylinder(d = collar_od, h = -desk_rb - 1);
        }
        hull() {                                   // cavity
          foot_shape(-skirt_wall);
          /* The cavity only starts BELOW the ring. Over the whole
             height of the bayonet the collar is therefore solid,
             and the skirt hangs all round from the lower edge of
             the ring. If the cavity ran up into the ring, the tilt
             would cut into it at an angle at the bottom, and the
             ring would hang on slivers once the insertion channels
             went through it. */
          desk_place() translate([0, 0, desk_rb - 0.2])
            cylinder(d = sleeve_id, h = 0.1);
        }
      }
      desk_place() receiver_tube(desk_rb);
    }
    union() {
      desk_place() receiver_bore(cup_od + 2*desk_fit, desk_rb);
      desk_place() bayonet_cuts(collar_od/2 + 1, desk_slack);
      desk_place() tongue_cuts(collar_od/2 + 1, desk_slack, desk_detent_side);

      // keyhole for the cable in the back wall
      translate([0, -20, cable_d/2 + 1.5])
        rotate([90, 0, 0]) cylinder(d = cable_d, h = 50, $fn = 32);
      translate([0, -45, (cable_d/2 + 1.5)/2])
        cube([cable_d - cable_pinch, 50, cable_d/2 + 1.5], center = true);

      translate([0, 0, -50]) cube([200, 200, 100], center = true);
    }
  }
  desk_place() detents(desk_slack, desk_detent_p, desk_detent_side);
}

/* ============================================================
   Reference and output
   ============================================================ */

module doos() {
  color("gray", 0.3) {
    difference() {
      union() {
        translate([0, 0, -box_depth]) cylinder(d = box_bore_d + 4, h = box_depth);
        translate([0, 0, -2]) cylinder(d = box_flange_d, h = 2);
      }
      translate([0, 0, -box_depth + 2]) cylinder(d = box_bore_d, h = box_depth);
      for (x = [-box_screw_pitch/2, box_screw_pitch/2])
        translate([x, 0, -3]) cylinder(d = box_screw_d, h = 6);
    }
    for (a = boss_a)
      rotate([0, 0, a])
        difference() {
          translate([box_bore_d/2 - boss_protrude/2, 0, -boss_h/2])
            cube([boss_protrude, boss_w, boss_h], center = true);
          translate([box_screw_pitch/2, 0, -boss_h - 1])
            cylinder(d = box_screw_d, h = boss_h + 2);
        }
  }
}

module half_cut() {
  if (cut)
    difference() { children(); translate([-100, 0, -100]) cube([200, 100, 200]); }
  else children();
}

module pcb() {
  color("green", 0.35) cylinder(d = cup_od, h = 1.6);
}

if (part == "doos") doos();
else if (part == "base") base();
else if (part == "cup")  cup();
else if (part == "desk") desk();
else if (part == "assy") half_cut() {
  union() {
    color("steelblue", 0.6) base();
    color("darkorange", 0.7)
      translate([0, 0, z_cup]) rotate([0, 0, turn]) cup();
  }
}
else half_cut() {
  union() {
    doos();
    color("steelblue", 0.6) base();
    color("darkorange", 0.7)
      translate([0, 0, z_cup]) rotate([0, 0, turn]) cup();
    translate([0, 0, z_cup + cup_h]) pcb();
    color("red", 0.3)
      translate([-hlk_l/2, -hlk_w/2, comp_z - plate_t - hlk_h])
        cube([hlk_l, hlk_w, hlk_h]);
  }
}
