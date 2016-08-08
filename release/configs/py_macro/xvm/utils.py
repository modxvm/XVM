import struct

def brighten_color(color, percent):
    r, g, b = hex_to_rgb(color)
    percent /= 100.0
    r += (255 - r) * percent;
    b += (255 - b) * percent;
    g += (255 - g) * percent;
    return rgb_to_hex(int(r), int(g), int(b))

def hex_to_rgb(value):
    return ((value & 0xff0000) >> 16, (value & 0x00ff00) >> 8, value & 0x0000ff)

def rgb_to_hex(r, g, b):
    return r << 16 | g << 8 | b
