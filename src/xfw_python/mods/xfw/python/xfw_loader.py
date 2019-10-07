"""
This file is part of the XVM Framework project.

Copyright (c) 2013-2019 XVM Team.

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

import compileall
import glob
import json
import logging
import os
import sys
import shutil
import traceback

import ResMgr
from helpers import VERSION_FILE_PATH

import xfw
import xfw.vfs as vfs
import xfw.utils as utils
from xfw.constants import PATH, VERSION

from dag import DAG, DAGValidationError

##### xfw initializers

def xfw_initialize_constants():
    '''
    Fills path and version constants in xfw.constants
    '''

    # "../res_mods/0.9.20.1/""
    PATH.WOT_RESMODS_DIR = '../%s' % ResMgr.openSection('../paths.xml')['Paths'].values()[0].asString.lstrip('./')

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

    VERSION.WOT_VERSION_FULL = ver
    VERSION.WOT_VERSION_SHORT = short_ver

##### mod loader

mods = dict()
mods_features = dict()
mods_failed = list()
mods_dag = DAG()

## read

def xfw_mods_read_realfs():
    """
    fills mods list with modifications in realfs
    path to search: [WoT]/res_mods/mods/xfw_packages/*/xfw_package.json
    """
    m_configs = [i.replace("\\", "/").replace("//", "/") for i in glob.iglob(PATH.XFWLOADER_PACKAGES_REALFS + '/*/xfw_package.json')]
    for m_config in m_configs:
        m_dir = m_config[0:m_config.rfind("/")] # module directory

        try:
            with open(m_config) as m_config_f:
                data = json.load(m_config_f)

                if data['id'] in mods.keys():
                    print "[XFW/Loader] [RealFS] Error: mod '%s' was already found" % data[id]
                    print "                      current location  : %s" % m_dir
                    print "                      imported location : %s" % mods[id]['dir']
                else:
                    mods[data['id']] = data
                    mods[data['id']]['fs'] = 'realfs'
                    mods[data['id']]['dir_path'] = m_dir
                    mods[data['id']]['dir_name'] = m_dir[m_dir.rfind("/")+1:]

        except Exception:
            print "[XFW/Loader] [RealFS] Could not parse config for directory '%s'" % m_dir

def xfw_mods_read_vfs():
    """
    fills mods list with  modifications in vfs
    path to search: [VFS_root]/mods/xfw_packages/*/xfw_package.json
    """

    for m_dir_name in vfs.directory_list_subdirs(PATH.XFWLOADER_PACKAGES_VFS):
        try:
            m_dir = PATH.XFWLOADER_PACKAGES_VFS + '/' + m_dir_name

            mod_config = vfs.file_read(m_dir + '/xfw_package.json', True)
            if mod_config is not None:
                data = json.loads(mod_config)

                if data['id'] in mods.keys():
                    print "[XFW/Loader] [VFS] Error: mod '%s' was already found" % data[id]
                    print "                   current location  : %s" % m_dir
                    print "                   imported location : %s" % mods[id]['dir']
                else:
                    mods[data['id']] = data
                    mods[data['id']]['fs'] = 'vfs'
                    mods[data['id']]['dir_path'] = m_dir
                    mods[data['id']]['dir_name'] = m_dir_name

        except Exception:
            print "[XFW/Loader] [VFS] Could not parse config for directory '%s'" % m_dir

## process features

def xfw_mods_features_read():
    for mod_id, mod_config in mods.iteritems():
        if 'features_provide' in mod_config:
            for provided_feature in mod_config['features_provide']:
                mods_features[provided_feature] = mod_id

# process DAG

def xfw_mods_get_keys_by_mask(mask):
    mods_found = list()

    prefix = mask.split('*', 1)[0]
    for key in mods:
        if key.startswith(prefix):
            mods_found.append(key)
   
    return mods_found

def xfw_mods_dag_add_edge(u, v, line_style='solid'):
    try:
        mods_dag.add_node_if_not_exists(u)   
        mods_dag.add_node_if_not_exists(v)
        mods_dag.add_edge(u, v)
    except DAGValidationError:
        return False

    return True

