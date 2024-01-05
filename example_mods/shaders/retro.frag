#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

#define PER_CHANNEL

//Original Link: https://www.shadertoy.com/view/WdjGWy

// Triangle Wave
float T(float z) {
    return z >= 0.5 ? 2. - 2. * z : 2. * z;
}

// R dither mask
float intensity(ivec2 pixel) {
    const float a1 = 0.75487766624669276;
    const float a2 = 0.569840290998;
    return fract(a1 * float(pixel.x) + a2 * float(pixel.y));
}

float dither(float gray, int ng) {
    // Calculated noised gray value
    float noised = (2. / float(ng)) * T((intensity(ivec2(gl_FragCoord.xy)))) + gray - (1. / float(ng));
    // Clamp to the number of gray levels we want
    return clamp(floor(float(ng) * noised) / (float(ng) - 1.), 0., 1.);
}

void mainImage()
{
    const int ng = 7; // Number of gray levels to use
    
    vec2 uv = fragCoord / iResolution.xy;
    vec3 tsample = pow(texture(iChannel0, uv).rgb, vec3(2.2));
    
    #ifdef PER_CHANNEL
    	vec3 col = vec3(dither(tsample.r, ng),
			 		    dither(tsample.g, ng),
             			dither(tsample.b, ng));
    #else
        vec3 col = vec3(dither(dot(tsample, vec3(0.3, 0.59, 0.11)), ng));
    #endif

    vec4 base = flixel_texture2D(bitmap, openfl_TextureCoordv.xy);
    // Output to screen, gamma corrected
    fragColor = vec4(vec3(pow(col, vec3(1. / 2.2))), base.a);
}