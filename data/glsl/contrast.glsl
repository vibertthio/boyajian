#ifdef GL_ES
  precision mediump float;
#endif

uniform sampler2D texture;
uniform vec2 vel;
varying vec4 vertColor;
varying vec4 vertTexCoord;

#define PROCESSING_TEXTURE_SHADER

vec4 contrast(vec4 colors, float contrast){
  colors.rgb /= colors.a;
  colors.rgb = ((colors.rgb - 0.5) * max(contrast + 1.0, 0.0)) + 0.5;
  colors.rgb *= colors.a;
  return colors;
}

vec4 brightness(vec4 colors, float brightness){
  colors.rgb /= colors.a;
  colors.rgb += brightness;
  colors.rgb *= colors.a;
  return colors;
}

void main( )
{
	vec2 uv = vertTexCoord.st;
	vec4 colors = texture2D(texture,uv);
	float ratioBrigthness =  vel.x;
	float ratioContrast = vel.y;

    gl_FragColor = brightness(contrast(colors,ratioContrast),ratioBrigthness);


}
