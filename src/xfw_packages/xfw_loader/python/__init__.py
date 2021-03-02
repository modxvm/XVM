"""
This file is part of the XVM Framework project.

Copyright (c) 2013-2021 XVM Team.

XVM Framework is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, version 3.

XVM Framework is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
"""

#Python
import compileall
import glob
import json
import importlib
import logging
import platform
import re
import sys
import traceback

#BigWorld
import ResMgr
from helpers import VERSION_FILE_PATH

#XFW
import xfw_vfs as vfs
from dag import DAG, DAGValidationError

#Exports
__all__ = [
    'XFWLOADER_PATH_TO_ROOT',
    'XFWLOADER_PACKAGES_REALFS',
    'XFWLOADER_PACKAGES_VFS',
    'XFWLOADER_TEMPDIR',
    'WOT_RESMODS_DIR',
    'WOT_VERSION_FULL',
    'WOT_VERSION_SHORT',

    'get_client_realm'

    'get_mod_directory_name',
    'get_mod_directory_path',
    'get_mod_user_data'
    'get_mod_module',
    'get_mod_ids',

    'is_mod_exists',
    'is_mod_in_realfs',
    'is_mod_loaded'
]

#####################################################

### PUBLIC CONSTANTS
XFWLOADER_PATH_TO_ROOT    = None
XFWLOADER_PACKAGES_REALFS = None
XFWLOADER_PACKAGES_VFS    = None
XFWLOADER_TEMPDIR         = None

WOT_RESMODS_DIR = None
WOT_VERSION_FULL = None
WOT_VERSION_SHORT = None


#### PRIVATE VARIABLES
mods          = dict()
mods_failed   = list()
mods_loaded   = list()


#### PUBLIC FUNCTIONS

def get_client_realm():
    return importlib.import_module('constants').AUTH_REALM

def get_mod_directory_name(mod_name):
    if mod_name not in mods:
        return None
    return mods[mod_name]['dir_name']

def get_mod_directory_path(mod_name):
    if mod_name not in mods:
        return None
    return mods[mod_name]['dir_path']

def get_mod_user_data(package_id, var_id):
    if package_id not in mods:
        return None

    if 'user_data' not in mods[package_id]:
        return None

    if var_id not in mods[package_id]['user_data']:
        return None

    return mods[package_id]['user_data'][var_id]


def get_mod_module(mod_name):
    if mod_name not in mods_loaded:
        return None
    return importlib.import_module('%s.python' % mods[mod_name]['dir_name'])

def get_mod_ids():
    result = dict()
    for mod_id, mod_config in mods.iteritems():
        result[mod_id] = mod_config['version']
    return result

def is_mod_exists(mod_name):
    return mod_name in mods

def is_mod_loaded(mod_name):
    return mod_name in mods_loaded

def is_mod_in_realfs(mod_name):
    if mod_name not in mods:
        return False

    return mods[mod_name]['fs'] == 'realfs'


#####################################################

# Helper functions

def __get_keys_by_mask(dict, mask):
    keys_found = list()

    prefix = mask.split('*', 1)[0]
    for key in dict:
        if key.startswith(prefix):
            keys_found.append(key)

    return keys_found

def __compare_versions(version1, version2):
    def normalize(v):
        return [int(x) for x in re.sub(r'(\.0+)*$','', v.split(" ", 1)[0]).split(".")]
    return cmp(normalize(version1), normalize(version2))


# Read FS

def __read_realfs():
    """
    fills mods list with modifications in realfs
    path to search: [WoT]/res_mods/mods/xfw_packages/*/xfw_package.json
    """
    m_configs = [i.replace("\\", "/").replace("//", "/") for i in glob.iglob(XFWLOADER_PACKAGES_REALFS + '/*/xfw_package.json')]
    for m_config in m_configs:
        m_dir = m_config[0:m_config.rfind("/")] # module directory

        try:
            with open(m_config) as m_config_f:
                data = json.load(m_config_f)

                if data['id'] in mods.keys():
                    logging.warning("[XFW/Loader] [RealFS]: mod '%s' was already found" % data['id'])
                    logging.warning("                       current location  : %s" % m_dir)
                    logging.warning("                       imported location : %s" % mods[data['id']]['dir_path'])
                else:
                    mods[data['id']] = data
                    mods[data['id']]['fs'] = 'realfs'
                    mods[data['id']]['dir_path'] = m_dir
                    mods[data['id']]['dir_name'] = m_dir[m_dir.rfind("/")+1:]

        except Exception:
            logging.exception("[XFW/Loader] [RealFS] Could not parse config for directory '%s'" % m_dir)


