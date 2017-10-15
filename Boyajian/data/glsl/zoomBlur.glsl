uniform float     time;
uniform sampler2D texture;
uniform float vol;

uniform vec3  pos;

varying vec4 vertColor;
varying vec4 vertTexCoord;


vec3 deform(vec2 p )
{
  vec2 uv;

 vec2 q = vec2( sin(1.1*time+p.x),sin(1.2*time+p.y) );

 float a = atan(q.y,q.x);
 float r = sqrt(dot(q,q));

 uv.x = sin(time)*0.3+sin(1.0)+p.x*sqrt(r*r+1.0);
 uv.y = sin(time)*0.2+sin(1.0)+p.y*sqrt(r*r+1.0);

 return texture2D(texture,uv*.5).xyz;
}

void main(void)
{
    float vv=vol;
    vec2 p = vec2(vertTexCoord.st)*2.0-vec2(1.0 ,1.0);
    vec2 s = p;

    vec3 total = vec3(0.0);
     vec2 d = (vec2(0.0,0.0)-p)/64.0;
    float w = 1.0;
    for( int i=0; i<64; i++ )
    {
        vec3 res = deform(s);
        res = smoothstep(0.0,1.0,res);
        total += w*res;
        w *= .99;
        s += d;
    }
    total /= 30.0;
    float r = 1.5/(1.0+dot(p,p));

	 gl_FragColor = vec4( total*r,1.0);
}
