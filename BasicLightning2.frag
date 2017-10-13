#version 330 core

in vec4 frontColor;
in vec3 f_normal;
out vec4 fragColor;

void main()
{
	vec3 N = normalize(f_normal);
	fragColor = (frontColor * N.z);
}
