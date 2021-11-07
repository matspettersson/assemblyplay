$src = hello-msgbox
all: hello-msgbox.exe

hello-msgbox.exe: hello-msgbox.obj
	link hello-msgbox /subsystem:console /defaultlib:kernel32.lib /defaultlib:user32.lib /entry:main /LIBPATH:"C:\Program Files (x86)\Windows Kits\10\Lib\10.0.19041.0\um\x64" 

hello-msgbox.obj: hello-msgbox.asm
	ml64 /c hello-msgbox.asm 

clean:
	del hello-msgbox.exe hello-msgbox.obj
