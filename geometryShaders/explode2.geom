#version 330 core

layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];

in vec3 vNormal[];

out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;

const float speed    = 0.25;
const float angSpeed = 4.0;
uniform float time;


void main( void )
{
	// calculation of normal and baricentre
	vec3 normal     = vec3 (0.0, 0.0, 0.0);
	vec3 baryCenter = vec3 (0.0, 0.0, 0.0);
	for( int i = 0 ; i < 3 ; i++ )
	{
		normal     += vNormal[i];
		baryCenter += gl_in[i].gl_Position.xyz;
	}
	normal = normalize (normal);
	baryCenter = baryCenter / 3.0;

	// for rotation
	float rot = angSpeed * time;
	mat3 rotMat = mat3 (vec3 ( cos (rot), sin(rot), 0.0),
	                    vec3 (-sin (rot), cos(rot), 0.0),
	                    vec3 ( 0.0      ,      0.0, 1.0));

	// drawing of primitives
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		vec3 pos = gl_in[i].gl_Position.xyz;
		
		// translate center to origin
		pos = pos - baryCenter;
		// rotate on z axis
		pos = rotMat * pos;
		// translate back
		pos = pos + baryCenter;
		// apply normal translation
		pos = pos + time * speed * normal;
		gl_Position = modelViewProjectionMatrix * vec4 (pos, 1.0);
		EmitVertex();
	}
	EndPrimitive();

}
