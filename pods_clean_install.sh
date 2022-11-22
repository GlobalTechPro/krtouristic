#!/bin/sh

cd ios || return
pod deintegrate && pod cache clean --all
# pod update
pod install
