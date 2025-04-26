#include "Application.h"  
#include <iostream>  
#include <thread>  
#include <chrono>  

namespace Hazel {  

// Constructor for the Application class  
Application::Application() {  
}  

// Destructor for the Application class  
Application::~Application() {  
}  

// Main loop of the application  
void Application::Run() {  
	while (true) {  
		// Perform update logic here  

		// Perform rendering logic here  

		// Print a message to indicate the application is running  
		std::cout << "Running Application..." << std::endl;  

		// Pause execution for 1 second  
		std::this_thread::sleep_for(std::chrono::seconds(1));  
	}  
}  
