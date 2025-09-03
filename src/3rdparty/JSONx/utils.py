__all__ = ['on', 'when', 'decode_escapes', 'get_dict_path']

import re
import codecs
import copy


ESCAPE_SEQUENCE_RE = re.compile(r'''
    ( \\U........      # 8-digit hex escapes
    | \\u....          # 4-digit hex escapes
    | \\x..            # 2-digit hex escapes
    | \\[0-7]{1,3}     # Octal escapes
    | \\N\{[^}]+\}     # Unicode characters by name
    | \\[\\'"abfnrtv]  # Single-character escapes
    )''', re.UNICODE | re.VERBOSE)


def decode_escapes(s):
    def decode_match(match):
        return codecs.decode(match.group(0), 'unicode-escape')
    return ESCAPE_SEQUENCE_RE.sub(decode_match, s)


def get_dict_path(dic, path):
    def callback(accumulator, key):
        obj, keys = accumulator
        if isinstance(obj, dict):
            if key in obj:
                keys.append(key)
                return obj[key], keys
        path_string = '/'.join(keys)
        raise Exception('Object "./{}" has no key "{}"'.format(path_string, key))

    try:
        path = path.strip(' ./').replace('.', '/')
        if not path:
            return dic, None
        result, _ = reduce(callback, path.split('/'), (dic, []))

        return copy.copy(result), None
    except Exception, e:
        return None, e.message


def get_position(string, index):
    line = string.count('\n', 0, index) + 1
    if line == 1:
        col = index + 1
    else:
        col = index - string.rindex('\n', 0, index)
    return line, col
