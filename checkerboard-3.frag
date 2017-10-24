#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;

out vec4 fragColor;

uniform float n = 8;

void main()
{

  float tileSize = 1.0 / (n);

  vec3 newColor;
  
  if      (fract (vtexCoord.x / tileSize) < 0.035) newColor = vec3 (0.0, 0.0, 0.0);
  else if (fract (vtexCoord.y / tileSize) < 0.035) newColor = vec3 (0.0, 0.0, 0.0);
  else newColor = vec3 (1.0, 1.0, 1.0);

    
  fragColor = vec4 (newColor, 1.0);
}
