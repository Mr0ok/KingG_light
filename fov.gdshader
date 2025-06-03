shader_type canvas_item;

void fragment() {
    // Step 1: Downscale UV to 1/8 resolution
    vec2 downscale_uv = floor(UV * vec2(256) / 8.0) / (vec2(256) / 8.0);

    vec4 color = texture(TEXTURE, downscale_uv);

    if (color.rgb == vec3(0.0)) {
        // Step 2: Check if any neighbor is white
        vec2 offsets[4] = vec2[](
            vec2(-1.0, 0.0), vec2(1.0, 0.0), // Left, Right
            vec2(0.0, -1.0), vec2(0.0, 1.0)  // Top, Bottom
        );

        for (int i = 0; i < 4; i++) {
            vec4 neighbor = texture(TEXTURE, downscale_uv + offsets[i] / (vec2(256) / 8.0));
            if (neighbor.rgb == vec3(1.0)) {
                color.rgb = vec3(1.0); // Stay black
                break;
            }
        }
    }

    float alpha = 1.0 - dot(color.rgb, vec3(1)); // Average grayscale for transparency
	//float alpha = 1.0;





   COLOR = vec4(color.rgb, alpha);
}