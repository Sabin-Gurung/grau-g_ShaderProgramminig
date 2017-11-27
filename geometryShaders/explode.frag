#version 330 core

in vec3 gNormal;
out vec4 fragColor;

void main()
{
	fragColor = vec4 (normalize (gNormal).z);
}
