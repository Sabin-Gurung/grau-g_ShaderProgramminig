#version 330 core

in vec4 gfrontColor;
out vec4 fragColor;

in vec3 gNormal;

void main()
{
	
	fragColor = vec4 ((normalize (gNormal)).z);
}
