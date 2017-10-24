#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;

out vec4 fragColor;

uniform float a = 1.0 / 9.0;

vec3 colorRed    = vec3 (1.0, 0.0, 0.0);
vec3 colorYellow = vec3 (1.0, 1.0, 0.0);

void main()
{
  vec3 newColor;

  float f = fract (vtexCoord.s);
    
  int i;
  for (i = 0; i < 10; i = i + 2)
  {
    if (f >= i * a && f < (i + 1) * a)
    {
      newColor = colorYellow;
      break;
    }
  }

  if (i > 8) newColor = colorRed;
  
  fragColor = vec4 (newColor, 1.0);
}
