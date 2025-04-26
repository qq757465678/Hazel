#pragma once

#include <memory>

#ifdef HZ_PLATFORM_WINDOWS

extern Hazel::Application* Hazel::CreateApplication();

int main(int argc, char** argv) { 
	std::unique_ptr<Hazel::Application> app(Hazel::CreateApplication());
	app->Run(); 
	return 0; 
}
#endif