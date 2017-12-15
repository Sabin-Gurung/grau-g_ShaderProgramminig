#version 330 core

layout (location = 0) in vec3 coord;

uniform mat4 modelViewProjectionMatrix;

uniform vec3 boundingBoxMax;
uniform vec3 boundingBoxMin;

void main()
{
	// calculate scale
	mat4 scale = mat4 (vec4 ((boundingBoxMax.x - boundingBoxMin.x), 0, 0, 0),
	                   vec4 (0, (boundingBoxMax.y - boundingBoxMin.y), 0, 0),
	                   vec4 (0, 0, (boundingBoxMax.z - boundingBoxMin.z), 0),
	                   vec4 (0, 0, 0, 1));

	// align
	vec3 centre = (boundingBoxMax + boundingBoxMin) / 2;
	
	gl_Position    = modelViewProjectionMatrix * (scale *  vec4 (coord - vec3 (0.5), 1.0) + vec4 (centre, 0.0));
}


