""" XVM (c) www.modxvm.com 2013-2017 """
"""
@author Omegaice
@author Maxim Schedriviy <max(at)modxvm.com>
"""

def getMinimapCirclesData():
    return _g_minimap_circles.minimapCirclesData

def updateCurrentVehicle():
    _g_minimap_circles.updateCurrentVehicle()

def save_or_restore():
    _g_minimap_circles.save_or_restore()

# PRIVATE

import math
import traceback

import BigWorld
from adisp import async, process
from CurrentVehicle import g_currentVehicle
from gui.shared import g_itemsCache

from xfw import *
from logger import *
import userprefs


class _MinimapCircles(object):
    def __init__(self):
        self.clear()

    def clear(self):
        self.minimapCirclesData = None
        self.vehicleItem = None
        self.crew = []
        self.is_full_crew = False
        self.view_distance_vehicle = 0
        self.base_commander_skill = 100.0
        self.base_radioman_skill = 0.0
        self.base_loaders_skill = 0.0
        self.brothers_in_arms = False
        self.stereoscope = False
        self.ventilation = False
        self.coated_optics = False
        self.rammer = False
        self.consumable = False
        self.commander_sixthSense = False
        self.commander_eagleEye = 0.0
        self.radioman_finder = 0.0
        self.radioman_inventor = 0.0
        self.camouflage = []

    def setMinimapCirclesData(self, value):
        self.minimapCirclesData = value

    def updateCurrentVehicle(self):
        # debug('updateCurrentVehicle')

        self.clear()

        # debug(g_currentVehicle)
        # debug(g_currentVehicle.item)
        self.vehicleItem = g_currentVehicle.item
        if self.vehicleItem is None:
            return

        self.view_distance_vehicle = self.vehicleItem.descriptor.turret['circularVisionRadius']
        #debug('  view_distance_vehicle: %.0f' % self.view_distance_vehicle)

        self._updateCrew()
        crewRoles_arr = self.vehicleItem.descriptor.type.crewRoles # roles per position in vehicle

        # Search skills and Brothers In Arms
        self.brothers_in_arms = True
        self.camouflage = []
        loaders_count = 0
        male_count = 0
        female_count = 0

        for crew_item in self.crew:
            name = crew_item['name']
            data = crew_item['data']
            skills = data['skill']
            position = data['position'] # position in vehicle

            if 'commander' in crewRoles_arr[position]:
                self.base_commander_skill = data['level']
                self.commander_sixthSense = skills.get('commander_sixthSense', -1) == 100
                if self.commander_eagleEye < skills.get('commander_eagleEye', -1):
                    self.commander_eagleEye = skills['commander_eagleEye']

            if 'radioman' in crewRoles_arr[position]:
                skill = data['level']
                if self.base_radioman_skill < skill:
                    self.base_radioman_skill = skill
                if self.radioman_finder < skills.get('radioman_finder', -1):
                    self.radioman_finder = skills['radioman_finder']
                if self.radioman_inventor < skills.get('radioman_inventor', -1):
                    self.radioman_inventor = skills['radioman_inventor']

            if 'loader' in crewRoles_arr[position]:
                self.base_loaders_skill += data['level']
                loaders_count += 1

            self.camouflage.append({'name': name, 'skill': skills.get('camouflage', 0)})

            if data['isFemale']:
                female_count += 1
            else:
                male_count += 1
            if skills.get('brotherhood', -1) != 100:
                self.brothers_in_arms = False

        if loaders_count > 1:
            self.base_loaders_skill /= loaders_count
        if male_count > 0 and female_count > 0:
            self.brothers_in_arms = False

        #debug('  base_commander_skill: %.0f' % self.base_commander_skill)
        #debug('  base_radioman_skill: %.0f' % self.base_radioman_skill)
        #debug('  base_loaders_skill: %.0f' % self.base_loaders_skill)
        #debug('  commander_sixthSense: %d' % self.commander_sixthSense)
        #debug('  commander_eagleEye: %d' % self.commander_eagleEye)
        #debug('  radioman_finder: %d' % self.radioman_finder)
        #debug('  camouflage: %s' % str(self.camouflage))
        #debug('  brothers_in_arms: %s' % str(self.brothers_in_arms))

        # Check for Stereoscope
        self.stereoscope = self._isOptionalEquipped('stereoscope')
        #debug('  stereoscope: %s' % str(self.stereoscope))

        # Check for Ventilation
        self.ventilation = self._isOptionalEquipped('improvedVentilation')
        #debug('  ventilation: %s' % str(self.ventilation))

        # Check for Coated Optics
        self.coated_optics = self._isOptionalEquipped('coatedOptics')
        #debug('  coated_optics: %s' % str(self.coated_optics))

        # Check for rammer
        self.rammer = self._isOptionalEquipped('Rammer')
        #debug('  rammer: %s' % str(self.rammer))

        # Check for Consumable (cola, chocolate etc.)
        self.consumable = self._isStimulatorEquipped()
        #debug('  consumable: %s' % str(self.consumable))

        self.updateMinimapCirclesData(self.vehicleItem.descriptor)

    def updateMinimapCirclesData(self, descr):
        # debug(vars(descr))
        # debug(vars(descr.type))

        # View Range
        if isReplay():
            self.view_distance_vehicle = descr.turret['circularVisionRadius']

        # Shell Range & Artillery Range
        isArty = 'SPG' in descr.type.tags
        shell_range = 0
        artillery_range = 0
        for shell in descr.gun['shots']:
            shell_range = max(shell_range, shell['maxDistance'])
            if isArty:
                artillery_range = max(artillery_range, round(math.pow(shell['speed'], 2) / shell['gravity']))

        # do not show for range more then 707m (maximum marker visibility range)
        if shell_range >= 707:
            shell_range = 0

        # log(descr.gun)
        # log(descr.radio)

        # Set values
        self.minimapCirclesData = {
            'vehCD': descr.type.compactDescr,
            'is_full_crew': self.is_full_crew,
            'base_commander_skill': self.base_commander_skill,
            'base_radioman_skill': self.base_radioman_skill,
            'base_loaders_skill': self.base_loaders_skill,
            'view_distance_vehicle': self.view_distance_vehicle,
            'view_brothers_in_arms': self.brothers_in_arms,
            'view_stereoscope': self.stereoscope,
            'view_ventilation': self.ventilation,
            'view_coated_optics': self.coated_optics,
            'view_rammer': self.rammer,
            'view_consumable': self.consumable,
            'view_commander_eagleEye': self.commander_eagleEye,
            'view_radioman_finder': self.radioman_finder,
            'view_radioman_inventor': self.radioman_inventor,
            'view_camouflage': self.camouflage,
            'artillery_range': artillery_range,
            'shell_range': shell_range,
            'base_gun_reload_time': descr.gun['reloadTime'],
            'base_radio_distance': descr.radio['distance'],
            'commander_sixthSense': self.commander_sixthSense,
        }

    def save_or_restore(self):
        try:
            # Save/restore arena data
            player = BigWorld.player()
            fileName = 'arenas_data.zip/{0}'.format(player.arenaUniqueID)
            vehCD = player.vehicleTypeDescriptor.type.compactDescr
            if vehCD and self.minimapCirclesData and vehCD == self.minimapCirclesData.get('vehCD', None):
                # Normal battle start. Update data and save to userprefs cache
                userprefs.set(fileName, {
                    'ver': '1.1',
                    'minimap_circles': self.minimapCirclesData,
                })
            else:
                # Replay, training or restarted battle after crash. Try to restore data.
                arena_data = userprefs.get(fileName)
                if arena_data is None:
                    # Set default vehicle data if it is not available.in the cache.
                    self.updateMinimapCirclesData(player.vehicleTypeDescriptor)
                else:
                    # Apply restored data.
                    self.setMinimapCirclesData(arena_data['minimap_circles'])

        except Exception, ex:
            err(traceback.format_exc())


    # PRIVATE

    def _updateCrew(self):
        self.crew = []
        self.is_full_crew = True

        tankmen = g_itemsCache.items.getTankmen()
        for tankman in tankmen.itervalues():
            for slotIdx, crewman in self.vehicleItem.crew:
                if crewman is None:
                    self.is_full_crew = False
                elif crewman.invID == tankman.invID:
                    (factor, addition) = tankman.descriptor.efficiencyOnVehicle(self.vehicleItem.descriptor)
                    crew_member = {
                        'position': slotIdx,
                        'isFemale': tankman.descriptor.isFemale,
                        'level': tankman.roleLevel * factor,
                        'skill': {}
                    }

                    skills = []
                    for skill_name in tankman.descriptor.skills:
                        skills.append({'name': skill_name, 'level': 100})

                    if len(skills) != 0:
                        skills[-1]['level'] = tankman.descriptor.lastSkillLevel

                    for skill in skills:
                        crew_member['skill'][skill['name']] = skill['level']

                    # debug(tankman.descriptor.role + " " + str(crew_member['level']))
                    self.crew.append({'name': tankman.descriptor.role, 'data': crew_member})

    def _isOptionalEquipped(self, optional_name):
        for item in self.vehicleItem.descriptor.optionalDevices:
            # debug(vars(item))
            if item is not None and optional_name in item.name:
                return True
        return False

    # deprecated
    def _isConsumableEquipped(self, consumable_names):
        for item in self.vehicleItem.eqsLayout:
            # debug(vars(item))
            if item is not None and item.descriptor.name in consumable_names:
                return True
        return False

    # cola, chocolate etc.
    def _isStimulatorEquipped(self):
        for item in self.vehicleItem.eqsLayout:
            # debug(vars(item))
            if item is not None and item.isStimulator:
                return True
        return False

_g_minimap_circles = _MinimapCircles()
