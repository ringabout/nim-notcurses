# L[num] comments below pertain to sources for Notcurses v3.0.9
# https://github.com/dankamongmen/notcurses/tree/v3.0.9/include

# this module uses extra whitespace so it can be visually scanned more easily

when (NimMajor, NimMinor) >= (1, 4):
  {.push raises: [].}
else:
  {.push raises: [Defect].}

import std/[macros, posix]
import pkg/stew/endians2
import ./common
import ./constants

export Time, Timespec
export common except lib_notcurses_major, lib_notcurses_minor, lib_notcurses_patch, lib_notcurses_tweak
export constants except PRETERUNICODEBASE, nim_notcurses_version

const nc_header = "notcurses/notcurses.h"

when defined(coverage):
  import ./coverage
  macro nc(procedure: untyped): untyped =
    result = quote do:
      coverageWrapper(`procedure`, nc_header)
else:
  {.pragma: nc, cdecl, header: nc_header, importc.}

{.pragma: nc_bycopy, bycopy, header: nc_header.}
{.pragma: nc_incomplete, header: nc_header, incompleteStruct.}

type
  # L44 - notcurses/notcurses.h
  notcurses*       {.nc_incomplete, importc: "struct notcurses"      .} = object
  ncplane*         {.nc_incomplete, importc: "struct ncplane"        .} = object
  ncvisual*        {.nc_incomplete, importc: "struct ncvisual"       .} = object
  ncuplot*         {.nc_incomplete, importc: "struct ncuplot"        .} = object
  ncdplot*         {.nc_incomplete, importc: "struct ncdplot"        .} = object
  ncprogbar*       {.nc_incomplete, importc: "struct ncprogbar"      .} = object
  ncfdplane*       {.nc_incomplete, importc: "struct ncfdplane"      .} = object
  ncsubproc*       {.nc_incomplete, importc: "struct ncsubproc"      .} = object
  ncselector*      {.nc_incomplete, importc: "struct ncselector"     .} = object
  ncmultiselector* {.nc_incomplete, importc: "struct ncmultiselector".} = object
  ncreader*        {.nc_incomplete, importc: "struct ncreader"       .} = object
  ncfadectx*       {.nc_incomplete, importc: "struct ncfadectx"      .} = object
  nctablet*        {.nc_incomplete, importc: "struct nctablet"       .} = object
  ncreel*          {.nc_incomplete, importc: "struct ncreel"         .} = object
  nctab*           {.nc_incomplete, importc: "struct nctab"          .} = object
  nctabbed*        {.nc_incomplete, importc: "struct nctabbed"       .} = object

# L127 - notcurses/notcurses.h
macro NCCHANNEL_INITIALIZER*(r, g, b: cuint): uint32 =
  quote do:
    (`r` shl 16) + (`g` shl 8) + `b` + NC_BGDEFAULT_MASK.uint32

# L131 - notcurses/notcurses.h
macro NCCHANNELS_INITIALIZER*(fr, fg, fb, br, bg, bb: cuint): uint64 =
  quote do:
    let
      chan1 = NCCHANNEL_INITIALIZER(`fr`, `fg`, `fb`).uint64
      chan2 = NCCHANNEL_INITIALIZER(`br`, `bg`, `bb`).uint64
    (chan1 shl 32) + chan2

# L142 - notcurses/notcurses.h
proc ncchannel_alpha*(channel: uint32): cuint {.nc.}

# L150 - notcurses/notcurses.h
proc ncchannel_set_alpha*(channel: uint32, alpha: cuint): cint {.nc.}

# L163 - notcurses/notcurses.h
proc ncchannel_default_p*(channel: uint32): bool {.nc.}

# L169 - notcurses/notcurses.h
proc ncchannel_set_default*(channel: uint32): uint32 {.nc.}

# L177 - notcurses/notcurses.h
proc ncchannel_palindex_p*(channel: uint32): bool {.nc.}

# L184 - notcurses/notcurses.h
proc ncchannel_palindex*(channel: uint32): cuint {.nc.}

# L191 - notcurses/notcurses.h
proc ncchannel_set_palindex*(channel: ptr uint32, idx: cuint): cint {.nc.}

# L203 - notcurses/notcurses.h
proc ncchannel_rgb_p*(channel: uint32): bool {.nc.}

# L211 - notcurses/notcurses.h
proc ncchannel_r*(channel: uint32): cuint {.nc.}

# L218 - notcurses/notcurses.h
proc ncchannel_g*(channel: uint32): cuint {.nc.}

# L225 - notcurses/notcurses.h
proc ncchannel_b*(channel: uint32): cuint {.nc.}

# L232 - notcurses/notcurses.h
proc ncchannel_rgb*(channel: uint32): uint32 {.nc.}

# L239 - notcurses/notcurses.h
proc ncchannel_rgb8*(channel: uint32, r, g, b: ptr cuint): uint32 {.nc.}

