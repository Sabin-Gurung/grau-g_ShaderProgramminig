#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

void main()
{
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
	//  y coordinates in NDC -1 .. 1
	float a = ((gl_Position.y/gl_Position.w)+1.0)/2.0;    //  a = 0...1
	
	vec3 colorRed    = vec3(1.0, 0.0, 0.0);	
	vec3 colorYellow = vec3(1.0, 1.0, 0.0);	
	vec3 colorGreen  = vec3(0.0, 1.0, 0.0);	
	vec3 colorCian   = vec3(0.0, 1.0, 1.0);	
	vec3 colorBlue   = vec3(0.0, 0.0, 1.0);
	
	vec3 color;
	if(a/0.25 < 1)
	{
		float b = fract(a/0.25);
		color = mix(colorRed, colorYellow, b); 
	}
	else if(a/0.25 < 2)
	{
		float b = fract(a/0.25);
		color = mix(colorYellow, colorGreen, b);
	}
	else if(a/0.25 < 3)
	{
		float b = fract(a/0.25);
		color = mix(colorGreen, colorCian, b);
	}
	else
	{
		float b = fract(a/0.25);
		if(a >= 1.0) b = 1.0;
		color = mix(colorCian, colorBlue, b);
	}
	
    frontColor = vec4(color,1.0);
    vtexCoord = texCoord;
}