def __read_vfs():
    """
    fills mods list with  modifications in vfs
    path to search: [VFS_root]/mods/xfw_packages/*/xfw_package.json
    """

    for m_dir_name in vfs.directory_list_subdirs(XFWLOADER_PACKAGES_VFS):
        try:
            m_dir = XFWLOADER_PACKAGES_VFS + '/' + m_dir_name

            mod_config = vfs.file_read(m_dir + '/xfw_package.json', True)
            if mod_config is not None:
                data = json.loads(mod_config)

                if data['id'] in mods.keys():
                    logging.warning("[XFW/Loader] [VFS] Error: mod '%s' was already found" % data['id'])
                    logging.warning("                   current location  : %s" % m_dir)
                    logging.warning("                   imported location : %s" % mods[data['id']]['dir_path'])
                else:
                    mods[data['id']] = data
                    mods[data['id']]['fs'] = 'vfs'
                    mods[data['id']]['dir_path'] = m_dir
                    mods[data['id']]['dir_name'] = m_dir_name

        except Exception:
            logging.exception("[XFW/Loader] [VFS] Could not parse config for directory '%s'" % m_dir)


# process DAG

def __dag_add_edge(dag, u, v):
    try:
        dag.add_node_if_not_exists(u)
        dag.add_node_if_not_exists(v)
        dag.add_edge(u, v)
    except DAGValidationError:
        return False

    return True

def __dag_build(mods, mods_features):
    dag = DAG()

    for mod_id, mod_config in mods.iteritems():
        dependency_added = False

        #dependencies
        if 'dependencies' in mod_config:
            for dependency in mod_config['dependencies']:
                result = __dag_add_edge(dag, dependency, mod_id)
                if result:
                    dependency_added = True

        #features
        if 'features' in mod_config:
            for feature in mod_config['features']:
                if feature in mods_features:
                    result = __dag_add_edge(dag, mods_features[feature], mod_id)
                    if result:
                        dependency_added = True

        if not dependency_added:
            __dag_add_edge(dag, 'root', mod_id)

        #optional dependencies
        if 'dependencies_optional' in mod_config:
            for dependency in mod_config['dependencies_optional']:
                if '*' in dependency:
                    for dependency in __get_keys_by_mask(mods, dependency):
                        __dag_add_edge(dag, dependency, mod_id)
                else:
                    __dag_add_edge(dag, dependency, mod_id)

    return dag


## Public


def init(path_to_root):
    '''
    Fills path and version constants in xfw.constants
    '''

    global XFWLOADER_PATH_TO_ROOT
    XFWLOADER_PATH_TO_ROOT = '' if path_to_root in ['.', './'] else path_to_root

    global XFWLOADER_PACKAGES_REALFS
    XFWLOADER_PACKAGES_REALFS = XFWLOADER_PATH_TO_ROOT + u'res_mods/mods/xfw_packages'

    global XFWLOADER_PACKAGES_VFS
    XFWLOADER_PACKAGES_VFS = u'mods/xfw_packages'

    global XFWLOADER_TEMPDIR
    XFWLOADER_TEMPDIR = XFWLOADER_PATH_TO_ROOT + u'mods/temp'

    # "../res_mods/0.9.20.1/""
    global WOT_RESMODS_DIR
    WOT_RESMODS_DIR = XFWLOADER_PATH_TO_ROOT + ResMgr.openSection('../paths.xml')['Paths'].values()[0].asString.lstrip('./')

    # ver =
    #   * 'v.0.8.7'
    #   * 'v.0.8.7 #512'
    #   * 'v.0.8.7 Common Test #499'
    #   * 'Supertest v.ST 0.9.15.1 #366'
    #   * 'Supertest v.1.5.1.0 #546'
    ver = ResMgr.openSection(VERSION_FILE_PATH).readString('version')
    if 'Supertest v.ST' in ver:
        tokens = ver.split(" ", 2)
        ver = tokens[2] + ' ' + tokens[1]
    elif 'Supertest v.' in ver:
        tokens = ver.split(' ', 1)
        ver = '%s %s' % (tokens[1][2:tokens[1].index('#') - 1], tokens[0])
    elif '#' in ver:
        ver = ver[2:ver.index('#') - 1]
    else:
        ver = ver[2:]

    short_ver = ver if not ' ' in ver else ver[:ver.index(' ')]  # X.Y.Z or X.Y.Z.a

    global WOT_VERSION_FULL
    WOT_VERSION_FULL = ver

    global WOT_VERSION_SHORT
    WOT_VERSION_SHORT = short_ver

## Mods loading

__are_mods_loaded = False

