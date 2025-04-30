-- This is a Premake script (premake5.lua), which is used to configure and generate build files for a C++ project.
-- Premake is a tool that helps you create build files (like Visual Studio solutions or Makefiles) for different platforms.
-- The script defines how your project should be built, including where files go, how to compile them, and what settings to use.

-- Define the workspace for the project
-- A "workspace" in Premake is like a container for one or more projects. It represents the entire solution.
-- Here, we're naming the workspace "Hazel", which will be the name of the solution in Visual Studio, for example.
workspace "Hazel"

    -- Set the architecture for the project
    -- This tells Premake that we want to build a 64-bit application.
    -- "x64" means a 64-bit architecture, which is common for modern applications because it allows more memory usage.
    architecture "x64"

    -- Define the build configurations
    -- Configurations are different "modes" for building your project, each with its own settings.
    -- Here, we define three configurations:
    -- - "Debug": Used during development to help find bugs (includes extra info for debugging).
    -- - "Release": Used for testing performance with optimizations but still some debugging info.
    -- - "Dist": Used for the final version of your app, fully optimized for distribution to users.
    configurations {
        "Debug",  -- For debugging, with symbols (extra info for debugging tools) enabled.
        "Release", -- For testing, with optimizations to make the program run faster.
        "Dist" -- For the final build, fully optimized and ready for users.
    }

    -- Set the default startup project
    -- This tells Premake which project should be the "main" project when you open the solution.
    -- For example, in Visual Studio, this project will be the one that runs when you press "Start".
    -- Here, we're setting "Hazel" as the default startup project.
    startproject "Hazel"

