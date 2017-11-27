#version 330 core

uniform sampler2D colorMap;

in vec4 frontColor;
in vec2 vtexCoord;

out vec4 fragColor;

uniform int tiles = 1;

void main()
{
    fragColor = texture(colorMap, vtexCoord * tiles);
}
