#version 330 core

out vec4 fragColor;

in vec3 gNormal;
in vec3 gColor;


void main()
{
	fragColor = vec4 (gColor, 1.0);
}
