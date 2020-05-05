
def parser_addon(strHTML, dict_macros):
    if not isinstance(strHTML, str):
        return str(strHTML)
    if '{{' in strHTML:
        return _parser(strHTML, dict_macros)
    else:
        return strHTML


def comparing(_macro, _operator, _math):
    if isinstance(_macro, basestring):
        _math = str(_math)
    elif isinstance(_macro, float):
        _math = float(_math)
    elif isinstance(_macro, int):
        _math = int(_math)
    if isinstance(_macro, (float, int)) and isinstance(_math, (float, int)):
        if _operator == '>=':
            return _macro >= _math
        elif _operator == '<=':
            return _macro <= _math
        elif _operator == '!=':
            return _macro != _math
        elif _operator in ('==', '='):
            return _macro == _math
        elif _operator == '<':
            return _macro < _math
        elif _operator == '>':
            return _macro > _math
    elif isinstance(_macro, basestring) and isinstance(_math, basestring):
        if _operator in ('==', '='):
            return _macro == _math
        elif _operator == '!=':
            return _macro != _math
    else:
        return False


FLAG = {'': '>',
        "'": '>',
        '-': '<',
        '+': '+',
        "-'": '<',
        '0': '0',
        "0'": '0',
        "-0": '0<',
        "-0'": '0<',
        "+-": '+<',
        "-+": '+<',
        "-+0": '+0<',
        "+-0": '+0<',
        "+-'": '+0<',
        "-+'": '+0<',
        "+-0'": '+0<',
        "-+0'": '+0<',
        "+'": '+',
        "+0'": '+0',
        '+0': '+0'
        }


def formatMacro(macro, macros):
    _macro = macro[2:-2]
    _macro, s_def, _def = _macro.partition('|')
    _macro, s_rep, _rep = _macro.partition('?')
    fm = {'flag': '', 'type': '', 'width': '', 'suf': '', 'prec': ''}
    _operator = ''
    for s in ('>=', '<=', '!=', '==', '=', '<', '>'):
        if s in _macro:
            _macro, _operator, _math = _macro.partition(s)
            if '@dl' in _math:
                return _macro, True
            break
    _macro, _, fm['suf'] = _macro.partition('~')
    _macro, _, t = _macro.partition('%')
    if t[-1:] in ('s', 'd', 'f', 'x', 'a'):
        fm['type'] = t[-1:]
        t = t[:-1]
    t, _, _prec = t.partition('.')
    _prec = int(_prec) if _prec.isdigit() else ''
    for s in ("-+0'", "+-0'", "-+'", "+-'", "+-0", "-+0", "-0'", "+0'", "-0", "-'", "0'", "+'", "+-", "-+", '+0', '-', '0', "'", '+'):
        if (s in t) and (s[0] == t[0]):
            _, fm['flag'], fm['width'] = t.rpartition(s)
            break
    if not fm['width'] and t.isdigit():
        fm['width'] = int(t)
    if _macro in macros:
        _macro = macros[_macro]
        b = False
        if _operator:
            compar = comparing(_macro, _operator, _math)
            if s_rep and compar:
                _macro = _rep
                b = True
            elif s_def and not compar:
                _macro = _def
                b = True
        elif s_rep and _macro:
            _macro = _rep
            b = True
        elif s_def and not _macro:
            _macro = _def
            b = True
        if not b:
            fm['flag'] = FLAG[fm['flag']]
            if _prec != '':
                if isinstance(_macro, int):
                    _macro = int(_macro) + _prec
                elif isinstance(_macro, float):
                    fm['prec'] = '.' + str(_prec)
                elif isinstance(_macro, basestring):
                    u_macro = unicode(_macro, 'utf8')
                    if len(u_macro) > _prec:
                        if (_prec - len(unicode(fm['suf'], 'utf8'))) > 0:
                            _macro = u_macro[:(_prec - len(fm['suf']))]
                        else:
                            _macro = u_macro[:_prec]
                            fm['suf'] = ''
                    else:
                        fm['suf'] = ''
            if _macro is None:
                _macro = ''
            else:
                _macro = '{0:{flag}{width}{prec}{type}}{suf}'.format(_macro, **fm)
        return str(_macro), False
    else:
        return macro, False


def _parser(strHTML, macros):
    notMacrosDL = {}
    i = 0
    while '{{' in strHTML:
        b = True
        while b:
            b = False
            for s in macros.iterkeys():
                temp_str = '{{%s}}' % s
                if temp_str in strHTML:
                    value = macros.get(s, '')
                    _macro = str(value) if value is not None else ''
                    strHTML = strHTML.replace(temp_str, _macro)
                    b = True
        start = strHTML.rfind('{{')
        end = strHTML.find('}}', start) + 2
        if not ((start >= 0) and (end >= 2)):
            break
        substr = strHTML[start:end]
        for s in macros.iterkeys():
            begin = substr.find(s)
            if (begin == 2) and (substr[(2 + len(s))] in ('?', '%', '|',  '>', '<', '!', '=', '~')):
                _macro, non = formatMacro(substr, macros)
                if non:
                    substr = substr.replace('{{%s' % _macro, '{{%s' % macros[_macro], 1)
                    for s1 in macros.iterkeys():
                        if ('{{%s' % s1) in substr:
                            _macro = substr
                            break
                    else:
                        i += 1
                        _macro = '@dl%s@' % str(i)
                        notMacrosDL[_macro] = substr
                break
        else:
            i += 1
            _macro = '@dl%s@' % str(i)
            notMacrosDL[_macro] = substr
        strHTML = '%s%s%s' % (strHTML[0:start], _macro, strHTML[end:])
    b = (i > 0)
    while b:
        b = False
        _notMacrosDL = notMacrosDL.copy()
        for s in _notMacrosDL:
            if s in strHTML:
                b = True
                strHTML = strHTML.replace(s, notMacrosDL.pop(s, ''), 1)
    return strHTML
