#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform float time;

in float f_xNDC;

void main()
{
	
	float newX = f_xNDC + 1.0;
	if (newX > time) discard; 
	fragColor = frontColor;
}
