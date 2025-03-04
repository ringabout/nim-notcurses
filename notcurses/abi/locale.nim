# https://en.cppreference.com/w/c/locale/LC_categories
# https://en.cppreference.com/w/c/locale/setlocale

when (NimMajor, NimMinor) >= (1, 4):
  {.push raises: [].}
else:
  {.push raises: [Defect].}

const locale_header = "<locale.h>"

when defined(coverage):
  import std/macros
  import ./coverage
  macro locale(procedure: untyped): untyped =
    result = quote do:
      coverageWrapper(`procedure`, locale_header)
else:
  {.pragma: locale, cdecl, header: locale_header, importc.}

{.pragma: locale_const, header: locale_header, importc, nodecl.}

when (NimMajor, NimMinor) >= (1, 4):
  let
    LC_ALL* {.locale_const.}: cint
    LC_COLLATE* {.locale_const.}: cint
    LC_CTYPE* {.locale_const.}: cint
    LC_MONETARY* {.locale_const.}: cint
    LC_NUMERIC* {.locale_const.}: cint
    LC_TIME* {.locale_const.}: cint
  when defined(posix):
    let LC_MESSAGES* {.locale_const.}: cint
else:
  var
    LC_ALL* {.locale_const.}: cint
    LC_COLLATE* {.locale_const.}: cint
    LC_CTYPE* {.locale_const.}: cint
    LC_MONETARY* {.locale_const.}: cint
    LC_NUMERIC* {.locale_const.}: cint
    LC_TIME* {.locale_const.}: cint
  when defined(posix):
    var LC_MESSAGES* {.locale_const.}: cint

proc setlocale*(category: cint, locale: cstring): cstring {.locale.}
