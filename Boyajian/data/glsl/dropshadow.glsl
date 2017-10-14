#ifdef GL_ES
  precision mediump float;
#endif


#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform sampler2D bg;

uniform vec2 texResolution;
uniform vec2 bgResolution;
uniform vec2 bgoffset;

uniform float time;
uniform float xx;
uniform float yy;


varying vec4 vertColor;
varying vec4 vertTexCoord;


void main( )
{
  vec2 uv = vec2( gl_FragCoord.x / bgResolution.x,gl_FragCoord.y / bgResolution.y );
  vec2 uv2 = vec2( gl_FragCoord.x / texResolution.x,gl_FragCoord.y / texResolution.y );
  uv=uv+bgoffset;

  gl_FragColor = texture2D(bg, uv);

  vec4 target;
  for(int i=0;i<10;i++){
    float offset=(1.0-pow(float(i)/10.0,2.0))*2.0;
    target = texture2D(texture, uv2*0.9-vec2((0.01+0.005*offset)*xx, (-0.1+(0.01*offset))*yy));
    gl_FragColor.xyz *= 1. - (.5 * target.a*(i+1.0)/60.0);
  }

  vec4 o = texture2D(texture, uv2);
  gl_FragColor.xyz = mix(gl_FragColor.xyz , o.xyz, o.a);
}
