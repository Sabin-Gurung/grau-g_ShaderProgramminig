#version 330 core

out vec4 fragColor;

in vec3 gNormal;

void main()
{
	
	fragColor = vec4 ((normalize (gNormal)).z);
}
