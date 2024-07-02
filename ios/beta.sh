export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# Add Fastlane Path
export PATH=$PATH:~/.rbenv/shims

#arch -x86_64 pod install
pod install

fastlane beta

