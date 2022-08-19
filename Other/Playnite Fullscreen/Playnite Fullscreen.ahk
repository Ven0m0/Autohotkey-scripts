; UIA check
if (!InStr(A_AhkPath, "_UIA.exe")) {
	newPath := RegExReplace(A_AhkPath, "\.exe", "U" (32 << A_Is64bitOS) "_UIA.exe")
	Run % StrReplace(DllCall("Kernel32\GetCommandLine", "Str"), A_AhkPath, newPath)
	ExitApp
}

#SingleInstance Force
#Warn  ; Enable warnings to assist with detecting common errors.
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#KeyHistory 0 
ListLines Off ; ListLines and #KeyHistory are functions used to "log your keys". Disable them as they're only useful for debugging purposes.
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0 ; Even though SendInput ignores SetKeyDelay, SetMouseDelay and SetDefaultMouseSpeed, having these delays at -1 improves SendEvent's speed just in case SendInput is not available and falls back to SendEvent.
SetWinDelay, -1
SetControlDelay, -1 ; SetWinDelay and SetControlDelay may affect performance depending on the script.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode, 3 ; Use SetTitleMatchMode 2 when you want to use wintitle that contains text anywhere in the title
SetTitleMatchMode, Fast

DllCall("SetCursorPos", "int", 0, "int", 1080)
RunWait, cmd.exe /c START "" "C:\Program Files\VideoLAN\VLC\vlc.exe" --fullscreen --video-on-top --play-and-exit --no-video-title -Idummy "%A_ScriptDir%\BootVideo.mp4",,hide
DllCall("kernel32.dll\Sleep", "UInt", 3000)
RunWait, cmd.exe /c runas /noprofile /user:janni /savecred "C:\Users\janni\OneDrive\Backup\Game\Other\Launchers\Playnite\Playnite.FullscreenApp.exe --hidesplashscreen",,hide
WinWait, ahk_exe Playnite.FullscreenApp.exe
WinActivate, ahk_exe Playnite.FullscreenApp.exe
#IfWinNotExist ahk_exe Playnite.FullscreenApp.exe
ExitApp