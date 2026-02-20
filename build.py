#!/usr/bin/env python
# -*- coding: utf-8 -*-
# SPDX-License-Identifier: MIT
# Copyright (c) 2025 OpenWG Contributors
"""
XVM Build Orchestrator

Data-driven Python equivalent of build.ps1 + library_*.psm1.
Reads the same JSON config files used by the PowerShell build system,
then delegates tool invocations to build_helpers.sh.

Compatible with Python 2.7+ and Python 3.x.

Requirements (provided by Dockerfile, or install locally):
  - Java 8+           (Apache Royale compiler)
  - Apache Royale 0.9.12
  - Python 2.7        (.pyc compilation)
  - patch, zip, unzip

Usage:
  python build.py                    # Build WG flavor
  python build.py --flavor=lesta     # Build Lesta flavor
  python build.py --flavor=all       # Build both flavors
"""
from __future__ import print_function

import glob
import json
import os
import shutil
import subprocess
import sys


SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
HELPERS = os.path.join(SCRIPT_DIR, 'build_helpers.sh')


# ============================================================================
# Tool discovery
# ============================================================================

def which(name):
    """Find an executable on PATH (Python 2/3 compatible)."""
    for d in os.environ.get('PATH', '').split(os.pathsep):
        p = os.path.join(d, name)
        if os.path.isfile(p) and os.access(p, os.X_OK):
            return p
    return None


def find_royale():
    """Locate the Apache Royale SDK root."""
    candidates = [
        os.environ.get('ROYALE_HOME', ''),
        '/opt/apache-royale/royale-asjs',
        '/opt/apache-royale',
        '/opt/apache-royale-0.9.12-bin-js-swf/royale-asjs',
        '/opt/apache-royale-0.9.12-bin-js-swf',
    ]
    for c in candidates:
        if not c:
            continue
        if os.path.isfile(os.path.join(c, 'js/lib/mxmlc.jar')):
            return c
        sub = os.path.join(c, 'royale-asjs')
        if os.path.isfile(os.path.join(sub, 'js/lib/mxmlc.jar')):
            return sub
    return None


def find_python27():
    """Find a Python 2.7 interpreter."""
    for name in ('python2.7', 'python2', 'python'):
        p = which(name)
        if not p:
            continue
        try:
            ver = subprocess.check_output([p, '--version'],
                                          stderr=subprocess.STDOUT)
            if b'2.7' in ver:
                return p
        except (subprocess.CalledProcessError, OSError):
            continue
    return None


class Tools(object):
    """Resolved build tool paths."""
    def __init__(self):
        if not which('java'):
            fail("'java' not found in PATH")
        if not which('zip'):
            fail("'zip' not found in PATH")
        if not which('patch'):
            fail("'patch' not found in PATH")

        self.royale_home = find_royale()
        if not self.royale_home:
            fail('Apache Royale SDK not found. Set ROYALE_HOME.')

        self.python27 = find_python27()
        if not self.python27:
            fail('Python 2.7 is required for .pyc compilation.')

        self.royale_config = os.path.join(
            SCRIPT_DIR, 'src_build/royale_toolchain/xvm-config.xml')

        self.rabcdasm_dir = os.path.join(
            SCRIPT_DIR, 'src_build/bin/linux_amd64/rabcdasm')
        if os.path.isdir(self.rabcdasm_dir):
            for f in os.listdir(self.rabcdasm_dir):
                fp = os.path.join(self.rabcdasm_dir, f)
                if os.path.isfile(fp):
                    os.chmod(fp, 0o755)


# ============================================================================
# Helpers
# ============================================================================

def fail(msg):
    print('Error: %s' % msg, file=sys.stderr)
    sys.exit(1)


def load_json(path):
    with open(path) as f:
        return json.load(f)


def run_helper(command, args):
    """Call a build_helpers.sh function."""
    cmd = ['bash', HELPERS, command] + args
    subprocess.check_call(cmd)


def substitute(s, flavor, output_dir, src_dir):
    """Replace <FLAVOR>, <OUTPUT>, <SRC> placeholders."""
    return (s.replace('<FLAVOR>', flavor)
             .replace('<OUTPUT>', output_dir)
             .replace('<SRC>', src_dir))


def expand_source_paths(paths, flavor, output_dir, src_dir):
    """Resolve placeholders and expand trailing /* globs."""
    result = []
    for p in paths:
        p = substitute(p, flavor, output_dir, src_dir)
        if p.endswith('/*'):
            base = p[:-2]
            if os.path.isdir(base):
                for name in sorted(os.listdir(base)):
                    full = os.path.join(base, name)
                    if os.path.isdir(full):
                        result.append(full)
            else:
                result.append(p)
        else:
            result.append(p)
    return result


