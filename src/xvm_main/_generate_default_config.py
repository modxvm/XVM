#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function

import sys
import os
import io


def python_repr(value):
    if sys.version_info[0] < 3:
        return repr(value)
    if isinstance(value, dict):
        return '{' + ', '.join('{}: {}'.format(python_repr(key), python_repr(item))
                              for key, item in value.items()) + '}'
    if isinstance(value, list):
        return '[' + ', '.join(python_repr(item) for item in value) + ']'
    if isinstance(value, str):
        return 'u' + ascii(value)
    return repr(value)

def main():
    if len(sys.argv) != 3:
        print('Usage: {} <current_location> <output_folder>'.format(sys.argv[0]))
        sys.exit(1)

    current_location = sys.argv[1]
    output_folder = sys.argv[2]

    #print('sys.argv: %s' % sys.argv)
    #print('generate default_config.py and xvm.xc.sample')

    if not os.path.isdir(output_folder):
        os.makedirs(output_folder)

    # Path to JSONxLoader
    sys.path.insert(0, os.path.join(os.path.join(current_location, '../3rdparty/')))
    import JSONxLoader

    # Generate default_config.py
    dc_fn = os.path.join(output_folder, 'default_config.py')
    try:
        cfg_lesta = JSONxLoader.load(os.path.join(current_location, '../../release/configs/default_lesta/@xvm.xc'))
        cfg_wg = JSONxLoader.load(os.path.join(current_location, '../../release/configs/default_wg/@xvm.xc'))
        en = JSONxLoader.load(os.path.join(current_location, '../../release/l10n/en.xc'))
        ru = JSONxLoader.load(os.path.join(current_location, '../../release/l10n/ru.xc'))
        with io.open(dc_fn, 'w', encoding='utf-8', newline='\n') as f:
            f.write(u'# -*- coding: utf-8 -*-\nDEFAULT_CONFIG_LESTA={}\nDEFAULT_CONFIG_WG={}\nLANG_EN={}\nLANG_RU={}'.format(
                python_repr(cfg_lesta), python_repr(cfg_wg), python_repr(en), python_repr(ru)))
    except Exception as e:
        print('Error generating {}: {}'.format(dc_fn, e))
        if os.path.exists(dc_fn):
            os.remove(dc_fn)
        sys.exit(1)

    # Generate default_xvm_xc.py
    xvm_xc_sample_src = os.path.join(current_location, '../../release/configs/xvm.xc.sample')
    xvm_xc_sample_trgt = os.path.join(output_folder, 'default_xvm_xc.py')
    try:
        with io.open(xvm_xc_sample_trgt, 'w', encoding='utf-8', newline='\n') as trgt_file:
            trgt_file.write(u"# -*- coding: utf-8 -*-\n''' Generated automatically by XVM builder '''\nDEFAULT_XVM_XC = '''")
            with io.open(xvm_xc_sample_src, 'r', encoding='utf-8-sig') as src_file:
                trgt_file.write(src_file.read())
            trgt_file.write(u"'''")
    except Exception as e:
        print('Error generating {}: {}'.format(xvm_xc_sample_trgt, e))
        if os.path.exists(xvm_xc_sample_trgt):
            os.remove(xvm_xc_sample_trgt)
        sys.exit(1)

if __name__ == '__main__':
    main()
