# Patch IOUSBHostFamily.kext for 14.4+
# Kext from OCLP repo

#!/bin/zsh

set -e

export code="$(dirname "$0")"
cd "$code"

prefixOut="Patched"
rm -rf "$prefixOut"
mkdir "$prefixOut"

cp -R IOUSBHostFamily.kext $prefixOut/IOUSBHostFamily.kext

# replace _IORPCMessageFromMach with _tb_message_construct

./Binpatcher $prefixOut/IOUSBHostFamily.kext/Contents/MacOS/IOUSBHostFamily $prefixOut/IOUSBHostFamily.kext/Contents/MacOS/IOUSBHostFamily 'set 0x119e5f
write 0x5F74625F6D6573736167655F636F6E737472756374

# disable functions that call _IORPCMessageFromMach

symbol __ZN15IOUSBHostDevice9_DispatchEPS_5IORPC
return 0x0
symbol __ZN15IOUSBHostDevice9MetaClass8DispatchE5IORPC
return 0x0
symbol __ZN13IOUSBHostPipe9_DispatchEPS_5IORPC
return 0x0
symbol __ZN13IOUSBHostPipe9MetaClass8DispatchE5IORPC
return 0x0
symbol __ZN18IOUSBHostInterface9_DispatchEPS_5IORPC
return 0x0
symbol __ZN18IOUSBHostInterface9MetaClass8DispatchE5IORPC
return 0x0
'

codesign -fs - $prefixOut/IOUSBHostFamily.kext/Contents/MacOS/IOUSBHostFamily