def find_json_files(root, filename):
    """Recursively find all files matching filename under root, sorted."""
    found = []
    for dirpath, _dirnames, filenames in os.walk(root):
        if filename in filenames:
            found.append(os.path.join(dirpath, filename))
    return sorted(found)



# ============================================================================
# Component processors
# ============================================================================

def process_swfpatch(comp_dir, flavor, wotmod_path, tools):
    """Process swfpatch.json files within a component."""
    for spj in find_json_files(comp_dir, 'swfpatch.json'):
        cfg = load_json(spj)
        sp_flavor = cfg.get('flavor', '')
        if sp_flavor and sp_flavor != flavor:
            continue

        sp_dir = os.path.dirname(spj)
        print('    Processing swfpatch (%s): %s' % (flavor, sp_dir))

        for item in cfg.get('build', []):
            swf_file = item.get('file', '')
            if not swf_file:
                continue

            patches_list = item.get('patches', [])
            linkages_list = item.get('linkages', [])
            install_dir = item.get('install_directory', '')

            # Resolve full paths for patches
            full_patches = ','.join(
                os.path.join(sp_dir, p) for p in patches_list)
            linkages = ','.join(linkages_list)

            input_swf = os.path.join(sp_dir, swf_file)
            output_swf = os.path.join(wotmod_path, install_dir,
                                      os.path.basename(swf_file))

            args = [
                '--input-swf', input_swf,
                '--output-swf', output_swf,
                '--patches', full_patches,
                '--linkages', linkages,
                '--rabcdasm-dir', tools.rabcdasm_dir,
            ]
            run_helper('patch_wg_swf', args)


def process_actionscript(comp_dir, flavor, swf_out_dir, wotmod_path, tools):
    """Process actionscript.json files within a component."""
    for asj in sorted(find_json_files(comp_dir, 'actionscript.json')):
        cfg = load_json(asj)
        as_dir = os.path.dirname(asj)

        print('    Processing actionscript: %s' % as_dir)

        for item in cfg.get('build', []):
            # Flavor filter
            item_flavors = item.get('flavors')
            if item_flavors and flavor not in item_flavors:
                continue

            name = item.get('name', '')
            build_type = item.get('type', '')
            if not name or not build_type:
                continue

            # Resolve placeholders
            target = substitute(
                item.get('target', ''), flavor, swf_out_dir, as_dir)
            include_classes = ' '.join(item.get('include_classes', []))
            ext_libs = ','.join(
                substitute(p, flavor, swf_out_dir, as_dir)
                for p in item.get('external_library_path', []))
            inc_libs = ','.join(
                substitute(p, flavor, swf_out_dir, as_dir)
                for p in item.get('include_libraries', []))
            install_dir = substitute(
                item.get('install_directory', ''), flavor, swf_out_dir, as_dir)
            patches = [
                substitute(p, flavor, swf_out_dir, as_dir)
                for p in item.get('patches', [])]

            # source_path: default to {as_dir}/{name}/ if not specified
            raw_sp = item.get('source_path')
            if raw_sp:
                source_paths = expand_source_paths(
                    raw_sp, flavor, swf_out_dir, as_dir)
            else:
                source_paths = [os.path.join(as_dir, name)]
            source_path = ','.join(source_paths)

            if build_type == 'swc':
                outfile = os.path.join(swf_out_dir, 'swc', name + '.swc')
                args = [
                    '--name', name,
                    '--output', outfile,
                    '--include-classes', include_classes,
                    '--source-path', source_path,
                    '--external-library-path', ext_libs,
                    '--include-libraries', inc_libs,
                    '--royale-home', tools.royale_home,
                    '--config', tools.royale_config,
                    '--flavor', flavor,
                ]
                run_helper('build_swc', args)

                # Post-build SWC patches (e.g. xfw_access)
                if patches:
                    run_helper('patch_swc', [
                        '--swc-file', outfile,
                        '--patches', ','.join(patches),
                        '--rabcdasm-dir', tools.rabcdasm_dir,
                    ])

            elif build_type == 'swf':
                outfile = os.path.join(swf_out_dir, 'swf', name + '.swf')
                args = [
                    '--name', name,
                    '--output', outfile,
                    '--target', target,
                    '--source-path', source_path,
                    '--external-library-path', ext_libs,
                    '--include-libraries', inc_libs,
                    '--royale-home', tools.royale_home,
                    '--config', tools.royale_config,
                    '--flavor', flavor,
                ]
                run_helper('build_swf', args)

                # Install SWF to wotmod staging
                if install_dir:
                    dest = os.path.join(wotmod_path, install_dir)
                    if not os.path.isdir(dest):
                        os.makedirs(dest)
                    shutil.copy2(outfile, dest)
                    print('      -> %s/' % install_dir)


