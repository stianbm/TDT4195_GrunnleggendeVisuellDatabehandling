// Local headers
#include "program.hpp"
#include "gloom/gloom.hpp"
#include "gloom/shader.hpp"

unsigned int SetUpVAO(float* Coordinates, int nCoordinates, int* Indices, int nIndices) {
	//Allocate space for VAO
	unsigned int Array = 0;
	//Create new VAO
	glGenVertexArrays(1, &Array);
	//Bind VAO
	glBindVertexArray(Array);
	//Allocate space for VBO
	unsigned int Buffer = 0;
	//Create VBO
	glGenBuffers(1, &Buffer);
	//Bind VBO
	glBindBuffer(GL_ARRAY_BUFFER, Buffer);
	//Filling buffer
	glBufferData(GL_ARRAY_BUFFER, (nCoordinates * sizeof(float)), Coordinates, GL_STATIC_DRAW);
	//Set the Vertex Attribute Pointer
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, 0);
	//Enabling the vertex attributes
	glEnableVertexAttribArray(0);
	//Make index buffer
	unsigned int IndexBuffer = 0;
	glGenBuffers(1, &IndexBuffer);
	//Bind index buffer
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, IndexBuffer);
	//Fill index buffer
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, (nIndices * sizeof(int)), Indices, GL_STATIC_DRAW);
	//Return value
	return Array;
}

void runProgram(GLFWwindow* window)
{
	// Enable depth (Z) buffer (accept "closest" fragment)
	glEnable(GL_DEPTH_TEST);
	glDepthFunc(GL_LESS);

	// Configure miscellaneous OpenGL settings
	glEnable(GL_CULL_FACE);

	// Set default colour after clearing the colour buffer
	glClearColor(0.3f, 0.5f, 0.8f, 1.0f);

	// Set up your scene here (create Vertex Array Objects, etc.)
	//Create a triangle
	/*
	float Triangle[] = { -0.6, -0.6, 0.0, 0.6, -0.6, 0.0, 0.0, 0.6, 0.0 };
	*/
	int TriangleLength = 9;
	int Indices[] = { 0, 1, 2 };
	int nIndices = 3;


	//Create 4 more triangles
	/*
	float Triangle2[] = { -0.9, -0.9, 0.0, -0.6, -0.9, 0.0, -0.9, -0.6, 0.0};
	float Triangle3[] = { 0.9, 0.9, 0.0, 0.6, 0.9, 0.0, 0.9, 0.6, 0.0 };
	float Triangle4[] = { -0.9, 0.9, 0.0, -0.9, 0.6, 0.0, -0.6, 0.9, 0.0 };
	float Triangle5[] = { 0.9, -0.9, 0.0, 0.9, -0.6, 0.0, 0.6, -0.9, 0.0 };
	*/


	//Task 2.a

	float TriangleOutside[] = { 0.6, -0.8, -1.2, 0.0, 0.4, 0.0, -0.8, -0.2, 1.2 };
	unsigned int ArrayOutside = SetUpVAO(TriangleOutside, TriangleLength, Indices, nIndices);

	//Create vertex array object and vertex buffer object
	/*
	unsigned int Array = SetUpVAO(Triangle, TriangleLength, Indices, nIndices);
	unsigned int Array2 = SetUpVAO(Triangle2, TriangleLength, Indices, nIndices);
	unsigned int Array3 = SetUpVAO(Triangle3, TriangleLength, Indices, nIndices);
	unsigned int Array4 = SetUpVAO(Triangle4, TriangleLength, Indices, nIndices);
	unsigned int Array5 = SetUpVAO(Triangle5, TriangleLength, Indices, nIndices);
	*/

	//Load shaders
	Gloom::Shader Shader;
	Shader.makeBasicShader("C:/Users/stianbm/gloom/gloom/shaders/simple.vert", "C:/Users/stianbm/gloom/gloom/shaders/simple.frag");

	//Activate shader
	Shader.activate();

	// Rendering Loop
	while (!glfwWindowShouldClose(window))
	{
		// Clear colour and depth buffers

		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		// Draw your scene here
		/*
		glBindVertexArray(Array);
		glDrawElements(GL_TRIANGLES, nIndices, GL_UNSIGNED_INT, 0);
		glBindVertexArray(Array2);
		glDrawElements(GL_TRIANGLES, nIndices, GL_UNSIGNED_INT, 0);
		glBindVertexArray(Array3);
		glDrawElements(GL_TRIANGLES, nIndices, GL_UNSIGNED_INT, 0);
		glBindVertexArray(Array4);
		glDrawElements(GL_TRIANGLES, nIndices, GL_UNSIGNED_INT, 0);
		glBindVertexArray(Array5);
		glDrawElements(GL_TRIANGLES, nIndices, GL_UNSIGNED_INT, 0);
		*/

		glBindVertexArray(ArrayOutside);
		glDrawElements(GL_TRIANGLES, nIndices, GL_UNSIGNED_INT, 0);

		// Handle other events
		glfwPollEvents();
		handleKeyboardInput(window);

		// Flip buffers
		glfwSwapBuffers(window);
	}
	//Deactivate shader
	Shader.deactivate();
}


void handleKeyboardInput(GLFWwindow* window)
{
	// Use escape key for terminating the GLFW window
	if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
	{
		glfwSetWindowShouldClose(window, GL_TRUE);
	}
}

/*Theory
2.
a)
i)

ii)

iii)
b)
i)
A shader is a program that alters data. The vertex shader
processes vertexes and can move them around and is responsible
for clipping the scenery.
The fragment shader assigns colour to the pixels, and therefor
has to take lighting and such into account if present.

ii)
The distinction between shaders and programs in OpenGL is that
shaders act as small programs and programs bundle together shaders.
The shaders compile individually, attach to the program object and
link together.

iii)
The two most common shaders are vertex- and fragment shaders,
described in i).

iv)
The layout qualifiers make sure that the correct VAO is used
in the correct shader. Thus the layout variable must be equal
to the index in the glVertexAttribPointer().

v)
A uniform variable doesn't change between different instances
of the shader, but a vertex attribute will. The uniform variables
can not be changed inside the shader.

*/