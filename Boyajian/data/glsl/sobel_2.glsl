uniform sampler2D texture;
uniform vec2 resolution;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float vol ;
uniform float time;

void main()
{
		//float t=abs(fract(time)-0.5)+0.5;
		vec2 uv=(vertTexCoord.st);
		float v=vol;
		float t=time;
		float target=2.0*abs(fract(time*0.5)-0.5)+1.0-vol;

    //gl_FragColor = 4.*abs(fwidth(texture2D(texture, uv)));

    vec3 TL = texture2D(texture, uv + vec2(-target, target)/ resolution.xy).rgb;
    vec3 TM = texture2D(texture, uv + vec2(0, target)/ resolution.xy).rgb;
    vec3 TR = texture2D(texture, uv + vec2(target, target)/ resolution.xy).rgb;

    vec3 ML = texture2D(texture, uv + vec2(-target, 0)/ resolution.xy).rgb;
    vec3 MR = texture2D(texture, uv + vec2(target, 0)/ resolution.xy).rgb;

    vec3 BL = texture2D(texture, uv + vec2(-target, -target)/ resolution.xy).rgb;
    vec3 BM = texture2D(texture, uv + vec2(0, -target)/ resolution.xy).rgb;
    vec3 BR = texture2D(texture, uv + vec2(target, -target)/ resolution.xy).rgb;

    vec3 GradX = -TL + TR - 2.0 * ML + 2.0 * MR - BL + BR;
    vec3 GradY = TL + 2.0 * TM + TR - BL - 2.0 * BM - BR;


   /* vec2 gradCombo = vec2(GradX.r, GradY.r) + vec2(GradX.g, GradY.g) + vec2(GradX.b, GradY.b);

    gl_FragColor = vec4(gradCombo.r, gradCombo.g, 0, target);*/

    gl_FragColor.r = length(vec2(GradX.r, GradY.r));
    gl_FragColor.g = length(vec2(GradX.g, GradY.g));
    gl_FragColor.b = length(vec2(GradX.b, GradY.b));
		gl_FragColor.a = 1.0;
}