def process_python(comp_dir, comp_prefix, wotmod_path, tools):
    """Process python.json files within a component."""
    for pyj in find_json_files(comp_dir, 'python.json'):
        cfg = load_json(pyj)
        py_dir = os.path.dirname(pyj)

        # Resolve install prefix
        install_prefix = cfg.get('install_prefix', '')
        if install_prefix:
            install_prefix = install_prefix.replace(
                '{root}', 'res/mods/openwg_packages/%s/' % comp_prefix)
        else:
            install_prefix = 'res/mods/openwg_packages/%s/' % comp_prefix

        py_out = os.path.join(wotmod_path, install_prefix)

        # Run generators
        for gen_script in cfg.get('generators', []):
            gen_path = os.path.join(py_dir, gen_script)
            if os.path.isfile(gen_path):
                print('    [GEN] %s' % gen_script)
                subprocess.check_call(
                    [tools.python27, gen_path, py_dir, py_out])

        print('    [PY] %s -> %s' % (os.path.basename(py_dir), install_prefix))
        run_helper('compile_python_dir', [
            '--src-dir', py_dir,
            '--dst-dir', py_out,
            '--python27', tools.python27,
        ])


def process_assets(comp_dir, comp_prefix, wotmod_path):
    """Process assets.json files within a component."""
    for aj in find_json_files(comp_dir, 'assets.json'):
        cfg = load_json(aj)
        assets_dir = os.path.dirname(aj)

        install_prefix = cfg.get('install_prefix', 'res/')
        install_prefix = install_prefix.replace(
            '{root}', 'res/mods/openwg_packages/%s/' % comp_prefix)

        dest = os.path.join(wotmod_path, install_prefix)
        if not os.path.isdir(dest):
            os.makedirs(dest)

        count = 0
        for f in sorted(os.listdir(assets_dir)):
            fp = os.path.join(assets_dir, f)
            if not os.path.isfile(fp):
                continue
            if f.endswith('.json'):
                continue
            shutil.copy2(fp, dest)
            count += 1
        print('    [ASSETS] %d files -> %s' % (count, install_prefix))


def generate_package_meta(comp_json_path, version, owg_out):
    """Write package.json metadata and stub __init__.pyc."""
    comp = load_json(comp_json_path)
    comp_id = comp.get('id', '')
    if not comp_id:
        return

    if not os.path.isdir(owg_out):
        os.makedirs(owg_out)

    meta = {
        'id': comp_id,
        'name': '',
        'description': '',
        'version': version,
        'dependencies': comp.get('dependencies', []),
        'features': comp.get('features', []),
        'features_provide': comp.get('features_provide', []),
        'url': '',
        'url_update': '',
        'wot_versions': ['0.0.0.0'],
        'wot_versions_strategy': 'allow_newer',
    }
    meta_path = os.path.join(owg_out, 'package.json')
    with open(meta_path, 'w') as f:
        json.dump(meta, f, indent=4)


def generate_stub_init(owg_out, python27):
    """Generate a stub __init__.pyc if one doesn't exist."""
    init_pyc = os.path.join(owg_out, '__init__.pyc')
    init_py = os.path.join(owg_out, '__init__.py')
    if os.path.exists(init_pyc) or os.path.exists(init_py):
        return

    with open(init_py, 'w') as f:
        f.write("""\
__initialized = False

def owg_module_init():
    global __initialized
    __initialized = True

def owg_module_fini():
    global __initialized
    __initialized = False

def owg_module_loaded():
    global __initialized
    return __initialized

def owg_module_event(eventName, *args, **kwargs):
    pass
""")

    subprocess.check_call([python27, '-m', 'py_compile', init_py])
    os.remove(init_py)


# ============================================================================
# Build pipeline
# ============================================================================

