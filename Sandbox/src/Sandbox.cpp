#include<Hazel.h>

class Sandbox : public Hazel::Application {
public:
    Sandbox() {
        // Constructor logic if needed
    }

    ~Sandbox() {
        // Destructor logic if needed
    }
};

Hazel::Application* Hazel::CreateApplication() {
    return new Sandbox();
}
