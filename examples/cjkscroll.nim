import std/os
import notcurses
# or: import notcurses/core
import notcurses/locale

# locale can be set manually but it's generally not necessary because Notcurses
# attempts to do it automatically; this is just an example of using setLocale
setLocale(LC_ALL, "").expect

# if locale was set manually then use option InhibitSetLocale
let
  opts = [CliMode, DrainInput, InhibitSetLocale]
  nc = Nc.init(NcOptions.init opts, addExitProc = false)
  stdn = nc.stdPlane

proc stop() {.noconv.} =
  stdn.putStr("\n\n").expect
  nc.stop
  quit(QuitSuccess)

setControlCHook(stop)

stdn.setStyles(Bold)
stdn.putStr("\nThis program is *not* indicative of real scrolling speed.\n\n").expect
stdn.setStyles(None)

# https://codepoints.net/cjk_unified_ideographs
const
  first = 0x4e00'u16
  last  = 0x9fff'u16

var u = first
while true:
  stdn.putWc(u.wchar).expect
  nc.render.expect
  if u < last: inc u
  else: u = first
  sleep 10

# rendering after each putWc() isn't necessary but it makes the auto-scroll
# behavior of Notcurses' CLI mode visually more apparent in the compiled
# program's output

# see comment in ./cli1.nim re: scrolling/rendering bugs
