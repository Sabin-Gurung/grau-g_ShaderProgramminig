#version 330 core

out vec4 fragColor;

in vec3 gNormal;
in vec4 gfrontColor;

void main()
{
	fragColor = vec4 ((normalize (gNormal)).z);
	//fragColor = gfrontColor;
}