# L251 - notcurses/notcurses.h
proc ncchannel_set_rgb8*(channel: ptr uint32, r, g, b: cuint): cint {.nc.}

# L264 - notcurses/notcurses.h
proc ncchannel_set*(channel: ptr uint32, rgb: uint32): cint {.nc.}

# L276 - notcurses/notcurses.h
proc ncchannel_set_rgb8_clipped*(channel: ptr uint32, r, g, b: cint) {.nc.}

# L302 - notcurses/notcurses.h
proc ncchannels_bchannel*(channels: uint64): uint32 {.nc.}

# L310 - notcurses/notcurses.h
proc ncchannels_fchannel*(channels: uint64): uint32 {.nc.}

# L316 - notcurses/notcurses.h
proc ncchannels_channels*(channels: uint64): uint64 {.nc.}

# L322 - notcurses/notcurses.h
proc ncchannels_bg_rgb_p*(channels: uint64): bool {.nc.}

# L327 - notcurses/notcurses.h
proc ncchannels_fg_rgb_p*(channels: uint64): bool {.nc.}

# L333 - notcurses/notcurses.h
proc ncchannels_bg_alpha*(channels: uint64): cuint {.nc.}

# L340 - notcurses/notcurses.h
proc ncchannels_set_bchannel*(channels: ptr uint64, channel: uint32): uint64 {.nc.}

# L350 - notcurses/notcurses.h
proc ncchannels_set_fchannel*(channels: ptr uint64, channel: uint32): uint64 {.nc.}

# L359 - notcurses/notcurses.h
proc ncchannels_set_channels*(dst: ptr uint64, channels: uint64): uint64 {.nc.}

# L367 - notcurses/notcurses.h
proc ncchannels_set_bg_alpha*(channels: ptr uint64, alpha: cuint): cint {.nc.}

# L381 - notcurses/notcurses.h
proc ncchannels_fg_alpha*(channels: uint64): cuint {.nc.}

# L387 - notcurses/notcurses.h
proc ncchannels_set_fg_alpha*(channels: ptr uint64, alpha: cuint): cint {.nc.}

# L401 - notcurses/notcurses.h
proc ncchannels_reverse*(channels: uint64): uint64 {.nc.}

# L424 - notcurses/notcurses.h
proc ncchannels_combine*(fchan: uint32, bchan: uint32): uint64 {.nc.}

# L432 - notcurses/notcurses.h
proc ncchannels_fg_palindex*(channels: uint64): cuint {.nc.}

# L437 - notcurses/notcurses.h
proc ncchannels_bg_palindex*(channels: uint64): cuint {.nc.}

# L443 - notcurses/notcurses.h
proc ncchannels_fg_rgb*(channels: uint64): uint32 {.nc.}

# L449 - notcurses/notcurses.h
proc ncchannels_bg_rgb*(channels: uint64): uint32 {.nc.}

# L455 - notcurses/notcurses.h
proc ncchannels_fg_rgb8*(channels: uint64, r, g, b: ptr cuint): uint32 {.nc.}

# L461 - notcurses/notcurses.h
proc ncchannels_bg_rgb8*(channels: uint64, r, g, b: ptr cuint): uint32 {.nc.}

# L468 - notcurses/notcurses.h
proc ncchannels_set_fg_rgb8*(channels: uint64, r, g, b: ptr cuint): cint {.nc.}

# L479 - notcurses/notcurses.h
proc ncchannels_set_fg_rgb8_clipped*(channels: ptr uint64, r, g, b: cint) {.nc.}

# L486 - notcurses/notcurses.h
proc ncchannels_set_fg_palindex*(channels: ptr uint64, idx: cuint): cint {.nc.}

# L497 - notcurses/notcurses.h
proc ncchannels_set_fg_rgb*(channels: ptr uint64, rgb: cuint): cint {.nc.}

# L509 - notcurses/notcurses.h
proc ncchannels_set_bg_rgb8*(channels: ptr uint64, r, g, b: cuint): cint {.nc.}

# L520 - notcurses/notcurses.h
proc ncchannels_set_bg_rgb8_clipped*(channels: ptr uint64, r, g, b: cint) {.nc.}

# L529 - notcurses/notcurses.h
proc ncchannels_set_bg_palindex*(channels: ptr uint64, idx: cuint): cint {.nc.}

# L540 - notcurses/notcurses.h
proc ncchannels_set_bg_rgb*(channels: ptr uint64, rgb: cuint): cint {.nc.}

# L551 - notcurses/notcurses.h
proc ncchannels_fg_default_p*(channels: uint64): bool {.nc.}

# L557 - notcurses/notcurses.h
proc ncchannels_fg_palindex_p*(channels: uint64): bool {.nc.}

