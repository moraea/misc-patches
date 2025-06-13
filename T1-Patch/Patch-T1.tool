# Patch 13.6 SharedUtils for Sonoma T1 support
# Bin from OCLP PSP

#!/bin/zsh

set -e

cd "$(dirname "$0")"

prefixOut="Wrapped"
rm -rf "$prefixOut"
mkdir "$prefixOut"

cp -R ../../moraea-common "$prefixOut"
"$prefixOut/moraea-common/Build.tool"
PATH+=":$prefixOut/moraea-common/Build"

function clangCommon
{
	clang -fmodules -I "$prefixOut/moraea-common/Utils" -Wno-unused-getter-return-value -Wno-objc-missing-super-calls $@
}

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
	shimsIn="$PWD/Shims"
	hackNew="${newIn}.json"
	hackOld="${oldIn}.json"

	# hack for Stubber to get the right name
	nameHack="$prefixOut/$name"
	cp "$newIn" "$nameHack"

	Stubber "$oldIn" "$nameHack" "$shimsIn" "$mainIn" "$hackNew" "$hackOld"

	rm "$nameHack"
	
	clangCommon -dynamiclib -compatibility_version 1.0.0 -current_version 1.0.0 -install_name "$mainInstall" -Xlinker -reexport_library "$oldOut" "$mainIn" -o "$mainOut" -Xlinker -no_warn_inits $4
	
	codesign -f -s - "$oldOut"
	codesign -f -s - "$mainOut"
}

Binpatcher SharedUtils_1371 SharedUtils_1371_patched '# change LARemoteContextOwnership to id for NSXPCConnection error in 15.4
set 0x2d64f
assert 0x76363440303A3840224E535555494422313640223C4C4152656D6F7465436F6E746578744F776E6572736869703E22323440224E53537472696E6722333240224E5355554944223430513438403F3C76403F40223C4C4152656D6F7465436F6E746578744F776E6572736869703E2240224E534572726F72223E353600
write 0x76363440303A3840224E535555494422313640223C4C4152656D6F7465436F6E746578744F776E6572736869703E22323440224E53537472696E6722333240224E5355554944223430513438403F3C76403F4040224E534572726F72223E353600'

build SharedUtils_1371_patched "SharedUtils_152" "/System/Library/Frameworks/LocalAuthentication.framework/Support/SharedUtils.framework/Versions/A/SharedUtils"

build "NearField_1472" "NearField_1472" "/System/Library/PrivateFrameworks/NearField.framework/Versions/A/NearField"
