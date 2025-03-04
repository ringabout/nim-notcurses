when (NimMajor, NimMinor) >= (1, 4):
  {.push raises: [].}
else:
  {.push raises: [Defect].}

import std/[sequtils, sets]
import ../../abi/constants/nckeys

type
  Key* = distinct uint32

  Keys* {.pure.} = enum
    Tab = Key(NCKEY_TAB)
    Esc = Key(NCKEY_ESC)
    Space = Key(NCKEY_SPACE)
    Invalid = Key(NCKEY_INVALID)
    Resize = Key(NCKEY_RESIZE)
    Up = Key(NCKEY_UP)
    Right = Key(NCKEY_RIGHT)
    Down = Key(NCKEY_DOWN)
    Left = Key(NCKEY_LEFT)
    Ins = Key(NCKEY_INS)
    Del = Key(NCKEY_DEL)
    Backspace = Key(NCKEY_BACKSPACE)
    PgDown = Key(NCKEY_PGDOWN)
    PgUp = Key(NCKEY_PGUP)
    Home = Key(NCKEY_HOME)
    End = Key(NCKEY_END)
    F00 = Key(NCKEY_F00)
    F01 = Key(NCKEY_F01)
    F02 = Key(NCKEY_F02)
    F03 = Key(NCKEY_F03)
    F04 = Key(NCKEY_F04)
    F05 = Key(NCKEY_F05)
    F06 = Key(NCKEY_F06)
    F07 = Key(NCKEY_F07)
    F08 = Key(NCKEY_F08)
    F09 = Key(NCKEY_F09)
    F10 = Key(NCKEY_F10)
    F11 = Key(NCKEY_F11)
    F12 = Key(NCKEY_F12)
    F13 = Key(NCKEY_F13)
    F14 = Key(NCKEY_F14)
    F15 = Key(NCKEY_F15)
    F16 = Key(NCKEY_F16)
    F17 = Key(NCKEY_F17)
    F18 = Key(NCKEY_F18)
    F19 = Key(NCKEY_F19)
    F20 = Key(NCKEY_F20)
    F21 = Key(NCKEY_F21)
    F22 = Key(NCKEY_F22)
    F23 = Key(NCKEY_F23)
    F24 = Key(NCKEY_F24)
    F25 = Key(NCKEY_F25)
    F26 = Key(NCKEY_F26)
    F27 = Key(NCKEY_F27)
    F28 = Key(NCKEY_F28)
    F29 = Key(NCKEY_F29)
    F30 = Key(NCKEY_F30)
    F31 = Key(NCKEY_F31)
    F32 = Key(NCKEY_F32)
    F33 = Key(NCKEY_F33)
    F34 = Key(NCKEY_F34)
    F35 = Key(NCKEY_F35)
    F36 = Key(NCKEY_F36)
    F37 = Key(NCKEY_F37)
    F38 = Key(NCKEY_F38)
    F39 = Key(NCKEY_F39)
    F40 = Key(NCKEY_F40)
    F41 = Key(NCKEY_F41)
    F42 = Key(NCKEY_F42)
    F43 = Key(NCKEY_F43)
    F44 = Key(NCKEY_F44)
    F45 = Key(NCKEY_F45)
    F46 = Key(NCKEY_F46)
    F47 = Key(NCKEY_F47)
    F48 = Key(NCKEY_F48)
    F49 = Key(NCKEY_F49)
    F50 = Key(NCKEY_F50)
    F51 = Key(NCKEY_F51)
    F52 = Key(NCKEY_F52)
    F53 = Key(NCKEY_F53)
    F54 = Key(NCKEY_F54)
    F55 = Key(NCKEY_F55)
    F56 = Key(NCKEY_F56)
    F57 = Key(NCKEY_F57)
    F58 = Key(NCKEY_F58)
    F59 = Key(NCKEY_F59)
    F60 = Key(NCKEY_F60)
    Enter = Key(NCKEY_ENTER)
    Cls = Key(NCKEY_CLS)
    DLeft = Key(NCKEY_DLEFT)
    DRight = Key(NCKEY_DRIGHT)
    ULeft = Key(NCKEY_ULEFT)
    URight = Key(NCKEY_URIGHT)
    Center = Key(NCKEY_CENTER)
    Begin = Key(NCKEY_BEGIN)
    Cancel = Key(NCKEY_CANCEL)
    Close = Key(NCKEY_CLOSE)
    Command = Key(NCKEY_COMMAND)
    Copy = Key(NCKEY_COPY)
    Exit = Key(NCKEY_EXIT)
    Print = Key(NCKEY_PRINT)
    Refresh = Key(NCKEY_REFRESH)
    Separator = Key(NCKEY_SEPARATOR)
    CapsLock = Key(NCKEY_CAPS_LOCK)
    ScrollLock = Key(NCKEY_SCROLL_LOCK)
    NumLock = Key(NCKEY_NUM_LOCK)
    PrintScreen = Key(NCKEY_PRINT_SCREEN)
    Pause = Key(NCKEY_PAUSE)
    Menu = Key(NCKEY_MENU)
    MediaPlay = Key(NCKEY_MEDIA_PLAY)
    MediaPause = Key(NCKEY_MEDIA_PAUSE)
    MediaPPause = Key(NCKEY_MEDIA_PPAUSE)
    MediaRev = Key(NCKEY_MEDIA_REV)
    MediaStop = Key(NCKEY_MEDIA_STOP)
    MediaFF = Key(NCKEY_MEDIA_FF)
    MediaRewind = Key(NCKEY_MEDIA_REWIND)
    MediaNext = Key(NCKEY_MEDIA_NEXT)
    MediaPrev = Key(NCKEY_MEDIA_PREV)
    MediaRecord = Key(NCKEY_MEDIA_RECORD)
    MediaLVol = Key(NCKEY_MEDIA_LVOL)
    MediaRVol = Key(NCKEY_MEDIA_RVOL)
    MediaMute = Key(NCKEY_MEDIA_MUTE)
    LShift = Key(NCKEY_LSHIFT)
    LCtrl = Key(NCKEY_LCTRL)
    LAlt = Key(NCKEY_LALT)
    LSuper = Key(NCKEY_LSUPER)
    LHyper = Key(NCKEY_LHYPER)
    LMeta = Key(NCKEY_LMETA)
    RShift = Key(NCKEY_RSHIFT)
    RCtrl = Key(NCKEY_RCTRL)
    RAlt = Key(NCKEY_RALT)
    RSuper = Key(NCKEY_RSUPER)
    RHyper = Key(NCKEY_RHYPER)
    RMeta = Key(NCKEY_RMETA)
    L3Shift = Key(NCKEY_L3SHIFT)
    L5Shift = Key(NCKEY_L5SHIFT)
    Motion = Key(NCKEY_MOTION)
    Button1 = Key(NCKEY_BUTTON1)
    Button2 = Key(NCKEY_BUTTON2)
    Button3 = Key(NCKEY_BUTTON3)
    Button4 = Key(NCKEY_BUTTON4)
    Button5 = Key(NCKEY_BUTTON5)
    Button6 = Key(NCKEY_BUTTON6)
    Button7 = Key(NCKEY_BUTTON7)
    Button8 = Key(NCKEY_BUTTON8)
    Button9 = Key(NCKEY_BUTTON9)
    Button10 = Key(NCKEY_BUTTON10)
    Button11 = Key(NCKEY_BUTTON11)
    Signal = Key(NCKEY_SIGNAL)
    EOF = Key(NCKEY_EOF)