# L565 - notcurses/notcurses.h
proc ncchannels_bg_default_p*(channels: uint64): bool {.nc.}

# L571 - notcurses/notcurses.h
proc ncchannels_bg_palindex_p*(channels: uint64): bool {.nc.}

# L577 - notcurses/notcurses.h
proc ncchannels_set_fg_default*(channels: ptr uint64): uint64 {.nc.}

# L586 - notcurses/notcurses.h
proc ncchannels_set_bg_default*(channels: ptr uint64): uint64 {.nc.}

# L601 - notcurses/notcurses.h
proc ncstrwidth*(egcs: cstring, validbytes, validwidth: ptr cint): cint {.nc.}

# L609 - notcurses/notcurses.h
proc notcurses_ucs32_to_utf8*(ucs32: ptr uint32, ucs32count: cuint, resultbuf: ptr UncheckedArray[cchar], buflen: csize_t): cint {.nc.}

# L724 - notcurses/notcurses.h
type nccell* {.nc_bycopy, importc: "struct nccell".} = object
  gcluster*         : uint32
  gcluster_backstop*: uint8
  width*            : uint8
  stylemask*        : uint16
  channels*         : uint64

# L731 - notcurses/notcurses.h
macro NCCELL_INITIALIZER*(c: uint32, s: uint16, chan: uint64): nccell =
  quote do:
    let
      gcluster = `c`.toLE
      wcw = `c`.wchar.wcwidth
      width = (if wcw <= 0: 1 else: wcw).uint8
    nccell(gcluster: gcluster, gcluster_backstop: 0, width: width, stylemask: `s`, channels: `chan`)

# L734 - notcurses/notcurses.h
macro NCCELL_CHAR_INITIALIZER*(c: cchar): nccell =
  quote do:
    let
      gcluster = `c`.uint32.toLE
      wcw = `c`.wchar.wcwidth
      width = (if wcw <= 0: 1 else: wcw).uint8
    nccell(gcluster: gcluster, gcluster_backstop: 0, width: width, stylemask: 0, channels: 0)

# L737 - notcurses/notcurses.h
template NCCELL_TRIVIAL_INITIALIZER*(): nccell =
  nccell(gcluster: 0, gcluster_backstop: 0, width: 1, stylemask: 0, channels: 0)

# L741 - notcurses/notcurses.h
proc nccell_init*(c: ptr nccell) {.nc.}

# L748 - notcurses/notcurses.h
proc nccell_load*(n: ptr ncplane, c: ptr nccell, gcluster: cstring): cint {.nc.}

# L752 - notcurses/notcursesh.
proc nccell_prime*(n: ptr ncplane, c: ptr nccell, gcluster: cstring, stylemask: uint16, channels: uint64): cint {.nc.}

# L762 - notcurses/notcurses.h
proc nccell_duplicate*(n: ptr ncplane, targ: ptr nccell, c: ptr nccell): cint {.nc.}

# L765 - notcurses/notcurses.h
proc nccell_release*(n: ptr ncplane, c: ptr nccell) {.nc.}

# L780 - notcurses/notcurses.h
proc nccell_set_styles*(c: ptr nccell, stylebits: cuint) {.nc.}

# L786 - notcurses/notcurses.h
proc nccell_styles*(c: ptr nccell): uint16 {.nc.}

# L793 - notcurses/notcurses.h
proc nccell_on_styles*(c: ptr nccell, stylebits: cuint) {.nc.}

# L799 - notcurses/notcurses.h
proc nccell_off_styles*(c: ptr nccell, stylebits: cuint) {.nc.}

# L805 - notcurses/notcurses.h
proc nccell_set_fg_default*(c: ptr nccell) {.nc.}

# L811 - notcurses/notcurses.h
proc nccell_set_bg_default*(c: ptr nccell) {.nc.}

# L816 - notcurses/notcurses.h
proc nccell_set_fg_alpha*(c: ptr nccell, alpha: cuint): cint {.nc.}

# L821 - notcurses/notcurses.h
proc nccell_set_bg_alpha*(c: ptr nccell, alpha: cuint): cint {.nc.}

# L826 - notcurses/notcurses.h
proc nccell_set_bchannel*(c: ptr nccell, channel: uint32): uint64 {.nc.}

# L831 - notcurses/notcurses.h
proc nccell_set_fchannel*(c: ptr nccell, channel: uint32): uint64 {.nc.}

# L836 - notcurses/notcurses.h
proc nccell_set_channels*(c: ptr nccell, channels: uint64): uint64 {.nc.}

# L842 - notcurses/notcurses.h
proc nccell_double_wide_p*(c: ptr nccell): bool {.nc.}

# L848 - notcurses/notcurses.h
proc nccell_wide_right_p*(c: ptr nccell): bool {.nc.}

# L854 - notcurses/notcurses.h
proc nccell_wide_left_p*(c: ptr nccell): bool {.nc.}

