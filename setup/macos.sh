#!/bin/sh

sudo -v

# UI/UX {{{1
#

# menu: no transparency
defaults write com.apple.universalaccess reduceTransparency -bool true

# Highlight color
defaults write NSGlobalDomain AppleHighlightColor -string "0.752941 0.964706 0.678431"

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1



# Input devices {{{1
#

# Fast keyboard
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Enable full keyboard access for all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3


# Language, formats, etc {{{1
#

defaults write NSGlobalDomain AppleLanguages -array "en-EE" "et-EE"
defaults write NSGlobalDomain AppleLocale -string "en_EE"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true
sudo systemsetup -settimezone "Europe/Tallinn" > /dev/null


# Screen {{{1
#

# Screenshots
defaults write com.apple.screencapture location -string "${HOME}/Downloads"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2


# Finder {{{1
#

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true


# Dock, Dashboard {{{1
#

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 64

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Dock auto-hiding
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Enable the 2D Dock
defaults write com.apple.dock no-glass -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true


# Spotlight {{{1
#

# Hide Spotlight tray-icon (and subsequent helper)
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# Change indexing order and disable some file types
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "CONTACT";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "SOURCE";}' \
  '{"enabled" = 0;"name" = "FONTS";}'

# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null


# Transmission.app {{{1
#

# Use `~/Documents` to store incomplete downloads
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads"

# Don’t prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool false

# Trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# Hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false
# Hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false


# Divvy.app {{{1
#

open "divvy://import/" \
  "YnBsaXN0MDDUAQIDBAUIwsNUJHRvcFgkb2JqZWN0c1gkdmVyc2lvblkkYXJjaGl2ZXLR" \
  "BgdUcm9vdIABrxAcCQofNzg/SUpSU1pbY2RsbXV2fn+Hj5efp6+2vlUkbnVsbNILDA0O" \
  "ViRjbGFzc1pOUy5vYmplY3RzgBuvEBAPEBESExQVFhcYGRobHB0egAKABYAHgAmAC4AN" \
  "gA+AEYATgBSAFYAWgBeAGIAZgBrdICEiIyQlJicoKSorCywtLi8wLTEyMy81MTZfEBJz" \
  "ZWxlY3Rpb25FbmRDb2x1bW5fEBFzZWxlY3Rpb25TdGFydFJvd1xrZXlDb21ib0NvZGVX" \
  "ZW5hYmxlZF1rZXlDb21ib0ZsYWdzXxAUc2VsZWN0aW9uU3RhcnRDb2x1bW5bc2l6ZUNv" \
  "bHVtbnNac3ViZGl2aWRlZFduYW1lS2V5Vmdsb2JhbF8QD3NlbGVjdGlvbkVuZFJvd1hz" \
  "aXplUm93cxABEAAQBAkSAAwAABAGCIADCRAFgARaTGVmdCB0aGlyZNI5Ojs+WCRjbGFz" \
  "c2VzWiRjbGFzc25hbWWiPD1YU2hvcnRjdXRYTlNPYmplY3RYU2hvcnRjdXTdICEiIyQl" \
  "JicoKSorC0AtQS9DRDEyRi81MTYQAxAuCRIADAAAEAIIgAYJgARcQ2VudGVyIHRoaXJk" \
  "3SAhIiMkJSYnKCkqKws1LUsvTS4xMk8vNTE2ECUJEgAMAAAIgAgJgARbUmlnaHQgdGhp" \
  "cmTdICEiIyQlJicoKSorC0QtLi9VLTEyVy81MTYJEgAUAAAIgAoJgARZTGVmdCBoYWxm" \
  "3SAhIiMkJSYnKCkqKws1LVwvXkAxMmAvNTE2ECUJEgAUAAAIgAwJgARaUmlnaHQgaGFs" \
  "Zt0gISIjJCUmJygpKisLNS1lL2ctMTJpL0QxNhAoCRIAFAAACIAOCYAEWFRvcCBoYWxm" \
  "3SAhIiMkJSYnKCkqKws1QG4vcC0xMnIvNTE2ECYJEgAUAAAIgBAJgARbQm90dG9tIGhh" \
  "bGbdICEiIyQlJicoKSorCywtdy95LTEyey9EMTYQWQkSAAwAAAiAEgmABFDdICEiIyQl" \
  "JicoKSorC0AtgC+CRDEyey9EMTYQWwkSAAwAAAiAEgmABN0gISIjJCUmJygpKisLNS2I" \
  "L4ouMTJ7L0QxNhBcCRIADAAACIASCYAE3SAhIiMkJSYnKCkqKwssQJAvki0xMnsvNTE2" \
  "EFMJEgAMAAAIgBIJgATdICEiIyQlJicoKSorC0BAmC+aRDEyey81MTYQVAkSAAwAAAiA" \
  "EgmABN0gISIjJCUmJygpKisLNUCgL6IuMTJ7LzUxNhBVCRIADAAACIASCYAE3SAhIiMk" \
  "JSYnKCkqKws1LagvqkQxMnsvNTE2ECUJEgAcAAAIgBIJgATdICEiIyQlJicoKSorC0At" \
  "Li+xLTEyey81MTYJEgAcAAAIgBIJgATdICEiIyQlJicoKSorC0BEty+5RDEyey9AMTYQ" \
  "VwkSAAwAAAiAEgmABNI5Or/Ao8DBPV5OU011dGFibGVBcnJheVdOU0FycmF5EgABhqBf" \
  "EA9OU0tleWVkQXJjaGl2ZXIACAARABYAHwAoADIANQA6ADwAWwBhAGYAbQB4AHoAjQCP" \
  "AJEAkwCVAJcAmQCbAJ0AnwChAKMApQCnAKkAqwCtAMgA3QDxAP4BBgEUASsBNwFCAUoB" \
  "UQFjAWwBbgFwAXIBcwF4AXoBewF9AX4BgAGCAY0BkgGbAaYBqQGyAbsBxAHfAeEB4wHk" \
  "AekB6wHsAe4B7wHxAf4CGQIbAhwCIQIiAiQCJQInAjMCTgJPAlQCVQJXAlgCWgJkAn8C" \
  "gQKCAocCiAKKAosCjQKYArMCtQK2ArsCvAK+Ar8CwQLKAuUC5wLoAu0C7gLwAvEC8wL/" \
  "AxoDHAMdAyIDIwMlAyYDKAMpA0QDRgNHA0wDTQNPA1ADUgNtA28DcAN1A3YDeAN5A3sD" \
  "lgOYA5kDngOfA6EDogOkA78DwQPCA8cDyAPKA8sDzQPoA+oD6wPwA/ED8wP0A/YEEQQT" \
  "BBQEGQQaBBwEHQQfBDoEOwRABEEEQwREBEYEYQRjBGQEaQRqBGwEbQRvBHQEeASHBI8E" \
  "lAAAAAAAAAIBAAAAAAAAAMQAAAAAAAAAAAAAAAAAAASm"