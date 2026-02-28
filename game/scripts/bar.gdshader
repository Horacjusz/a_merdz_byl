shader_type canvas_item;

uniform float clip_y = 0.0;

varying float world_y;

void vertex() {
    vec4 world_pos = MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0);
    world_y = world_pos.y;
}

void fragment() {
    vec4 c = texture(TEXTURE, UV) * COLOR;

    // Hide pixels BELOW clip_y:
    if (world_y > clip_y) {
        c.a = 0.0;
    }

    COLOR = c;
}