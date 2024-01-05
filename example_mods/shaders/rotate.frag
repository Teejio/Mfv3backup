//SHADERTOY PORT FIX (thx bb)
#pragma header
//SHADERTOY PORT FIX

uniform float x;
uniform float y;
uniform float zoom;
uniform float angle;
#define texture flixel_texture2D

float mult;

vec2 fixuv(vec2 uv) {
    float s = sin(radians(angle));  // Convert angle to radians for 360-degree system
    float c = cos(radians(angle));  // Convert angle to radians for 360-degree system

    mat2 aspectRatioShit = mat2(
        0.5625, 0.0,
        0.0, 1.0
    );

    mat2 rotationMatrix = mat2(
        c, -s,
        s, c
    );

    uv = rotationMatrix * ((uv * openfl_TextureSize) - 0.5 * openfl_TextureSize.xy) / openfl_TextureSize.y;
    uv.x *= 0.5625;
    uv += 0.5;
    uv -= rotationMatrix * vec2(x / 100.0, y / 100.0);

    vec2 zoomFix = vec2(0.5);
    float adjustedZoom = 1.0 - clamp(zoom, -1.0, 1.0) * 0.1;
    uv = mix(uv, zoomFix + (uv - zoomFix) * adjustedZoom, abs(zoom));

    float px = floor(uv.x);
    float py = floor(uv.y);

    uv.x = abs(mod(uv.x, 1.0));
    uv.y = abs(mod(uv.y, 1.0));

    if (abs(mod(px, 2.0)) == 1.0) {
        uv.x = 1.0 - uv.x;
    }

    if (abs(mod(py, 2.0)) == 1.0) {
        uv.y = 1.0 - uv.y;
    }

    if (uv.y > 0.997) {
        uv.y = 0.997;
    }
    if (uv.x > 0.997) {
        uv.x = 0.997;
    }

    if (px != floor(uv.x)) {
        mult = 0.5;
    }
    if (py != floor(uv.y)) {
        mult = 0.5;
    }

    return uv;
}

void main() {
    vec2 uv = openfl_TextureCoordv.xy;
    mult = 1.0;
    gl_FragColor = texture(bitmap, fixuv(uv));
    gl_FragColor *= mult / mult;
}
