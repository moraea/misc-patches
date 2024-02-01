# Patch 13.2.1 Metal for Sonoma 14.0+
# Bins from OCLP PSP

#!/bin/zsh

set -e

export code="$(dirname "$0")"
cd "$code"

function clangCommon
{
	clang -fmodules -I "$code/Utils" -Wno-unused-getter-return-value -Wno-objc-missing-super-calls $@
}

prefixOut="Wrapped"
rm -rf "$prefixOut"
mkdir "$prefixOut"

function build
{
	oldIn="$1"
	newIn="$2"
	mainInstall="$3"
	
	name="$(basename "$mainInstall")"
	mainNameOut="$name"
	oldNameOut="${name}Old.dylib"
	
	prefixInstall="$(dirname "$mainInstall")"
	oldInstall="$prefixInstall/$oldNameOut"
	
	mainOut="$prefixOut/$mainNameOut"
	oldOut="$prefixOut/$oldNameOut"
	
	cp "$oldIn" "$oldOut"
	install_name_tool -id "$oldInstall" "$oldOut"
	
	mainIn="$prefixOut/${name}Wrapper.m"
	shimsIn="$code/Shims"
	hackNew="${newIn}.json"
	hackOld="${oldIn}.json"

	# hack for Stubber to get the right name
	nameHack="$prefixOut/$name"
	cp "$newIn" "$nameHack"

	./Stubber "$oldIn" "$nameHack" "$shimsIn" "$mainIn" "$hackNew" "$hackOld"

	rm "$nameHack"
	
	clangCommon -dynamiclib -compatibility_version 1.0.0 -current_version 1.0.0 -install_name "$mainInstall" -Xlinker -reexport_library "$oldOut" -I "$code/Shims" "$mainIn" -o "$mainOut" $4
	
	codesign -f -s - "$oldOut"
	codesign -f -s - "$mainOut"
}

build "Metal_1321" "Metal_144" "/System/Library/Frameworks/Metal.framework/Versions/A/Metal"

# Replace 31001 with 32023 dlopen path
./Binpatcher $oldOut $oldOut 'set 0x184654
write 0x3332303233'
codesign -fs - $oldOut

# Patch MTLCompilerService.xpc

cp -R MTLCompilerService.xpc $prefixOut/MTLCompilerService.xpc

# Replace 31001 with 32023 dlopen path
./Binpatcher $prefixOut/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService $prefixOut/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService 'set 0x3db0
write 0x3332303233'

Codesign -fs - $prefixOut/MTLCompilerService.xpc/Contents/MacOS/MTLCompilerService