def xfw_mods_dag_build():
    for mod_id, mod_config in mods.iteritems():
        dependency_added = False
    
        #dependencies       
        if 'dependencies' in mod_config:
            for dependency in mod_config['dependencies']: 
                result = xfw_mods_dag_add_edge(dependency, mod_id)
                if result:
                    dependency_added = True         

        #features
        if 'features' in mod_config:
            for feature in mod_config['features']: 
                if feature in mods_features:  
                    result = xfw_mods_dag_add_edge(mods_features[feature], mod_id)
                    if result:
                        dependency_added = True

        if not dependency_added:
            xfw_mods_dag_add_edge('root', mod_id)

        #optional dependencies
        if 'dependencies_optional' in mod_config:
            for dependency in mod_config['dependencies_optional']:
                if '*' in dependency:
                    for dependency in xfw_mods_get_keys_by_mask(dependency):
                        xfw_mods_dag_add_edge(dependency, mod_id)
                else:
                    xfw_mods_dag_add_edge(dependency, mod_id)

## load

def xfw_mods_load():
    """
    Loads XFW-powered mods from work_folder
    """

    xfw_mods_read_realfs()
    xfw_mods_read_vfs()

    sys.path.insert(0, PATH.XFWLOADER_PACKAGES_VFS)
    sys.path.insert(0, PATH.XFWLOADER_PACKAGES_REALFS)

    if not any(mods):
        print "[XFW] No mods were found"
        return

    xfw_mods_features_read()
    xfw_mods_dag_build()

    # load modifications in topological order
    for mod_name in mods_dag.topological_sort():
        if mod_name == "root":
            continue

        #validate:
        if mod_name not in mods:
            print "[XFW] Error with mod: '%s'. Mod not found" % mod_name
            mods_failed.append(mod_name)
            continue

        if mod_name in mods_failed:
            print "[XFW] Error with mod: '%s'. Mod was marked as failed" % mod_name
            continue

        mod = mods[mod_name]
        if mod is None:
            print "[XFW] Error with mod: '%s'. Mod info object is None" % mod_name
            mods_failed.append(mod_name)
            continue

        #check version
        if 'wot_version_min' in mod and len(mod['wot_version_min']) > 0:
            compare_result = utils.version_cmp(VERSION.WOT_VERSION_SHORT, mod['wot_version_min'])
            if compare_result < 0:
                print "[XFW] Error with mod: '%s'. Client version is lower than required: current: '%s', required: '%s'" % (mod_name, VERSION.WOT_VERSION_SHORT, mod['wot_version_min'])
                mods_failed.append(mod_name)
                continue

            if compare_result > 0 and 'wot_version_exactmatch' in mod and mod['wot_version_exactmatch'] == True:
                print "[XFW] Error with mod: '%s'. Client version is higher than required: current: '%s', required: '%s'" % (mod_name, VERSION.WOT_VERSION_SHORT, mod['wot_version_min'])
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
                    print "[XFW] Error with mod: '%s'. Feature not found: '%s'" % (mod_name, feature)
                    failed = True
                    continue

                if mods_features[feature] == mod_name:
                    continue

                if mods_features[feature] in mods_failed:
                    print "[XFW] Error with mod: '%s'. Feature failed: '%s' in package '%s'" % (mod_name, feature, mods_features[feature])
                    failed = True
        
        if failed == True:
            mods_failed.append(mod_name)
            continue

        #check dependencies
        if 'dependencies' in mod:
            for dependency in mod['dependencies']:
                if dependency not in mods:
                    print "[XFW] Error with mod: '%s'. Dependency not found: '%s'" % (mod_name, dependency)
                    failed = True
                    continue

                if dependency in mods_failed:
                    print "[XFW] Error with mod: '%s'. Dependency failed: '%s'" % (mod_name, dependency)
                    failed = True
        
        if failed == True:
            mods_failed.append(mod_name)
            continue
        
        #load
        print "[XFW] Loading mod: %s, v. %s" % (mod_name, mod['version'])
        if 'features' not in mod:
            continue

        #load python feature
        if 'python' in mod['features']:
            if mod['fs'] == 'realfs':
                open(mod['dir_path'] + '/__init__.py', 'a').close()
                compileall.compile_dir(mod['dir_path'], quiet = 1)

            try:
                __import__('%s.python' % mod['dir_name'])
            except Exception as err:
                print "[XFW] Loading mod: '%s' FAILED: %s" % (mod_name, err.message)
                traceback.print_exc()
                mods_failed.append(mod_name)

##############################

xfw_initialize_constants()
xfw_mods_load()