-- Define a variable for the output directory format
-- This variable (outputdir) creates a folder name based on the build configuration, system, and architecture.
-- For example, if you're building in Debug mode on Windows with x64 architecture, the folder might be "Debug-windows-x64".
-- - cfg.buildcfg: The configuration (e.g., Debug, Release, Dist).
-- - cfg.system: The operating system (e.g., windows, linux).
-- - cfg.architecture: The architecture (e.g., x64).
outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Define a project named "Hazel"
-- A "project" in Premake is a single build target, like a library or an executable.
-- Here, we're creating a project called "Hazel", which will be part of the "Hazel" workspace.
project "Hazel"

    -- Set the project location
    -- This specifies where Premake will generate the project files (like .vcxproj for Visual Studio).
    -- We're telling Premake to put all project-related files in a folder named "Hazel" in the current directory.
    -- For example, if you're in /MyProject, the project files will be in /MyProject/Hazel.
    location "Hazel"

    -- Specify the type of project
    -- "SharedLib" means this project will build a shared library (also called a DLL on Windows or .so on Linux).
    -- A shared library is a file that can be used by other programs at runtime, allowing code reuse.
    kind "SharedLib"

    -- Set the programming language for the project
    -- This tells Premake that we're writing code in C++, so it will set up the build system to compile C++ files.
    language "C++"

    -- Define where the compiled binary files (like the .dll) will be placed
    -- "targetdir" specifies the output folder for the final compiled files.
    -- We're using the outputdir variable to create a path like "bin/Debug-windows-x64/Hazel".
    -- - "bin/": The base folder for all binaries.
    -- - outputdir: Adds the configuration, system, and architecture (e.g., Debug-windows-x64).
    -- - prj.name: The project name (Hazel), so the final folder might be bin/Debug-windows-x64/Hazel.
    targetdir ("bin/" .. outputdir .. "/%{prj.name}")

    -- Define where intermediate files (like object files) will be placed during compilation
    -- "objdir" specifies the folder for temporary files created during the build process.
    -- Similar to targetdir, we're creating a path like "bin-int/Debug-windows-x64/Hazel".
    -- - "bin-int/": The base folder for intermediate files.
    -- - outputdir: Adds the configuration, system, and architecture.
    -- - prj.name: The project name (Hazel).
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    -- Specify which files to include in the project
    -- The "files" block tells Premake which source files to compile and include in the project.
    -- We're using patterns to include all header (.h) and source (.cpp) files in the Hazel/src directory.
    -- - "%{prj.name}/src/**.h": Includes all .h files in Hazel/src and its subdirectories.
    -- - "%{prj.name}/src/**.cpp": Includes all .cpp files in Hazel/src and its subdirectories.
    files {
        "%{prj.name}/src/**.h", -- All header files in the src directory and its subdirectories.
        "%{prj.name}/src/**.cpp" -- All C++ source files in the src directory and its subdirectories.
    }

    -- Specify directories to search for header files
    -- The "includedirs" block tells the compiler where to look for header files (like #include "somefile.h").
    -- We're adding the Hazel/src directory, so the compiler can find headers in Hazel/src.
    includedirs {
        "$(SolutionDir)Hazel/vendor/spdlog/include"
    }

    -- Apply settings specific to the Windows operating system
    -- The "filter" block applies settings only when building on a specific platform (here, Windows).
    -- The system is automatically determined by Premake.
    filter "system:windows"
        -- Use the latest Windows SDK (Software Development Kit)
        -- This ensures the project uses the most recent Windows libraries and tools for compilation.
        systemversion "latest"
        
        -- Set the C++ standard to C++17, which is a version of the C++ programming language.
        -- This tells the compiler to use C++17 features and syntax.
        cppdialect "C++17" 
        
        -- Use the static runtime library, which means the C++ standard library is included in the final binary.
        -- This can help reduce dependencies and make the final executable smaller.
        -- It also means that the runtime library is statically linked, which can improve performance and reduce issues with DLLs.
        -- This is useful for shared libraries, as it avoids potential conflicts with different versions of the runtime library.
        staticruntime "On" 

        -- Define a macro for the Windows platform
        -- "defines" adds preprocessor macros (like #define in C++).
        -- We're defining HZ_PLATFORM_WINDOWS, which can be used in your code to check if the platform is Windows.
        -- For example, you might write: #ifdef HZ_PLATFORM_WINDOWS to include Windows-specific code.
        defines {
            "HZ_PLATFORM_WINDOWS", -- Tells the code that we're building for Windows.
            "HZ_BUILD_DLL", -- Indicates that we're building a DLL (Dynamic Link Library).
        }

        -- Define post-build commands
        -- "Postbuildcommands" specifies commands to run after the build process is complete.
        -- Here, we copy the built DLL (Hazel.dll) to the output directory of the Sandbox project.
        postbuildcommands {
            ("cmd /c \"mkdir $(SolutionDir)bin\\%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}\\Sandbox || exit 0\""),
            ("{COPYFILE} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox/")
        }
        

        buildoptions { "/utf-8" } -- 启用 UTF-8 编译选项
    
    -- Apply settings for the Debug configuration
    -- This block applies settings only when building in Debug mode.
    filter "configurations:Debug"
        -- Define a macro for Debug mode
        -- This adds a macro HZ_DEBUG, which your code can use to enable debug-specific features.
        -- For example, you might write: #ifdef HZ_DEBUG to include extra logging for debugging.
        defines "HZ_DEBUG"

        -- Set the runtime library to Debug
        -- This tells the compiler to use the Debug version of the C++ runtime library, which includes extra checks for debugging.
        runtime "Debug"

        -- Enable debug symbols
        -- Debug symbols are extra information in the binary that helps debuggers (like Visual Studio's debugger) show variable names, line numbers, etc.
        symbols "on"

    -- Apply settings for the Release configuration
    -- This block applies settings only when building in Release mode.
    filter "configurations:Release"
        -- Define a macro for Release mode
        -- This adds a macro HZ_RELEASE, which your code can use to enable release-specific features.
        defines "HZ_RELEASE"

        -- Set the runtime library to Release
        -- This uses the Release version of the C++ runtime library, which is optimized for performance.
        runtime "Release"

        -- Enable optimizations
        -- This tells the compiler to optimize the code for speed, making the program run faster but harder to debug.
        optimize "on"

    -- Apply settings for the Distribution (Dist) configuration
    -- This block applies settings only when building in Dist mode (for final distribution).
    filter "configurations:Dist"
        -- Define a macro for Distribution mode
        -- This adds a macro HZ_DIST, which your code can use to enable distribution-specific features.
        defines "HZ_DIST"

        -- Set the runtime library to Release
        -- Like Release mode, this uses the optimized Release runtime library.
        runtime "Release"

        -- Enable optimizations
        -- This ensures the final build is fully optimized for performance.
        optimize "on"

-- Project for the Sandbox application
-- This project is a separate application that uses the Hazel library.
project "Sandbox"

    location "Sandbox" -- Set the location for the Sandbox project files
    kind "ConsoleApp" -- This project is a console application (a program that runs in a terminal or command prompt).

    language "C++" -- The programming language for this project is C++.

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")

    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files {
        "%{prj.name}/src/**.h", -- All header files in the src directory and its subdirectories.
        "%{prj.name}/src/**.cpp" -- All C++ source files in the src directory and its subdirectories.
    }

    links {
        "Hazel" -- Link against the Hazel library, which means this project will use the Hazel code.
    }

    includedirs {
        "$(SolutionDir)Hazel/vendor/spdlog/include",
        "$(SolutionDir)Hazel/src"
    }

    -- Apply settings specific to the Windows operating system
    -- The "filter" block applies settings only when building on a specific platform (here, Windows).
    -- The system is automatically determined by Premake.
    filter "system:windows"
        -- Use the latest Windows SDK (Software Development Kit)
        -- This ensures the project uses the most recent Windows libraries and tools for compilation.
        systemversion "latest"
        
        -- Set the C++ standard to C++17, which is a version of the C++ programming language.
        -- This tells the compiler to use C++17 features and syntax.
        cppdialect "C++17" 
        
        -- Use the static runtime library, which means the C++ standard library is included in the final binary.
        -- This can help reduce dependencies and make the final executable smaller.
        -- It also means that the runtime library is statically linked, which can improve performance and reduce issues with DLLs.
        -- This is useful for shared libraries, as it avoids potential conflicts with different versions of the runtime library.
        staticruntime "On" 

        -- Define a macro for the Windows platform
        -- "defines" adds preprocessor macros (like #define in C++).
        -- We're defining HZ_PLATFORM_WINDOWS, which can be used in your code to check if the platform is Windows.
        -- For example, you might write: #ifdef HZ_PLATFORM_WINDOWS to include Windows-specific code.
        defines {
            "HZ_PLATFORM_WINDOWS" -- Tells the code that we're building for Windows.
        }
        
        buildoptions { "/utf-8" } -- 启用 UTF-8 编译选项

    -- Apply settings for the Debug configuration
    -- This block applies settings only when building in Debug mode.
    filter "configurations:Debug"
        -- Define a macro for Debug mode
        -- This adds a macro HZ_DEBUG, which your code can use to enable debug-specific features.
        -- For example, you might write: #ifdef HZ_DEBUG to include extra logging for debugging.
        defines "HZ_DEBUG"

        -- Set the runtime library to Debug
        -- This tells the compiler to use the Debug version of the C++ runtime library, which includes extra checks for debugging.
        runtime "Debug"

        -- Enable debug symbols
        -- Debug symbols are extra information in the binary that helps debuggers (like Visual Studio's debugger) show variable names, line numbers, etc.
        symbols "on"

    -- Apply settings for the Release configuration
    -- This block applies settings only when building in Release mode.
    filter "configurations:Release"
        -- Define a macro for Release mode
        -- This adds a macro HZ_RELEASE, which your code can use to enable release-specific features.
        defines "HZ_RELEASE"

        -- Set the runtime library to Release
        -- This uses the Release version of the C++ runtime library, which is optimized for performance.
        runtime "Release"

        -- Enable optimizations
        -- This tells the compiler to optimize the code for speed, making the program run faster but harder to debug.
        optimize "on"

    -- Apply settings for the Distribution (Dist) configuration
    -- This block applies settings only when building in Dist mode (for final distribution).
    filter "configurations:Dist"
        -- Define a macro for Distribution mode
        -- This adds a macro HZ_DIST, which your code can use to enable distribution-specific features.
        defines "HZ_DIST"

        -- Set the runtime library to Release
        -- Like Release mode, this uses the optimized Release runtime library.
        runtime "Release"

        -- Enable optimizations
        -- This ensures the final build is fully optimized for performance.
        optimize "on"

