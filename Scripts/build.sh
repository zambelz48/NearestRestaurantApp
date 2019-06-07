#!/bin/bash

ROOT_DIR="$(pwd)"

source "$ROOT_DIR/Scripts/utils.sh"
source "$ROOT_DIR/Scripts/required-tools.sh"
source "$ROOT_DIR/Scripts/install-dependencies.sh"

DERIVEDDATA_DIR="$HOME/NearestRestaurantAppDerivedData"
PROJECT_NAME="NearestRestaurantApp"
PROJECT="$ROOT_DIR/$PROJECT_NAME.xcodeproj"
SDK="iphonesimulator12.2"
PLATFORM="platform=iOS Simulator,OS=12.2,name=iPhone 7"

createDirectory "$DERIVEDDATA_DIR"

echo "Clean derived data..."
clearDataInDirectory "$DERIVEDDATA_DIR"

echo "Testing '$PROJECT_NAME' Started..."
set -o pipefail && xcodebuild \
	-project "$PROJECT" \
	-sdk "$SDK" \
	-destination "$PLATFORM" \
	-derivedDataPath "$DERIVEDDATA_DIR" \
	-scheme NearestRestaurantApp \
	build-for-testing test | xcpretty
echo "Testing finished"
