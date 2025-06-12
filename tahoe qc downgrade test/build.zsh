set -e
cd "$(dirname "$0")"

cp -R ../../moraea-common .
moraea-common/Build.tool
PATH+=:"$PWD/moraea-common/Build"

cp '../../moraea-sources/15.5 (24F74)/QuartzCore' QuartzCoreOld.dylib
cp '../../moraea-sources/15.5 (24F74)/QuartzCore.json' QuartzCoreOld.json

cp '../../moraea-sources/26.0 (25A5279m)/QuartzCore' QuartzCoreNew.dylib
cp '../../moraea-sources/26.0 (25A5279m)/QuartzCore.json' QuartzCoreNew.json

# sigh

cp QuartzCoreNew.dylib QuartzCore
Stubber QuartzCoreOld.dylib QuartzCore shims QuartzCoreWrapper.m QuartzCoreNew.json QuartzCoreOld.json
rm QuartzCore

install_name_tool -id /System/Library/Frameworks/QuartzCore.framework/Versions/A/QuartzCoreOld.dylib QuartzCoreOld.dylib
clang -dynamiclib -fmodules -Wno-unused-getter-return-value -Xlinker -reexport_library -Xlinker QuartzCoreOld.dylib -install_name /System/Library/Frameworks/QuartzCore.framework/Versions/A/QuartzCore -Xlinker -no_warn_inits -I ../../moraea-common/Utils QuartzCoreWrapper.m -o QuartzCore

codesign -f -s - QuartzCoreOld.dylib
codesign -f -s - QuartzCore
