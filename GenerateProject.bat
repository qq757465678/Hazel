:: 删除Hazel和Sandbox的项目文件  
del /f /q "C:\dev\Hazel\Hazel.sln"  
del /f /q "C:\dev\Hazel\Hazel\Hazel.vcxproj"  
del /f /q "C:\dev\Hazel\Sandbox\Sandbox.vcxproj"

call vendor\bin\premake5.exe vs2022
PAUSE
