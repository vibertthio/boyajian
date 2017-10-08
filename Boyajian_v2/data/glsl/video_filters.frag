uniform sampler2D texture;
uniform float vol;
uniform float time;
uniform vec2 dimen;

varying vec4 vertColor;
varying vec4 vertTexCoord;


void main(){

  float v=vol;
  float split;

  if(vol>0.2)split=5.0;
  else if(vol>0.25)split=2.0;

  float tt=mod(time, split/2.0);
  vec2 p = vertTexCoord.st;
  vec4 col = texture2D(texture, p);
  //p.x=fract(p.x+vol*0.2);


  if (tt<5.0) {
    //Desaturate
    if (p.x<.2)
    {
    col.rgb = texture2D(texture, floor((gl_FragCoord.xy + .5) / 5.0) * 5.0 / dimen.xy).rgb;

    }
    //Invert
    else if (p.x<.4)
    {
      col = vec4(1.) - texture2D(texture, p);
    }
    //Chromatic aberration
    else if (p.x<.6)
    {
      vec2 offset = vec2(.01, .0);
      col.r = texture2D(texture, p+offset.xy).r;
      col.g = texture2D(texture, p          ).g;
      col.b = texture2D(texture, p+offset.yx).b;
    }
    //Color switching
    else if(p.x<.8)
    {
      col.rgb = texture2D(texture, p).brg;
    }else{

     col = vec4( (col.r+col.g+col.b)/3. );
    }
  } else {
    //Desaturate
    if (p.x<.2)
    {
      col.rgb = texture2D(texture, floor((gl_FragCoord.xy + .5) / 5.0) * 5.0 / dimen.xy).rgb;

    }
    //Invert
    else if (p.x<.4)
    {
		col.rgb = texture2D(texture, p).grb;
    }
    //Chromatic aberration
    else if (p.x<.6)
    {


      vec2 offset = vec2(.01, .0);
      col.r = texture2D(texture, p+offset.xy).g;
      col.g = texture2D(texture, p          ).r;
      col.b = texture2D(texture, p+offset.yx).b;
    }
    //Color switching
    else if(p.x<.8)
    {
      col = vec4( 1.0-(col.r+col.g+col.b)/3. );
    }else{
     col = vec4(1.) - texture2D(texture, p);
    }
  }


  //Line
  if ( (p.x>0.199 && p.x<.201) || (p.x>.399 && p.x<.401) ||  (p.x>.599&&p.x<.601) ||  (p.x>.799 && p.x<.801)  ){
    col = vec4(1.0);  }

  gl_FragColor = col;
}
