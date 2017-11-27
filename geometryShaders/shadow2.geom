#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

uniform mat4 modelViewProjectionMatrix;

vec4 colorBlack = vec4 (0.0, 0.0, 0.0, 1.0);
vec4 colorCian  = vec4 (0.0, 1.0, 1.0, 1.0);

void main( void )
{
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];

		gl_Position = modelViewProjectionMatrix * gl_in[i].gl_Position;
		EmitVertex();
	}
	EndPrimitive();

	// shadow
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = colorBlack;

		vec4 pos = gl_in[i].gl_Position;	
		pos.y  = boundingBoxMin.y;

		gl_Position = modelViewProjectionMatrix * pos;
		EmitVertex();
	}
	EndPrimitive();
	
	// plane
	if (gl_PrimitiveIDIn == 0)
	{
		vec3 center = (boundingBoxMin + boundingBoxMax) / 2.0;
		center.y = boundingBoxMin.y - 0.005;

		float R = distance (boundingBoxMax, boundingBoxMin) / 2.0;

		// generate plane
		vec3 planePos[4];
		planePos[0] = center + vec3 (R, 0.0, R);
		planePos[1] = center + vec3 (R, 0.0, -R);
		planePos[2] = center + vec3 (-R, 0.0, R);
		planePos[3] = center + vec3 (-R, 0.0, -R);
		for( int i = 0 ; i < 4 ; i++ )
		{
			gfrontColor = colorCian;

			vec4 pos = vec4 (planePos[i], 1.0);
			gl_Position = modelViewProjectionMatrix * pos;
			EmitVertex();
		}
		EndPrimitive();
	}

}
