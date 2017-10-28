md obj

nasm IPL.nsm -o obj\IPL.bin
nasm easyOS.nsm -o obj\easyOS.bin
nasm io_hlt.nsm -f coff -o obj\io_hlt.obj
rem nask io_hlt.nsm obj\io_hlt.obj obj\io_hlt.lst

gcc bootpack.c -c 
move bootpack.o obj\bootpack.obj
obj2bim @source\obj2bim.rul out:obj\bootpack.bim stack:3136k map:obj\bootpack.map obj\bootpack.obj obj\io_hlt.obj
bim2hrb obj\bootpack.bim obj\bootpack.hrb 0
copy /B obj\easyOS.bin+obj\bootpack.hrb obj\easyOS.sys

edimg.exe   imgin:source\fdimg0at.tek   wbinimg src:obj\IPL.bin len:512 from:0 to:0 copy from:obj\easyOS.sys   to:@: imgout:MyOS.img
copy MyOS.img ..\..\MyOS.img
@pause