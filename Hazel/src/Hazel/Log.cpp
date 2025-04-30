#include "Log.h"
#include "spdlog/sinks/stdout_color_sinks.h" // Include the required header for stdout_color_mt

namespace Hazel {

	// Static member variable definitions
	std::shared_ptr<spdlog::logger> Log::s_CoreLogger;
	std::shared_ptr<spdlog::logger> Log::s_ClientLogger;

	// Initializes the logger
	void Log::Init() {

		// Set the pattern for the logger
		// The pattern includes:
		//	%T - The time in HH:MM:SS format
		//	%n - The logger's name
		//	%v - The actual log message
		//	%^ and %$ - Start and end of color range for colored output
		spdlog::set_pattern("%^[%T] %n: %v%$");

		// Create a core logger
		s_CoreLogger = spdlog::stdout_color_mt("HAZEL");
		s_CoreLogger->set_level(spdlog::level::trace); // Set the log level to trace

		// Create a client logger
		s_ClientLogger = spdlog::stdout_color_mt("APP");
		s_ClientLogger->set_level(spdlog::level::trace); // Set the log level to trace
	}
}
