#ifdef GL_ES
  precision mediump float;
#endif

#define AMPLITUDE 0.01
#define SPEED 0.05
#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform float time;
uniform float vol;

varying vec4 vertColor;
varying vec4 vertTexCoord;

vec4 rgbShift( in vec2 p , in vec4 shift) {
    shift *= 2.0*shift.w - 1.0;
    vec2 rs = vec2(shift.x,-shift.y);
    vec2 gs = vec2(shift.y,-shift.z);
    vec2 bs = vec2(shift.z,-shift.x);

    float r = texture2D(texture, p+rs, 0.0).x;
    float g = texture2D(texture, p+gs, 0.0).y;
    float b = texture2D(texture, p+bs, 0.0).z;

    return vec4(r,g,b,1.0);
}

vec4 noise( in vec2 p ) {
  float f1 =(fract(sin(dot(p ,vec2(19.1*p.x,181.633*p.y))) * 578.54*p.x));
  float f2 =(fract(sin(dot(p ,vec2(29.2*p.x,32.233*p.y))) * 378.245*p.x));
  float f3 =(fract(sin(dot(p ,vec2(39.3*p.x,44.183*p.y))) * 78.453*p.x));
  float f4 =(fract(sin(dot(p ,vec2(49.5*p.x,52.135*p.y))) * 2378.153*p.x));
  return vec4(fract(f1),fract(f2),fract(f3),fract(f4));
}

vec4 vec4pow( in vec4 v, in float p ) {
    // Don't touch alpha (w), we use it to choose the direction of the shift
    // and we don't want it to go in one direction more often than the other
    return vec4(pow(v.x,p),pow(v.y,p),pow(v.z,p),v.w);
}

void main( void )
{
	  vec2 p = vertTexCoord.st;
    vec4 c = vec4(0.0,0.0,0.0,1.0);

    if(vol>0.88){
      vec4 shift = vec4pow(noise(vec2(SPEED*time,SPEED*time/25.0 )),4.0)
              *vec4(AMPLITUDE,AMPLITUDE,AMPLITUDE,1.0);;
      c = rgbShift(p, shift*1.5);
      gl_FragColor = c;
    }else{
      gl_FragColor=texture2D(texture,p);
    }

}
