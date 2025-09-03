#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function

import sys
import os
import py_compile
import shutil

def main():
    if len(sys.argv) != 3:
        print('Usage: {} <current_location> <output_folder>'.format(sys.argv[0]))
        sys.exit(1)

    current_location = sys.argv[1]
    output_folder = sys.argv[2]

    #print('sys.argv: %s' % sys.argv)
    #print('generate default_config.py and xvm.xc.sample')

    os.makedirs(output_folder)

    # Path to JSONxLoader
    sys.path.insert(0, os.path.join(os.path.join(current_location, '../3rdparty/')))
    import JSONxLoader

    # Generate default_config.py
    dc_fn = os.path.join(output_folder, 'default_config.py')
    try:
        cfg = JSONxLoader.load(os.path.join(os.path.join(current_location, '../../release/'), 'configs/default/@xvm.xc'))
        en = JSONxLoader.load(os.path.join(os.path.join(current_location, '../../release/'), 'l10n/en.xc'))
        ru = JSONxLoader.load(os.path.join(os.path.join(current_location, '../../release/'), 'l10n/ru.xc'))
        with open(dc_fn, 'w') as f:
            f.write('DEFAULT_CONFIG={}\nLANG_EN={}\nLANG_RU={}'.format(cfg, en, ru))
        py_compile.compile(dc_fn)
        if not os.path.exists(dc_fn + 'c'):
            raise Exception('Failed to compile ' + dc_fn)
    except Exception, e:
        print('Error generating {}: {}'.format(dc_fn, e))
        if os.path.exists(dc_fn):
            os.remove(dc_fn)
        sys.exit(1)

    # Generate default_xvm_xc.py
    xvm_xc_sample_src = os.path.join(os.path.join(current_location, '../../release/'), 'configs/xvm.xc.sample')
    xvm_xc_sample_trgt = os.path.join(output_folder, 'default_xvm_xc.py')
    try:
        with open(xvm_xc_sample_trgt, 'w') as trgt_file:
            trgt_file.write("# -*- coding: utf-8 -*-\n''' Generated automatically by XVM builder '''\nDEFAULT_XVM_XC = '''")
            with open(xvm_xc_sample_src, 'r') as src_file:
                shutil.copyfileobj(src_file, trgt_file)
            trgt_file.write("'''")
        py_compile.compile(xvm_xc_sample_trgt)
        if not os.path.exists(xvm_xc_sample_trgt + 'c'):
            raise Exception('Failed to compile ' + xvm_xc_sample_trgt)
    except Exception, e:
        print('Error generating {}: {}'.format(xvm_xc_sample_trgt, e))
        if os.path.exists(xvm_xc_sample_trgt):
            os.remove(xvm_xc_sample_trgt)
        sys.exit(1)

if __name__ == '__main__':
    main()