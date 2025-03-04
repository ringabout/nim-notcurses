{.passL: "-lnotcurses-core".}

when (NimMajor, NimMinor) >= (1, 4):
  {.push raises: [].}
else:
  {.push raises: [Defect].}

import ./abi/impl as abi_impl
import ./api/impl

export impl

proc init*(T: typedesc[Notcurses], options = Options.init, file = stdout): T =
  T.init(notcurses_core_init, options, file)
