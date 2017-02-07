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


def smooth_transition_color(rules, color_100, color_0, percent, maximum=100):
    """
    Function of smooth transition from one color to another.
    :param rules: algorithm of change of color.
    :param color_100: int color if percent == maximum.
    :param color_0: int color if percent == 0.
    :param percent: float current value.
    :param maximum: float maximum value.
    :return: str hex "0xFFFFFF".
    """
    if percent >= maximum:
        return color_100
    if percent <= 0:
        return color_0
    r_0, g_0, b_0 = hex_to_rgb(color_0)
    r_100, g_100, b_100 = hex_to_rgb(color_100)
    r_delta, g_delta, b_delta = (r_100 - r_0, g_100 - g_0, b_100 - b_0)
    sum_rgb = float((- r_delta if r_delta < 0 else r_delta) + (- g_delta if g_delta < 0 else g_delta) + (- b_delta if b_delta < 0 else b_delta))
    r_k = - r_delta / sum_rgb if r_delta < 0 else r_delta / sum_rgb
    g_k = - g_delta / sum_rgb if g_delta < 0 else g_delta / sum_rgb
    b_k = - b_delta / sum_rgb if b_delta < 0 else b_delta / sum_rgb
    k = percent / float(maximum)
    if rules == 'RGB':
        if r_k <= k:
            if (r_k + g_k) <= k:
                return '0x{:06x}'.format(rgb_to_hex(r_100, g_100, int(b_0 + (k - r_k - g_k) * b_delta / b_k)))
            else:
                return '0x{:06x}'.format(rgb_to_hex(r_100, int(g_0 + (k - r_k) * g_delta / g_k), b_0))
        else:
            return '0x{:06x}'.format(rgb_to_hex(int(r_0 + k * r_delta / r_k), g_0, b_0))
    elif rules == 'RBG':
        if r_k <= k:
            if (r_k + b_k) <= k:
                return '0x{:06x}'.format(rgb_to_hex(r_100, int(g_0 + (k - r_k - b_k) * g_delta / g_k), b_100))
            else:
                return '0x{:06x}'.format(rgb_to_hex(r_100, g_0, int(b_0 + (k - r_k) * b_delta / b_k)))
        else:
            return '0x{:06x}'.format(rgb_to_hex(int(r_0 + k * r_delta / r_k), g_0, b_0))
    elif rules == 'GRB':
        if g_k <= k:
            if (g_k + r_k) <= k:
                return '0x{:06x}'.format(rgb_to_hex(r_100, g_100, int(b_0 + (k - r_k - g_k) * b_delta / b_k)))
            else:
                return '0x{:06x}'.format(rgb_to_hex(int(r_0 + (k - g_k) * r_delta / r_k), g_100, b_0))
        else:
            return '0x{:06x}'.format(rgb_to_hex(r_0, int(g_0 + k * g_delta / g_k), b_0))
    elif rules == 'GBR':
        if g_k <= k:
            if (g_k + b_k) <= k:
                return '0x{:06x}'.format(rgb_to_hex(int(r_0 + (k - g_k - b_k) * r_delta / r_k), g_100, b_100))
            else:
                return '0x{:06x}'.format(rgb_to_hex(r_0, g_100, int(b_0 + (k - g_k) * b_delta / b_k)))
        else:
            return '0x{:06x}'.format(rgb_to_hex(r_0, int(g_0 + k * g_delta / g_k), b_0))
    elif rules == 'BRG':
        if b_k <= k:
            if (r_k + b_k) <= k:
                return '0x{:06x}'.format(rgb_to_hex(r_100, int(g_0 + (k - r_k - b_k) * g_delta / g_k), b_100))
            else:
                return '0x{:06x}'.format(rgb_to_hex(int(r_0 + (k - b_k) * r_delta / r_k), g_0, b_100))
        else:
            return '0x{:06x}'.format(rgb_to_hex(r_0, g_0, int(b_0 + k * b_delta / b_k)))
    elif rules == 'BGR':
        if b_k <= k:
            if (g_k + b_k) <= k:
                return '0x{:06x}'.format(rgb_to_hex(int(r_0 + (k - g_k - b_k) * r_delta / r_k), g_100, b_100))
            else:
                return '0x{:06x}'.format(rgb_to_hex(r_0, int(g_0 + (k - b_k) * g_delta / g_k), b_100))
        else:
            return '0x{:06x}'.format(rgb_to_hex(r_0, g_0, int(b_0 + k * b_delta / b_k)))
