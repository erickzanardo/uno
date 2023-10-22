#!/bin/bash

flutter build macos

cp -r build/macos/Build/Products/Release/uno.app /Applications