type
  PseudoKeys[T: static Keys] = distinct Keys

converter toKeys*(key: PseudoKeys): Keys = Keys(key)
func `$`*(key: PseudoKeys[Button4]): string = "ScrollUp"
func `$`*(key: PseudoKeys[Button5]): string = "ScrollDown"
func `$`*(key: PseudoKeys[Enter]): string = "Return"
template ScrollUp*(_: typedesc[Keys]): auto = cast[PseudoKeys[Button4]](Button4)
template ScrollDown*(_: typedesc[Keys]): auto = cast[PseudoKeys[Button5]](Button5)
template Return*(_: typedesc[Keys]): auto = cast[PseudoKeys[Enter]](Enter)

const AllKeys* =
  toHashSet(
    @[Keys.Tab.uint32, Keys.Esc.uint32, Keys.Space.uint32] &
    toSeq((Keys.Invalid.uint32)..(Keys.EOF.uint32)).filterIt(
      (it <= Keys.F60.uint32) or
      (it >= Keys.Enter.uint32 and it <= Keys.Separator.uint32) or
      (it >= Keys.CapsLock.uint32 and it <= Keys.Menu.uint32) or
      (it >= Keys.MediaPlay.uint32 and it <= Keys.L5Shift.uint32) or
      (it >= Keys.Motion.uint32 and it <= Keys.Button11.uint32) or
      (it == Keys.Signal.uint32) or
      (it == Keys.EOF.uint32)))

type
  KeyModifier* = distinct uint32

  KeyModifiers* {.pure.} = enum
    Shift = KeyModifier(NCKEY_MOD_SHIFT)
    Alt = KeyModifier(NCKEY_MOD_ALT)
    Ctrl = KeyModifier(NCKEY_MOD_CTRL)
    Super = KeyModifier(NCKEY_MOD_SUPER)
    Hyper = KeyModifier(NCKEY_MOD_HYPER)
    Meta = KeyModifier(NCKEY_MOD_META)
    CapsLock = KeyModifier(NCKEY_MOD_CAPSLOCK)
    NumLock = KeyModifier(NCKEY_MOD_NUMLOCK)
