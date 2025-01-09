#!/bin/zsh

# Dock
domain="com.apple.dock"
# Dock
defaults write ${domain} orientation -string "left"
# Dock が表示されるまでの待ち時間を無効化
defaults write ${domain} autohide-delay -float 0
# "自動的に非表示"をオン
defaults write ${domain} autohide -bool true

# Bluetooth
domain="com.apple.BluetoothAudioAgent"
# Bluetooth ヘッドフォン・ヘッドセットの音質を向上させる
defaults write ${domain} "Apple Bitpool Min (editable)" -int 40

# キーボード
domain="NSGlobalDomain"
# キーのリピート
defaults write ${domain} KeyRepeat -int 2
# リピート入力認識までの時間
defaults write ${domain} InitialKeyRepeat -int 15
# コントロール間のフォーカス移動をキーボードで操作
defaults write ${domain} AppleKeyboardUIMode -int 2
domain="com.apple.symbolichotkeys"
# 前の入力ソースを選択:[command] + [space]
defaults write ${domain} AppleSymbolicHotKeys -dict-add 60 "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>"
# 入力メニューの次のソースを選択
defaults write ${domain} AppleSymbolicHotKeys -dict-add 61 "<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1572864</integer></array><key>type</key><string>standard</string></dict></dict>"
# Spotlight検索を表示
defaults write ${domain} AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>"
# Finderの検索ウインドウを表示
defaults write ${domain} AppleSymbolicHotKeys -dict-add 65 "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>1572864</integer></array><key>type</key><string>standard</string></dict></dict>"

# マウス
domain="NSGlobalDomain"
defaults write ${domain} com.apple.mouse.scaling -float 1
defaults write ${domain} com.apple.scrollwheel.scaling -float 0.75

# 日付と時刻
domain="com.apple.menuextra.clock"
defaults write ${domain} DateFormat -string 'M月d日(EEE)  H:mm:ss'

# Desktop Service
domain="com.apple.desktopservices"
# ネットワークストレージに .DS_Store ファイルを作成しない
defaults write ${domain} DSDontWriteNetworkStores -bool true
# USBメモリに .DS_Store ファイルを作成しない
defaults write ${domain} DSDontWriteUSBStores -bool true

# Finder
# ~/Library ディレクトリの表示
chflags nohidden ~/Library
domain="NSGlobalDomain"
# 全ての拡張子のファイルを表示
defaults write ${domain} AppleShowAllExtensions -bool true
domain="com.apple.finder"
# デスクトップに表示する項目: ハードディスク
defaults write ${domain} ShowHardDrivesOnDesktop -bool true
# 新規ウインドウをownCloudにする
defaults write ${domain} NewWindowTarget -string "PfLo"
defaults write ${domain} NewWindowTargetPath -string "file://${HOME}/ownCloud/"
# 検索時にデフォルトでカレントディレクトリを検索
defaults write ${domain} FXDefaultSearchScope -string "SCcf"
# 拡張子変更時の警告を無効化
defaults write ${domain} FXEnableExtensionChangeWarning -bool false
# クイックルックでテキストを選択可能にする
defaults write ${domain} QLEnableTextSelection -bool true
# ステータスバーを表示
defaults write ${domain} ShowStatusBar -bool true
# ステータスバーを表示
defaults write ${domain} ShowSideBar -bool true
# iCloud Driveから削除する前に警告を表示
defaults write ${domain} FXEnableRemoveFromICloudDriveWarning -bool false
# ゴミ箱を空にする前の警告を無効化
defaults write ${domain} WarnOnEmptyTrash -bool false
# カラム表示にする
defaults write ${domain} FXPreferredViewStyle -string "clmv"
# Desktopアイコンを名前順に表示
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy name" ${HOME}/Library/Preferences/com.apple.finder.plist

# Screen Capture
domain="com.apple.screencapture"
# 影をなくす
defaults write ${domain} disable-shadow -bool true
# ファイル名:"ScreenShots"
defaults write ${domain} name "ScreenShots"
# 保存形式:PNG
defaults write ${domain} type -string "png"
# 保存場所
defaults write ${domain} location -string "${HOME}/Desktop"

# WindowManager
domain="com.apple.WindowManager"
defaults write ${domain} EnableTilingByEdgeDrag -bool false
defaults write ${domain} EnableTilingOptionAccelerator -bool false
defaults write ${domain} EnableTopTilingByEdgeDrag -bool false

# Control Center
domain="com.apple.controlcenter"
# Bluetoothを表示
defaults write ${domain} "NSStatusItem Visible Bluetooth" -bool true
# サウンドを表示
defaults write ${domain} "NSStatusItem Visible Sound" -bool true

# Siri
domain="com.apple.Siri"
defaults write ${domain} SiriPrefStashedStatusMenuVisible -bool false
defaults write ${domain} VoiceTriggerUserEnabled -bool false

# For MacBook
# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
