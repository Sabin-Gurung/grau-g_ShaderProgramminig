#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform int xmax = 6;
uniform int xmin = -6;
uniform int ymax = 2;
uniform int ymin = -2;

void main()
{
	float x = mix (xmax, xmin, (vertex.x + 1.0) / 2.0); 	
	float lamda;
	if (vertex.z == -2)
	{
		lamda = sin (x);
		frontColor = vec4 (1.0, 0.0, 0.0, 1.0);
	}
	else if (vertex.z == 0)
	{
		lamda = pow (2, -x*x/6);
		frontColor = vec4 (0.0, 1.0, 0.0, 1.0);
	}
	else if (vertex.z == 2)
	{
		lamda = sin (2x);
		frontColor = vec4 (0.0, 0.0, 1.0, 1.0);
	}
	
	y = mix (-1, 1, (lambda - ymin) / (ymax - ymin));
	

	gl_Position = vec4 (vertex.x, vertex.y + y, 0, 1);
}
