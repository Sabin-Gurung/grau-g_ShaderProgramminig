#version 330 core

uniform sampler2D sampler0;
uniform sampler2D sampler1;
uniform sampler2D sampler2;
uniform sampler2D sampler3;

in vec4 frontColor;
in vec2 vtexCoord;

out vec4 fragColor;
 
uniform float time;
uniform float slice = 0.1;

void main()
{
	//float curFrame = mod((time * 1.0/slice ), 4.0);
	//float fraction = fract(time);
	float curFrame = mod(time, 4.0 * slice);
    vec4 ourColor;

	if     (curFrame >= 0.0 * slice && curFrame < 1.0 * slice) ourColor = texture(sampler0, vtexCoord);
	else if(curFrame >= 1.0 * slice && curFrame < 2.0 * slice) ourColor = texture(sampler1, vtexCoord);
	else if(curFrame >= 2.0 * slice && curFrame < 3.0 * slice) ourColor = texture(sampler2, vtexCoord);
	else if(curFrame >= 3.0 * slice && curFrame < 4.0 * slice) ourColor = texture(sampler3, vtexCoord);
	
	fragColor = ourColor * ourColor.a;
}
