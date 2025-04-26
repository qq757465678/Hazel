/*
 * Application.h
 * This file defines the core Application class for the Hazel Engine.
 * The Application class serves as the entry point and manages the main loop.
 */

#pragma once
#include "Core.h"

namespace Hazel {

    /*
     * The Application class represents the main application.
     * It provides methods to initialize, run, and clean up the application.
     */

	// The __declspec(dllexport) keyword is used to export the class from a DLL.
	class HAZEL_API Application{
    public:
        // Constructor: Initializes the application.
        Application();
        
        // Destructor: Cleans up resources when the application is destroyed.
        virtual ~Application();

        // Run: Starts the main application loop.
        void Run();
    };

}