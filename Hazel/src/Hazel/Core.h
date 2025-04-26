#pragma once

// This section defines the HAZEL_API macro for Windows platform.  
// If HZ_BUILD_DLL is defined, it exports symbols for building a DLL.  
// Otherwise, it imports symbols for using the DLL.  
// Hazel only supports Windows, and compilation will fail on other platforms.
#ifdef HZ_PLATFORM_WINDOWS
   // If HZ_BUILD_DLL is defined, export the symbols for the DLL being built.
   #ifdef HZ_BUILD_DLL
       #define HZ_API __declspec(dllexport)
   // If HZ_BUILD_DLL is not defined, import the symbols for using the DLL.
   #else
       #define HZ_API __declspec(dllimport)
   #endif
// If the platform is not Windows, throw a compilation error.
#else
   #error Hazel only supports Windows!
#endif