def mods_load():
    """
    Loads XFW-powered mods from work_folder
    """

    #set globals
    global mods
    global mods_failed
    global mods_loaded
    global __are_mods_loaded

    #check that we are not loading mods second time
    if __are_mods_loaded:
        logging.error("[XFW/Loader]: Mods were already loaded")
        return

    #read FS
    __read_realfs()
    __read_vfs()

    #update path
    sys.path.insert(0, XFWLOADER_PACKAGES_VFS)
    sys.path.insert(0, XFWLOADER_PACKAGES_REALFS)

    if not any(mods):
        logging.warning("[XFW/Loader]: No mods were found")
        return

    #parse features
    mods_features = dict()
    for mod_id, mod_config in mods.iteritems():
        if 'features_provide' in mod_config:
            for provided_feature in mod_config['features_provide']:
                mods_features[provided_feature] = mod_id


    #build DAG
    mods_dag = __dag_build(mods, mods_features)

    # load modifications in topological order
    for mod_name in mods_dag.topological_sort():
        if mod_name == "root":
            continue

        #validate:
        if mod_name not in mods:
            logging.warning("[XFW/Loader] Error with mod: '%s'. Mod not found" % mod_name)
            mods_failed.append(mod_name)
            continue

        if mod_name in mods_failed:
            logging.warning("[XFW/Loader] Error with mod: '%s'. Mod was marked as failed" % mod_name)
            continue

        mod = mods[mod_name]
        if mod is None:
            logging.warning("[XFW/Loader] Error with mod: '%s'. Mod info object is None" % mod_name)
            mods_failed.append(mod_name)
            continue

        #check version
        if 'wot_version_min' in mod and len(mod['wot_version_min']) > 0:
            compare_result = __compare_versions(WOT_VERSION_SHORT, mod['wot_version_min'])
            if compare_result < 0:
                logging.warning("[XFW/Loader] Error with mod: '%s'. Client version is lower than required: current: '%s', required: '%s'" % (mod_name, WOT_VERSION_SHORT, mod['wot_version_min']))
                mods_failed.append(mod_name)
                continue

            if compare_result > 0 and 'wot_version_exactmatch' in mod and mod['wot_version_exactmatch'] == True:
                logging.warning("[XFW/Loader] Error with mod: '%s'. Client version is higher than required: current: '%s', required: '%s'" % (mod_name, WOT_VERSION_SHORT, mod['wot_version_min']))
                mods_failed.append(mod_name)
                continue

        #Check architecture
        failed = False
        if 'architecture' in mod:
            failed = True
            for arch in mod['architecture']:
                if arch == platform.architecture()[0]:
                    failed = False

        if failed == True:
            logging.warning("[XFW/Loader] Error with mod: '%s'. Current architecture is not supported: '%s'" % (mod_name, platform.architecture()[0]))
            mods_failed.append(mod_name)
            continue

        #check features
        failed = False
        if 'features' in mod:
            for feature in mod['features']:
                #python feature is always available
                if feature == 'python':
                    continue

                if feature not in mods_features:
                    logging.warning("[XFW/Loader] Error with mod: '%s'. Feature not found: '%s'" % (mod_name, feature))
                    failed = True
                    continue

                if mods_features[feature] == mod_name:
                    continue

                if mods_features[feature] in mods_failed:
                    logging.warning("[XFW/Loader] Error with mod: '%s'. Feature failed: '%s' in package '%s'" % (mod_name, feature, mods_features[feature]))
                    failed = True

        if failed == True:
            mods_failed.append(mod_name)
            continue

        #check dependencies
        if 'dependencies' in mod:
            for dependency in mod['dependencies']:
                if dependency not in mods:
                    logging.warning("[XFW/Loader] Error with mod: '%s'. Dependency not found: '%s'" % (mod_name, dependency))
                    failed = True
                    continue

                if dependency in mods_failed:
                    logging.warning("[XFW/Loader] Error with mod: '%s'. Dependency failed: '%s'" % (mod_name, dependency))
                    failed = True

        if failed == True:
            mods_failed.append(mod_name)
            continue

        #load
        logging.info("[XFW/Loader] Loading mod: %s, v. %s" % (mod_name, mod['version']))

        #check for features
        if 'features' in mod:

            #load python feature
            if 'python' in mod['features']:
                try:
                    if mod['fs'] == 'realfs':
                        open(mod['dir_path'] + '/__init__.py', 'a').close()
                        compileall.compile_dir(mod['dir_path'], quiet = 1)

                    #try to load module
                    module = importlib.import_module('%s.python' % mod['dir_name'])

                    #call `xfw_module_init()`
                    if hasattr(module, 'xfw_module_init'):
                        module.xfw_module_init()

                    #check xfw_is_module_loaded() function if module provides it
                    if hasattr(module, 'xfw_is_module_loaded'):
                        if not module.xfw_is_module_loaded():
                            logging.error("[XFW/Loader] Loading mod: '%s' FAILED (flag)" % mod_name)
                            failed = True

                except Exception:
                    logging.exception("[XFW/Loader] Loading mod: '%s' FAILED (exception)" % mod_name)
                    failed = True


        #add mod to loaded list
        if not failed:
            mods_loaded.append(mod_name)
        else:
            mods_failed.append(mod_name)

    __are_mods_loaded = True