# L861 - notcurses/notcurses.h
proc nccell_extended_gcluster*(n: ptr ncplane, c: ptr nccell): cstring {.nc.}

# L864 - notcurses/notcurses.h
proc nccell_channels*(c: ptr nccell): uint64 {.nc.}

# L871 - notcurses/notcurses.h
proc nccell_bchannel*(cl: ptr nccell): uint32 {.nc.}

# L878 - notcurses/notcurses.h
proc nccell_fchannel*(cl: ptr nccell): uint32 {.nc.}

# L885 - notcurses/notcurses.h
proc nccell_cols*(c: ptr nccell): cuint {.nc.}

# L892 - notcurses/notcurses.h
proc nccell_strdup*(n: ptr ncplane, c: ptr nccell): cstring {.nc.}

# L898 - notcurses/notcurses.h
proc nccell_extract*(n: ptr ncplane, c: ptr nccell, stylemask: uint16, channels: uint64): cstring {.nc.}

# L915 - notcurses/notcurses.h
proc nccellcmp*(n1: ptr ncplane, c1: ptr nccell, n2: ptr ncplane, c2: ptr nccell): bool {.nc.}

# L929 - notcurses/notcurses.h
proc nccell_load_char*(n: ptr ncplane, c: ptr nccell, ch: cchar): cint {.nc.}

# L939 - notcurses/notcurses.h
proc nccell_load_egc32*(n: ptr ncplane, c: ptr nccell, egc: uint32): cint {.nc.}

# L950 - notcurses/notcurses.h
proc nccell_load_ucs32*(n: ptr ncplane, c: ptr nccell, u: uint32): cint {.nc.}

# L1060 - notcurses/notcurses.h
type notcurses_options* {.nc_bycopy, importc: "struct notcurses_options".} = object
  termtype*: cstring
  loglevel*: ncloglevel_e
  margin_t*: uint32
  margin_r*: uint32
  margin_b*: uint32
  margin_l*: uint32
  flags*   : uint64

# L1065 - notcurses/notcurses.h
proc notcurses_lex_margins*(op: cstring, opts: ptr notcurses_options): cint {.nc.}

# L1069 - notcurses/notcurses.h
proc notcurses_lex_blitter*(op: cstring, blitter: ptr ncblitter_e): cint {.nc.}

# L1073 - notcurses/notcurses.h
proc notcurses_str_blitter*(blitter: ncblitter_e): cstring {.nc.}

# L1077 - notcurses/notcurses.h
proc notcurses_lex_scalemode*(op: cstring, scalemode: ptr ncscale_e): cint {.nc.}

# L1081 - notcurses/notcurses.h
proc notcurses_str_scalemode*(scalemode: ncscale_e): cstring {.nc.}

# L1087 - notcurses/notcurses.h
proc notcurses_init*(opts: ptr notcurses_options, fp: File): ptr notcurses {.nc.}

# L1091 - notcurses/notcurses.h
proc notcurses_core_init*(opts: ptr notcurses_options, fp: File): ptr notcurses {.nc.}

# L1094 - notcurses/notcurses.h
proc notcurses_stop*(nc: ptr notcurses): cint {.nc.}

# L1100 - notcurses/notcurses.h
proc notcurses_enter_alternate_screen*(nc: ptr notcurses): cint {.nc.}

# L1105 - notcurses/notcurses.h
proc notcurses_leave_alternate_screen*(nc: ptr notcurses): cint {.nc.}

# L1111 - notcurses/notcurses.h
proc notcurses_stdplane*(nc: ptr notcurses): ptr ncplane {.nc.}

# L1113 - notcurses/notcurses.h
proc notcurses_stdplane_const*(nc: ptr notcurses): ptr ncplane {.nc.}

# L1117 - notcurses/notcurses.h
proc ncpile_top*(n: ptr ncplane): ptr ncplane {.nc.}

# L1121 - notcurses/notcurses.h
proc ncpile_bottom*(n: ptr ncplane): ptr ncplane {.nc.}

# L1126 - notcurses/notcurses.h
proc notcurses_top*(n: ptr notcurses): ptr ncplane {.nc.}

# L1132 - notcurses/notcurses.h
proc notcurses_bottom*(n: ptr notcurses): ptr ncplane {.nc.}

# L1138 - notcurses/notcurses.h
proc ncpile_render*(n: ptr ncplane): cint {.nc.}

# L1144 - notcurses/notcurses.h
proc ncpile_rasterize*(n: ptr ncplane): cint {.nc.}

# L1149 - notcurses/notcurses.h
proc notcurses_render*(nc: ptr notcurses): cint {.nc.}

# L1161 - notcurses/notcurses.h
proc ncpile_render_to_buffer*(p: ptr ncplane, buf: ptr cstring, buflen: ptr csize_t): cint {.nc.}

