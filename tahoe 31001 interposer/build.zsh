set -e

patchedActualPath="$1"
impostorActualPath="$(dirname "$patchedActualPath")/impostor.dylib"

patchedInstallPath="$(otool -D "$patchedActualPath" | tail -n 1)"
impersonatedInstallPath=/System/Library/Frameworks/IOSurface.framework/Versions/A/IOSurface
impostorInstallPath="$(dirname "$patchedInstallPath")/impostor.dylib"

echo "\e[35mupdate \"$patchedActualPath\" (install path \"$patchedInstallPath\") to use \"$impostorActualPath\" (install path \"$impostorInstallPath\") impersonating \"$impersonatedInstallPath\"\e[0m"

install_name_tool -change "$impersonatedInstallPath" "$impostorInstallPath" "$patchedActualPath"

codePath="$(dirname "$0")"

function getStruct
{
	headerPath="$1"
	structName="$2"
	prefix="$3"
	
	mkdir -p "$prefix"
	
	{
		echo "struct ${prefix}_$structName"
		grep "  struct $structName" "$headerPath" | grep -E -o '{.*}' | sed 's/; /;\n/g' | sed 's/^\</id\</g'
		echo ';'
	} > "$prefix/$structName.h"
}

function getStructs
{
	className="$1"
	structName="$2"
	
	getStruct "$codePath/../../moraea-sources/12.7.6 (21H1320)/headers/Metal/$className.h" "$structName" monterey
	getStruct "$codePath/../../moraea-sources/26.0 (25A5279m)/headers/Metal/$className.h" "$structName" tahoe
}

getStructs MTLRenderPipelineDescriptorInternal MTLRenderPipelineDescriptorPrivate
getStructs MTLComputePipelineDescriptorInternal MTLComputePipelineDescriptorPrivate
getStructs MTLRenderPipelineColorAttachmentDescriptorInternal MTLRenderPipelineAttachmentDescriptorPrivate

if [[ "$patchedInstallPath" == /System/Library/Extensions/AppleIntel*GraphicsMTLDriver.bundle/Contents/MacOS/AppleIntel*GraphicsMTLDriver ]]
then
	echo "\e[31mmetal is kil (intel)\e[0m"
	metalIsKilArg=-DMETAL_IS_KIL_INTEL
elif [[ "$patchedInstallPath" == /System/Library/Extensions/AMDMTLBronzeDriver.bundle/Contents/MacOS/AMDMTLBronzeDriver ]]
then
	echo "\e[31mmetal is kil (gcn)\e[0m"
	metalIsKilArg=-DMETAL_IS_KIL_GCN
fi

clang -fmodules -dynamiclib "$codePath/interposer.m" -Wno-unused-getter-return-value -Xlinker -no_warn_inits -I "$codePath/../../moraea-common/Utils" -I . "$metalIsKilArg" -install_name "$impostorInstallPath" -Xlinker -reexport_library -Xlinker "$impersonatedInstallPath" -o "$impostorActualPath"

codesign -f -s - "$impostorActualPath"
codesign -f -s - "$patchedActualPath"

cp "$codePath/../../moraea-sources/26.0 (25A5279m)/QuartzCore" .

Binpatcher QuartzCore QuartzCore_patched 'set 0x230497
assert 0x0f836f1e0000
nop 0x6'

codesign -f -s - QuartzCore_patched
