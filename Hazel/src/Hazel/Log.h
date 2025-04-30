#pragma once  

#include <memory>

#include "Core.h"
#include "spdlog/spdlog.h"

namespace Hazel {  
   class HZ_API Log {  
   public:  
	   // Constructor
       Log();

	   // Destructor
       ~Log();

	   // Initializes the logger
	   static void Init();

	   // Returns a shared pointer to the core logger
	   inline static std::shared_ptr<spdlog::logger>& GetCoreLogger() {
		   return s_CoreLogger;
	   }
	   // Returns a shared pointer to the client logger
	   inline static std::shared_ptr<spdlog::logger>& GetClientLogger() {
		   return s_ClientLogger;
	   }
   private:
	   // Static member variables for core and client loggers
	   static std::shared_ptr<spdlog::logger> s_CoreLogger;
	   static std::shared_ptr<spdlog::logger> s_ClientLogger;
   };  
}

// Define macros for logging at different levels
#define HZ_CORE_TRACE(...) ::Hazel::Log::GetCoreLogger()->trace(__VA_ARGS__)
#define HZ_CORE_INFO(...)  ::Hazel::Log::GetCoreLogger()->info(__VA_ARGS__)
#define HZ_CORE_WARN(...)  ::Hazel::Log::GetCoreLogger()->warn(__VA_ARGS__)
#define HZ_CORE_ERROR(...) ::Hazel::Log::GetCoreLogger()->error(__VA_ARGS__)	
#define HZ_CORE_FATAL(...) ::Hazel::Log::GetCoreLogger()->fatal(__VA_ARGS__)

// Define macros for client logging at different levels
#define HZ_TRACE(...)      ::Hazel::Log::GetClientLogger()->trace(__VA_ARGS__)
#define HZ_INFO(...)       ::Hazel::Log::GetClientLogger()->info(__VA_ARGS__)
#define HZ_WARN(...)       ::Hazel::Log::GetClientLogger()->warn(__VA_ARGS__)
#define HZ_ERROR(...)      ::Hazel::Log::GetClientLogger()->error(__VA_ARGS__)
#define HZ_FATAL(...)      ::Hazel::Log::GetClientLogger()->fatal(__VA_ARGS__)

