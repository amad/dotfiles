import XMonad
import System.IO
import System.Exit
import XMonad.Config.Xfce
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.ToggleLayouts
import XMonad.Util.EZConfig(additionalKeys)

myBorderWidth = 2

--main = xmonad $ ewmh xfceConfig {
main = xmonad $ gnomeConfig {
    modMask = mod4Mask
  , borderWidth = 2
  , layoutHook = smartBorders $ toggleLayouts Full $ layoutHook gnomeConfig
  , terminal = "gnome-terminal"
  , startupHook = myStartupHook
  , focusFollowsMouse = False
} `additionalKeys`
    [
        ((mod4Mask .|. controlMask, xK_l), spawn "gnome-screensaver-command --lock")
      , ((mod4Mask, xK_f), sendMessage (Toggle "Full"))
    ]

myStartupHook = do
    spawn "xfce4-panel"
    spawn "syndaemon -i 1 -K -d"
    spawn "dropbox start"
    spawn "nm-applet &"
    spawn "synapse --startup"
    spawn "export _JAVA_AWT_WM_NONREPARENTING=1"
    spawn "xset r rate 200 45"