# L1166 - notcurses/notcurses.h
proc ncpile_render_to_file*(p: ptr ncplane, fp: File): cint {.nc.}

# L1170 - notcurses/notcurses.h
proc notcurses_drop_planes*(nc: ptr notcurses) {.nc.}

# L1190 - notcurses/notcurses.h
proc nckey_mouse_p*(r: uint32): bool {.nc.}

# L1217 - notcurses/notcurses.h
type ncinput* {.nc_bycopy, importc: "struct ncinput".} = object
  id*       : uint32
  y*        : int32
  x*        : int32
  utf8*     : array[5, char]
  alt*      : bool
  shift*    : bool
  ctrl*     : bool
  evtype*   : ncintype_e
  modifiers*: uint32
  ypx*      : int32
  xpx*      : int32

# L1220 - notcurses/notcurses.h
proc ncinput_shift_p*(n: ptr ncinput): bool {.nc.}

# L1225 - notcurses/notcurses.h
proc ncinput_ctrl_p*(ni: ptr ncinput): bool {.nc.}

# L1230 - notcurses/notcurses.h
proc ncinput_alt_p*(ni: ptr ncinput): bool {.nc.}

# L1235 - notcurses/notcurses.h
proc ncinput_meta_p*(ni: ptr ncinput): bool {.nc.}

# L1240 - notcurses/notcurses.h
proc ncinput_super_p*(ni: ptr ncinput): bool {.nc.}

# L1245 - notcurses/notcurses.h
proc ncinput_hyper_p*(ni: ptr ncinput): bool {.nc.}

# L1250 - notcurses/notcurses.h
proc ncinput_capslock_p*(ni: ptr ncinput): bool {.nc.}

# L1255 - notcurses/notcurses.h
proc ncinput_numlock_p*(ni: ptr ncinput): bool {.nc.}

# L1263 - notcurses/notcurses.h
proc ncinput_equal_p*(n1: ptr ncinput, n2: ptr ncinput): bool {.nc.}

# L1294 - notcurses/notcurses.h
proc notcurses_get*(n: ptr notcurses, ts: ptr Timespec, ni: ptr ncinput): uint32 {.nc.}

# L1300 - notcurses/notcurses.h
proc notcurses_getvec*(n: ptr notcurses, ts: ptr Timespec, ni: ptr ncinput, vcount: cint): cint {.nc.}

# L1308 - notcurses/notcurses.h
proc notcurses_inputready_fd*(n: ptr notcurses): cint {.nc.}

# L1314 - notcurses/notcurses.h
proc notcurses_get_nblock*(n: ptr notcurses, ni: ptr ncinput): uint32 {.nc.}

# L1322 - notcurses/notcurses.h
proc notcurses_get_blocking*(n: ptr notcurses, ni: ptr ncinput): uint32 {.nc.}

# L1328 - notcurses/notcurses.h
proc ncinput_nomod_p*(ni: ptr ncinput): bool {.nc.}

# L1341 - notcurses/notcurses.h
proc notcurses_mice_enable*(n: ptr notcurses, eventmask: cuint): cint {.nc.}

# L1346 - notcurses/notcurses.h
proc notcurses_mice_disable*(n: ptr notcurses): cint {.nc.}

# L1352 - notcurses/notcurses.h
proc notcurses_linesigs_disable*(n: ptr notcurses): cint {.nc.}

# L1357 - notcurses/notcurses.h
proc notcurses_linesigs_enable*(n: ptr notcurses): cint {.nc.}

# L1365 - notcurses/notcurses.h
proc notcurses_refresh*(n: ptr notcurses, y, x: cuint): cint {.nc.}

# L1369 - notcurses/notcurses.h
proc ncplane_notcurses*(n: ptr ncplane): ptr notcurses {.nc.}

# L1372 - notcurses/notcurses.h
proc ncplane_notcurses_const*(n: ptr ncplane): ptr notcurses {.nc.}

# L1376 - notcurses/notcurses.h
proc ncplane_dim_yx*(n: ptr ncplane, y, x: ptr cuint) {.nc.}

# see: https://github.com/dankamongmen/notcurses/issues/2710
#
# # L1382 - notcurses/notcurses.h
# proc notcurses_stdplane*(nc: ptr notcurses): ptr ncplane {.nc.}
#
# # L1383 - notcurses/notcurses.h
# proc notcurses_stdplane_const*(nc: ptr notcurses): ptr ncplane {.nc.}

# L1387 - notcurses/notcurses.h
proc notcurses_stddim_yx*(nc: ptr notcurses, y, x: ptr cuint): ptr ncplane {.nc.}

# L1394 - notcurses/notcurses.h
proc notcurses_stddim_yx_const*(nc: ptr notcurses, y, x: ptr cuint): ptr ncplane {.nc.}

# L1401 - notcurses/notcurses.h
proc ncplane_dim_y*(n: ptr ncplane): cuint {.nc.}

