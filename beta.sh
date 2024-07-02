export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# Add Fastlane Path
export PATH=$PATH:~/.rbenv/shims

flutter pub get

cd ios
sh beta.sh

cd ..
cd android
sh beta.sh

