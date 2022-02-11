CFLAGS = -std=c++17 -O02
LDFLAGS = -lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi
VulkanTest: main.cpp
	glslc ./shaders/shader.vert -o ./shaders/vert.spv
	glslc ./shaders/shader.frag -o ./shaders/frag.spv
	g++ $(CFLAGS) -o VulkanTest main.cpp $(LDFLAGS)
.PHONY: test clean

test: VulkanTest
	./VulkanTest

clean:
	rm -f VulkanTest
