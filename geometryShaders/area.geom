#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

out vec4 gfrontColor;

const float areamax = 0.0005;

uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;

vec4 colorBlack = vec4 (0.0, 0.0, 0.0, 1.0);

vec3 colorRed = vec3 (1.0, 0.0, 0.0);
vec3 colorYellow = vec3 (1.0, 1.0, 0.0);

void main( void )
{
	vec3 a1 = (modelViewMatrix * gl_in[0].gl_Position).xyz;
	vec3 a2 = (modelViewMatrix * gl_in[1].gl_Position).xyz;
	vec3 a3 = (modelViewMatrix * gl_in[2].gl_Position).xyz;

	float area = length (cross (a2 - a1, a3 -a1));
	area /= areamax;

	gl_Position = projectionMatrix * vec4 (a1, 1.0);
	gfrontColor = vec4 (mix (colorRed, colorYellow, area), 1.0);
	EmitVertex();
	gl_Position = projectionMatrix * vec4 (a2, 1.0);
	gfrontColor = vec4 (mix (colorRed, colorYellow, area), 1.0);
	EmitVertex();
	gl_Position = projectionMatrix * vec4 (a3, 1.0);
	gfrontColor = vec4 (mix (colorRed, colorYellow, area), 1.0);
	EmitVertex();
	EndPrimitive();
}
