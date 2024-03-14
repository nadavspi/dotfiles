#!/bin/bash

## Dock
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "tilesize" -int "54"
defaults write com.apple.dock "show-recents" -bool "false"
# don't rearrange spaces
defaults write com.apple.dock "mru-spaces" -bool "false" 
defaults write NSGlobalDomain "AppleSpacesSwitchOnActivate" -bool "false" 
# empty dock except for open apps
defaults write com.apple.dock "static-only" -bool "true" 
defaults write com.apple.finder "ShowPathbar" -bool "true"
killall Dock

## Finder
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"
# no icons on desktop
defaults write com.apple.finder "CreateDesktop" -bool "false" 
defaults write com.apple.finder "AppleShowAllFiles" -bool "true" 
# search current folder by default
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf" 
killall Finder
