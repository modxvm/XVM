import xvm_main.python.config as config

def brighten_color(color, percent):
    r, g, b = hex_to_rgb(color)
    percent /= 100.0
    r += (255 - r) * percent
    b += (255 - b) * percent
    g += (255 - g) * percent
    return rgb_to_hex(int(r), int(g), int(b))

def hex_to_rgb(value):
    return ((value & 0xff0000) >> 16, (value & 0x00ff00) >> 8, value & 0x0000ff)

def rgb_to_hex(r, g, b):
    return r << 16 | g << 8 | b


def arabic_to_roman(data):
    """
    Convert a number written in Arabic numerals to Roman numerals.
    :param data: int or str number written in Arabic numerals
    :return: str number written in Roman numerals
    """
    if isinstance(data, basestring) and data.isdigit():
        data = int(data)
    if isinstance(data, int) and 0 < data < 4000:
        ones = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
        tens = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
        hounds = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]
        thous = ["", "M", "MM", "MMM"]

        t = thous[data // 1000]
        h = hounds[data // 100 % 10]
        te = tens[data // 10 % 10]
        o = ones[data % 10]

        return "%s%s%s%s" % (t, h, te, o)
    return ""


def smooth_transition_color(rules, color_100, color_0, percent, maximum=100):
    """
    Function of smooth transition from one color to another.
    :param rules: algorithm of change of color.
    :param color_100: int color if percent == maximum.
    :param color_0: int color if percent == 0.
    :param percent: float current value.
    :param maximum: float maximum value.
    :return: str hex "FFFFFF".
    """
    if percent >= maximum:
        return '{:06x}'.format(color_100)
    if percent <= 0:
        return '{:06x}'.format(color_0)
    r_0, g_0, b_0 = hex_to_rgb(color_0)
    r_100, g_100, b_100 = hex_to_rgb(color_100)
    r_delta, g_delta, b_delta = (r_100 - r_0, g_100 - g_0, b_100 - b_0)
    sum_rgb = float((- r_delta if r_delta < 0 else r_delta) + (- g_delta if g_delta < 0 else g_delta) + (- b_delta if b_delta < 0 else b_delta))
    if sum_rgb == 0:
        return '{:06x}'.format(color_0)
    r_k = - r_delta / sum_rgb if r_delta < 0 else r_delta / sum_rgb
    g_k = - g_delta / sum_rgb if g_delta < 0 else g_delta / sum_rgb
    b_k = - b_delta / sum_rgb if b_delta < 0 else b_delta / sum_rgb
    k = percent / float(maximum)
    if rules == 'RGB':
        if r_k <= k:
            if (r_k + g_k) <= k:
                return '{:06x}'.format(rgb_to_hex(r_100, g_100, int(b_0 + (k - r_k - g_k) * b_delta / b_k)))
            else:
                return '{:06x}'.format(rgb_to_hex(r_100, int(g_0 + (k - r_k) * g_delta / g_k), b_0))
        else:
            return '{:06x}'.format(rgb_to_hex(int(r_0 + k * r_delta / r_k), g_0, b_0))
    elif rules == 'RBG':
        if r_k <= k:
            if (r_k + b_k) <= k:
                return '{:06x}'.format(rgb_to_hex(r_100, int(g_0 + (k - r_k - b_k) * g_delta / g_k), b_100))
            else:
                return '{:06x}'.format(rgb_to_hex(r_100, g_0, int(b_0 + (k - r_k) * b_delta / b_k)))
        else:
            return '{:06x}'.format(rgb_to_hex(int(r_0 + k * r_delta / r_k), g_0, b_0))
    elif rules == 'GRB':
        if g_k <= k:
            if (g_k + r_k) <= k:
                return '{:06x}'.format(rgb_to_hex(r_100, g_100, int(b_0 + (k - r_k - g_k) * b_delta / b_k)))
            else:
                return '{:06x}'.format(rgb_to_hex(int(r_0 + (k - g_k) * r_delta / r_k), g_100, b_0))
        else:
            return '{:06x}'.format(rgb_to_hex(r_0, int(g_0 + k * g_delta / g_k), b_0))
    elif rules == 'GBR':
        if g_k <= k:
            if (g_k + b_k) <= k:
                return '{:06x}'.format(rgb_to_hex(int(r_0 + (k - g_k - b_k) * r_delta / r_k), g_100, b_100))
            else:
                return '{:06x}'.format(rgb_to_hex(r_0, g_100, int(b_0 + (k - g_k) * b_delta / b_k)))
        else:
            return '{:06x}'.format(rgb_to_hex(r_0, int(g_0 + k * g_delta / g_k), b_0))
    elif rules == 'BRG':
        if b_k <= k:
            if (r_k + b_k) <= k:
                return '{:06x}'.format(rgb_to_hex(r_100, int(g_0 + (k - r_k - b_k) * g_delta / g_k), b_100))
            else:
                return '{:06x}'.format(rgb_to_hex(int(r_0 + (k - b_k) * r_delta / r_k), g_0, b_100))
        else:
            return '{:06x}'.format(rgb_to_hex(r_0, g_0, int(b_0 + k * b_delta / b_k)))
    elif rules == 'BGR':
        if b_k <= k:
            if (g_k + b_k) <= k:
                return '{:06x}'.format(rgb_to_hex(int(r_0 + (k - g_k - b_k) * r_delta / r_k), g_100, b_100))
            else:
                return '{:06x}'.format(rgb_to_hex(r_0, int(g_0 + (k - b_k) * g_delta / g_k), b_100))
        else:
            return '{:06x}'.format(rgb_to_hex(r_0, g_0, int(b_0 + k * b_delta / b_k)))


def dynamic_color_rating(rating, value):
    """
    Dynamic color by various statistical parameters. (file color.xc)
    :param rating: str the name of dynamic color from the color.xc file.
    :param value: int value.
    :return: str hex "FFFFFF".
    """
    colors = config.get('colors')
    rating = 'x' if rating in ['xeff', 'xte', 'xeff', 'xwtr', 'xwn8', 'xwgr', 'xtdb'] else rating
    if (rating not in colors) or (value is None):
        return
    l = []
    l.append({'value': colors[rating][0]['value'] / 2.0, 'color': colors[rating][0]['color']})
    i = 1
    last = len(colors[rating]) - 1
    while i < last:
        l.append({'value': (colors[rating][i]['value'] + colors[rating][i - 1]['value']) / 2.0,
                  'color': colors[rating][i]['color']})
        i += 1
    if colors[rating][last - 1]['value'] > value >= l[len(l) - 1]['value']:
        return colors[rating][last - 1]['color'][2:]
    elif colors[rating][last - 1]['value'] <= value:
        return colors[rating][last]['color'][2:]
    r_c = colors[rating][last - 1]['color']
    r_v = colors[rating][last - 1]['value']
    for v in reversed(l):
        if value > v['value']:
            l_c = v['color']
            l_v = v['value']
            return smooth_transition_color('BGR', int(r_c, 16), int(l_c, 16), (value - l_v), (r_v - l_v))
        else:
            r_c = v['color']
            r_v = v['value']
    return l[0]['color'][2:]

def color_rating(rating, value):
    """
    Dynamic color by various statistical parameters. (file color.xc)
    :param rating: str the name of dynamic color from the color.xc file.
    :param value: int value.
    :return: str hex "FFFFFF".
    """
    colors = config.get('colors')
    rating = 'x' if rating in ['xeff', 'xte', 'xeff', 'xwtr', 'xwn8', 'xwgr', 'xtdb'] else rating
    if (rating not in colors) or (value is None):
        return
    for v in colors[rating]:
        if v['value'] > value:
            return v['color'][2:]
    l = len(colors[rating]) - 1
    return colors[rating][l].get('color'[2:])