# L1408 - notcurses/notcurses.h
proc ncplane_dim_x*(n: ptr ncplane): cuint {.nc.}

# L1419 - notcurses/notcurses.h
proc ncplane_pixel_geom*(n: ptr ncplane, pxy, pxx, celldimy, celldimx, maxbmapy, maxbmapx: ptr cuint) {.nc.}

# L1427 - notcurses/notcurses.h
proc notcurses_term_dim_yx*(n: ptr notcurses, rows, cols: ptr cuint) {.nc.}

# L1434 - notcurses/notcurses.h
proc notcurses_at_yx*(nc: ptr notcurses, yoff, xoff: cuint, stylemask: ptr uint16, channels: ptr uint64): cstring {.nc.}

# L1472 -  notcurses/notcurses.h
type ncplane_options* {.nc_bycopy, importc: "struct ncplane_options".} = object
  y*       : int32
  x*       : int32
  rows*    : uint32
  cols*    : uint32
  userptr* : pointer
  name*    : cstring
  resizecb*: proc (n: ptr ncplane): int32 {.noconv.}
  flags*   : uint64
  margin_b*: uint32
  margin_r*: uint32

# L1479 - notcurses/notcurses.h
proc ncplane_create*(n: ptr ncplane, nopts: ptr ncplane_options): ptr ncplane {.nc.}

# L1484 - notcurses/notcurses.h
proc ncpile_create*(nc: ptr notcurses, nopts: ptr ncplane_options): ptr ncplane {.nc.}

# L1492 - notcurses/notcurses.h
proc ncplane_resize_maximize*(n: ptr ncplane): cint {.nc.}

# L1496 - notcurses/notcurses.h
proc ncplane_resize_marginalized*(n: ptr ncplane): cint {.nc.}

# L1500 - notcurses/notcurses.h
proc ncplane_resize_realign*(n: ptr ncplane): cint {.nc.}

# L1504 - notcurses/notcurses.h
proc ncplane_resize_placewithin*(n: ptr ncplane): cint {.nc.}

# L1508 - notcurses/notcurses.h
proc ncplane_set_resizecb*(n: ptr ncplane, resizecb: proc (n: ptr ncplane): cint {.noconv.}) {.nc.}

# L1511 - notcurses/notcurses.h
proc ncplane_resizecb*(n: ptr ncplane): proc (n: ptr ncplane): cint {.noconv.} {.nc.}

# L1514 - notcurses/notcurses.h
proc ncplane_set_name*(n: ptr ncplane, name: cstring): cint {.nc.}

# L1518 - notcurses/notcurses.h
proc ncplane_name*(n: ptr ncplane): cstring {.nc.}

# L1527 - notcurses/notcurses.h
proc ncplane_reparent*(n: ptr ncplane, newparent: ptr ncplane): ptr ncplane {.nc.}

# L1533 - notcurses/notcurses.h
proc ncplane_reparent_family*(n: ptr ncplane, newparent: ptr ncplane): ptr ncplane {.nc.}

# L1542 - notcurses/notcurses.h
proc ncplane_dup*(n: ptr ncplane, opaque: pointer): ptr ncplane {.nc.}

# L1548 - notcurses/notcurses.h
proc ncplane_translate*(src, dst: ptr ncplane, y, x: ptr cint) {.nc.}

# L1556 - notcurses/notcurses.h
proc ncplane_translate_abs*(n: ptr ncplane, y, x: ptr cint): bool {.nc.}

# L1562 - notcurses/notcurses.h
proc ncplane_set_scrolling*(n: ptr ncplane, scrollp: cuint): bool {.nc.}

# L1565 - notcurses/notcurses.h
proc ncplane_scrolling_p*(n: ptr ncplane): bool {.nc.}

# L1571 - notcurses/notcurses.h
proc ncplane_set_autogrow*(n: ptr ncplane, growp: cuint): bool {.nc.}

# L1574 - notcurses/notcurses.h
proc ncplane_autogrow_p*(n: ptr ncplane): bool {.nc.}

# L1584 -  notcurses/notcurses.h
type ncpalette* {.nc_bycopy, importc: "struct ncpalette".} = object
  chans*: array[NCPALETTESIZE, uint32]

# L1588 - notcurses/notcurses.h
proc ncpalette_new*(nc: ptr notcurses): ptr ncpalette {.nc.}

# L1593 - notcurses/notcurses.h
proc ncpalette_use*(nc: ptr notcurses, p: ptr ncpalette): cint {.nc.}

# L1598 - notcurses/notcurses.h
proc ncpalette_set_rgb8*(p: ptr ncpalette, idx: cint, r, g, b: cuint): cint {.nc.}

# L1606 - notcurses/notcurses.h
proc ncpalette_set*(p: ptr ncpalette, idx: cint, rgb: cuint): cint {.nc.}

