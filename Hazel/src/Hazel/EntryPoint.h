#pragma once

#include <memory>

#ifdef HZ_PLATFORM_WINDOWS

extern Hazel::Application* Hazel::CreateApplication();

int main(int argc, char** argv) { 

	// Initialize the logger
	Hazel::Log::Init();

	// Get the core logger and log a message
	HZ_CORE_WARN("Initialized Log!");
	// Get the client logger and log a message
	HZ_INFO("Hello Hazel!");

	auto app(Hazel::CreateApplication());
	app->Run(); 
	return 0; 
}
#endif