def build_flavor(flavor, tools, version_override=None):
    """Run the full build for a single flavor."""
    if flavor == 'wg':
        pass
    elif flavor == 'lesta':
        pass
    else:
        fail("Unknown flavor '%s'" % flavor)

    src_dir = os.path.join(SCRIPT_DIR, 'src')
    output_dir = os.path.join(SCRIPT_DIR, '~output')

    # Read version from build.json, allow override via --version
    build_cfg = load_json(os.path.join(SCRIPT_DIR, 'build.json'))
    version = version_override or build_cfg.get('game_version_%s' % flavor, '0.0.0')

    # Per-flavor directories
    swf_out_dir = os.path.join(output_dir, 'swf_%s' % flavor)
    wotmod_path = os.path.join(output_dir, 'wotmod')
    deploy_dir = os.path.join(output_dir, 'deploy')

    for d in [swf_out_dir, os.path.join(swf_out_dir, 'swc'),
              os.path.join(swf_out_dir, 'swf'), wotmod_path, deploy_dir]:
        if not os.path.isdir(d):
            os.makedirs(d)

    # Read root package config
    pkg_cfg = load_json(os.path.join(src_dir, 'package.json'))
    pkg_id = pkg_cfg.get('id', 'com.modxvm.xvm')
    pkg_name = pkg_cfg.get('name', 'XVM')

    print('')
    print('=' * 64)
    print('  XVM Build  --  flavor: %s' % flavor)
    print('  Royale:  %s' % tools.royale_home)
    print('  Python:  %s' % tools.python27)
    print('  Output:  %s' % output_dir)
    print('=' * 64)
    print('')

    # Discover components
    print('=== Processing components ===')
    print('')

    for comp_json in find_json_files(src_dir, 'component.json'):
        comp = load_json(comp_json)
        comp_id = comp.get('id', '')
        if not comp_id:
            continue

        comp_dir = os.path.dirname(comp_json)
        comp_prefix = comp.get('prefix', os.path.basename(comp_dir))

        print('  Component: %s' % comp_id)

        owg_out = os.path.join(
            wotmod_path, 'res/mods/openwg_packages', comp_prefix)

        # --- swfpatch ---
        process_swfpatch(comp_dir, flavor, wotmod_path, tools)

        # --- actionscript ---
        process_actionscript(
            comp_dir, flavor, swf_out_dir, wotmod_path, tools)

        # --- python ---
        process_python(comp_dir, comp_prefix, wotmod_path, tools)

        # --- assets ---
        process_assets(comp_dir, comp_prefix, wotmod_path)

        # --- package.json metadata + stub __init__ ---
        generate_package_meta(comp_json, version, owg_out)
        generate_stub_init(owg_out, tools.python27)

        print('')

    # Package .wotmod / .mtmod
    print('=== Packaging ===')

    meta_xml = os.path.join(wotmod_path, 'meta.xml')
    with open(meta_xml, 'w') as f:
        f.write('<root>\n')
        f.write('    <id>%s</id>\n' % pkg_id)
        f.write('    <name>%s</name>\n' % pkg_name)
        f.write('    <description></description>\n')
        f.write('    <version>%s</version>\n' % version)
        f.write('</root>\n')

    ext = 'mtmod' if flavor == 'lesta' else 'wotmod'
    out_file = os.path.join(
        deploy_dir, '%s_%s.%s' % (pkg_id, version, ext))

    run_helper('package_wotmod', [
        '--staging-dir', wotmod_path,
        '--output-file', out_file,
    ])

    size = os.path.getsize(out_file)
    print('')
    print('[DONE] %s  (%d bytes)' % (out_file, size))
    print('')


# ============================================================================
# Main
# ============================================================================

def main():
    flavor = 'wg'
    version_override = None
    for arg in sys.argv[1:]:
        if arg.startswith('--flavor='):
            flavor = arg.split('=', 1)[1]
        elif arg.startswith('--version='):
            version_override = arg.split('=', 1)[1]
        elif arg in ('--help', '-h'):
            print('Usage: python build.py [--flavor=wg|lesta|all] [--version=X.Y.Z]')
            sys.exit(0)
        else:
            fail('Unknown argument: %s' % arg)

    tools = Tools()

    # Clean previous build
    output_dir = os.path.join(SCRIPT_DIR, '~output')
    for d in ('build', 'wotmod', 'deploy'):
        p = os.path.join(output_dir, d)
        if os.path.isdir(p):
            shutil.rmtree(p)

    if flavor == 'all':
        for d in ('swf_wg', 'wotmod'):
            p = os.path.join(output_dir, d)
            if os.path.isdir(p):
                shutil.rmtree(p)
        build_flavor('wg', tools, version_override)

        for d in ('swf_lesta', 'wotmod'):
            p = os.path.join(output_dir, d)
            if os.path.isdir(p):
                shutil.rmtree(p)
        build_flavor('lesta', tools, version_override)

        print('=== Both flavors built ===')
    else:
        build_flavor(flavor, tools, version_override)

    print('=== Build Complete ===')


if __name__ == '__main__':
    main()