# L1614 - notcurses/notcurses.h
proc ncpalette_get*(p: ptr ncpalette, idx: cint, palent: ptr uint32): cint {.nc.}

# L1623 - notcurses/notcurses.h
proc ncpalette_get_rgb8*(p: ptr ncpalette, idx: cint, r, g, b: ptr cuint): cint {.nc.}

# L1631 - notcurses/notcurses.h
proc ncpalette_free*(p: ptr ncpalette) {.nc.}

# L1644 - notcurses/notcurses.h
type nccapabilities* {.nc_bycopy, importc: "struct nccapabilities".} = object
  colors*           : cuint
  utf8*             : bool
  rgb*              : bool
  can_change_colors*: bool
  halfblocks*       : bool
  quadrants*        : bool
  sextants*         : bool
  braille*          : bool

# L1650 - notcurses/notcurses.h
proc notcurses_supported_styles*(nc: ptr notcurses): uint16 {.nc.}

# L1656 - notcurses/notcurses.h
proc notcurses_palette_size*(nc: ptr notcurses): cuint {.nc.}

# L1661 - notcurses/notcurses.h
proc notcurses_detected_terminal*(nc: ptr notcurses): cstring {.nc.}

# L1664 - notcurses/notcurses.h
proc notcurses_capabilities*(n: ptr notcurses): ptr nccapabilities {.nc.}

# L1690 - notcurses/notcurses.h
proc notcurses_check_pixel_support*(nc: ptr notcurses): ncpixelimpl_e {.nc.}

# L1697 - notcurses/notcurses.h
proc nccapability_canchangecolor*(caps: ptr nccapabilities): bool {.nc.}

# L1710 - notcurses/notcurses.h
proc notcurses_cantruecolor*(nc: ptr notcurses): bool {.nc.}

# L1716 - notcurses/notcurses.h
proc notcurses_canchangecolor*(nc: ptr notcurses): bool {.nc.}

# L1722 - notcurses/notcurses.h
proc notcurses_canfade*(n: ptr notcurses): bool {.nc.}

# L1727 - notcurses/notcurses.h
proc notcurses_canopen_images*(nc: ptr notcurses): bool {.nc.}

# L1731 - notcurses/notcurses.h
proc notcurses_canopen_videos*(nc: ptr notcurses): bool {.nc.}

# L1736 - notcurses/notcurses.h
proc notcurses_canutf8*(nc: ptr notcurses): bool {.nc.}

# L1742 - notcurses/notcurses.h
proc notcurses_canhalfblock*(nc: ptr notcurses): bool {.nc.}

# L1748 - notcurses/notcurses.h
proc notcurses_canquadrant*(nc: ptr notcurses): bool {.nc.}

# L1754 - notcurses/notcurses.h
proc notcurses_cansextant*(nc: ptr notcurses): bool {.nc.}

# L1760 - notcurses/notcurses.h
proc notcurses_canbraille*(nc: ptr notcurses): bool {.nc.}

# L1766 - notcurses/notcurses.h
proc notcurses_canpixel*(nc: ptr notcurses): bool {.nc.}

# L1812 - notcurses/notcurses.h
type ncstats* {.nc_bycopy, importc: "struct ncstats".} = object
  renders*          : uint64
  writeouts*        : uint64
  failed_renders*   : uint64
  failed_writeouts* : uint64
  raster_bytes*     : uint64
  raster_max_bytes* : int64
  raster_min_bytes* : int64
  render_ns*        : uint64
  render_max_ns*    : int64
  render_min_ns*    : int64
  raster_ns*        : uint64
  raster_max_ns*    : int64
  raster_min_ns*    : int64
  writeout_ns*      : uint64
  writeout_max_ns*  : int64
  writeout_min_ns*  : int64
  cellelisions*     : uint64
  cellemissions*    : uint64
  fgelisions*       : uint64
  fgemissions*      : uint64
  bgelisions*       : uint64
  bgemissions*      : uint64
  defaultelisions*  : uint64
  defaultemissions* : uint64
  refreshes*        : uint64
  sprixelemissions* : uint64
  sprixelelisions*  : uint64
  sprixelbytes*     : uint64
  appsync_updates*  : uint64
  input_errors*     : uint64
  input_events*     : uint64
  hpa_gratuitous*   : uint64
  cell_geo_changes* : uint64
  pixel_geo_changes*: uint64
  fbbytes*          : uint64
  planes*           : uint32

# L1816 - notcurses/notcurses.h
proc notcurses_stats_alloc*(nc: ptr notcurses): ptr ncstats {.nc.}

# L1821 - notcurses/notcurses.h
proc notcurses_stats*(nc: ptr notcurses, stats: ptr ncstats) {.nc.}

# L1826 - notcurses/notcurses.h
proc notcurses_stats_reset*(nc: ptr notcurses, stats: ptr ncstats) {.nc.}

