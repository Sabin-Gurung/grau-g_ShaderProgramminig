#version 330 core

layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];

in vec3 vNormal[];

out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;

const float speed    = 0.4;
uniform float time;


void main( void )
{
	// calculation of normal and baricentre
	vec3 normal     = vec3 (0.0, 0.0, 0.0);
	for( int i = 0 ; i < 3 ; i++ )
	{
		normal     += vNormal[i];
	}
	normal = normalize (normal);

	// drawing of primitives
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		vec3 pos = gl_in[i].gl_Position.xyz;
		
		pos = pos + time * speed * normal;
		gl_Position = modelViewProjectionMatrix * vec4 (pos, 1.0);
		EmitVertex();
	}
	EndPrimitive();

}