# L1843 - notcurses/notcurses.h
proc ncplane_resize*(n: ptr ncplane, keepy, keepx: cint, keepleny, keeplenx: cuint, yoff, xoff: cint, ylen, xlen: cuint): cint {.nc.}

# L1851 - notcurses/notcurses.h
proc ncplane_resize_simple*(n: ptr ncplane, ylen, xlen: cuint): cint {.nc.}

# L1862 - notcurses/notcurses.h
proc ncplane_destroy*(n: ptr ncplane): cint {.nc.}

# L1868 - notcurses/notcurses.h
proc ncplane_set_base_cell*(n: ptr ncplane, c: ptr nccell): cint {.nc.}

# L1874 - notcurses/notcurses.h
proc ncplane_set_base*(n: ptr ncplane, egc: cstring, stylemask: uint16, channels: uint64): cint {.nc.}

# L1879 - notcurses/notcurses.h
proc ncplane_base*(n: ptr ncplane, c: ptr nccell): cint {.nc.}

# L... - notcurses/notcurses.h
# ...

# L2133 - notcurses/notcurses.h
proc ncplane_cursor_y*(n: ptr ncplane): cuint {.nc.}

# L2264 - notcurses/notcurses.h
proc ncplane_putstr_yx*(n: ptr ncplane, y, x: cint, gclusters: cstring): cint {.nc.}

# L2287 - notcurses/notcurses.h
proc ncplane_putstr*(n: ptr ncplane, gclustarr: cstring): cint {.nc.}

# L2292 - notcurses/notcurses.h
proc ncplane_putstr_aligned*(n: ptr ncplane, y: cint, align: ncalign_e, s: cstring): cint {.nc.}

# L2433 - notcurses/notcurses.h
proc ncplane_putwc*(n: ptr ncplane, w: Wchar): cint {.nc.}

# L2680 - notcurses/notcurses.h
proc ncplane_gradient*(n: ptr ncplane, y, x: cint, ylen, xlen: cuint, egc: cstring, styles: uint16, ul, ur, ll, lr: uint64): cint {.nc.}

# L2689 - notcurses/notcurses.h
proc ncplane_gradient2x1*(n: ptr ncplane, y, x: cint, ylen, xlen: cuint, ul, ur, ll, lr: uint32): cint {.nc.}

# L2927 - notcurses/notcurses.h
proc ncplane_set_styles*(n: ptr ncplane, stylebits: cuint) {.nc.}

# L3000 - notcurses/notcurses.h
proc ncplane_set_fg_rgb*(n: ptr ncplane, channel: uint32): cint {.nc.}

# L3001 - notcurses/notcurses.h
proc ncplane_set_bg_rgb*(n: ptr ncplane, channel: uint32): cint {.nc.}

# L3257 - notcurses/notcurses.h
proc ncvisual_from_file*(file: cstring): ptr ncvisual {.nc.}

# L3324 - notcurses/notcurses.h
type ncvisual_options* {.nc_bycopy, importc: "struct ncvisual_options".} = object
  n*         : ptr ncplane
  scaling*   : ncscale_e
  y*         : int32
  x*         : int32
  begy*      : uint32
  begx*      : uint32
  leny*      : uint32
  lenx*      : uint32
  blitter*   : ncblitter_e
  flags*     : uint64
  transcolor*: uint32
  pxoffy*    : uint32
  pxoffx*    : uint32

# L3453 - notcurses/notcurses.h
proc ncvisual_blit*(nc: ptr notcurses, ncv: ptr ncvisual, vopts: ptr ncvisual_options): ptr ncplane {.nc.}

type
  # L3946 - notcurses/notcurses.h
  ncmselector_item* {.nc_bycopy, importc: "struct ncmselector_item".} = object
    option*  : cstring
    desc*    : cstring
    selected*: bool

  # L3987 - notcurses/notcurses.h
  ncmultiselector_options* {.nc_bycopy, importc: "struct ncmultiselector_options".} = object
    title*        : cstring
    secondary*    : cstring
    footer*       : cstring
    items*        : ptr UncheckedArray[ncmselector_item]
    maxdisplay*   : uint32
    opchannels*   : uint64
    descchannels* : uint64
    titlechannels*: uint64
    footchannels* : uint64
    boxchannels*  : uint64
    flags*        : uint64

# L3989 - notcurses/notcurses.h
proc ncmultiselector_create*(n: ptr ncplane, opts: ptr ncmultiselector_options): ptr ncmultiselector {.nc.}

# L4006 - notcurses/notcurses.h
proc ncmultiselector_offer_input*(n: ptr ncmultiselector, ni: ptr ncinput): bool {.nc.}

# L4010 - notcurses/notcurses.h
proc ncmultiselector_destroy*(n: ptr ncmultiselector) {.nc.}
