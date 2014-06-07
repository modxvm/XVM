""" XVM (c) www.modxvm.com 2013-2014 """
"""
@author Maxim Schedriviy "m.schedriviy(at)gmail.com"
@author Omegaice
"""

import math
import BigWorld
from adisp import async, process
from xpm import *
from logger import *

class _MinimapCircles(object):
    def __init__(self):
        self.clear()

    def clear(self):
        self.item = None
        self.crew = []
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
        self.commander_eagleEye = 0.0
        self.radioman_finder = 0.0
        self.radioman_inventor = 0.0
        self.camouflage = []

    def updateCurrentVehicle(self, config):
        #debug('updateCurrentVehicle')
        cfg = config['minimap']['circles']
        if not cfg['enabled']:
            return

        self.clear()

        from CurrentVehicle import g_currentVehicle
        #debug(g_currentVehicle)
        #debug(g_currentVehicle.item)
        self.item = g_currentVehicle.item
        if self.item is None:
            return

        self.view_distance_vehicle = self.item.descriptor.turret['circularVisionRadius']
        debug('  view_distance_vehicle: %.0f' % self.view_distance_vehicle)

        self._updateCrew()

        # Search skills and Brothers In Arms
        self.brothers_in_arms = True
        self.camouflage = []
        radioman_present = next((True for item in self.crew if 'radioman' in item['name']), False)
        loaders_count = 0

        for crew_item in self.crew:
            name = crew_item['name']
            data = crew_item['data']
            skills = data['skill']

            if name == 'commander':
                self.base_commander_skill = data['level']

            if 'radioman' in name:
                skill = data['level']
                if self.base_radioman_skill < skill:
                    self.base_radioman_skill = skill

            if 'loader' in name:
                self.base_loaders_skill += data['level']
                loaders_count += 1

            if 'commander_eagleEye' in skills:
                skill = skills['commander_eagleEye']
                if self.commander_eagleEye < skill:
                    self.commander_eagleEye = skill

            if 'radioman_finder' in skills and (not radioman_present or name != 'commander'):
                skill = skills['radioman_finder']
                if self.radioman_finder < skill:
                    self.radioman_finder = skill

            if 'radioman_inventor' in skills and (not radioman_present or name != 'commander'):
                skill = skills['radioman_inventor']
                if self.radioman_inventor < skill:
                    self.radioman_inventor = skill

            self.camouflage.append({'name':name, 'skill':skills.get('camouflage', 0)})

            if 'brotherhood' not in skills or skills['brotherhood'] != 100:
                self.brothers_in_arms = False

        if loaders_count > 0:
            self.base_loaders_skill /= loaders_count;

        debug('  base_commander_skill: %.0f' % self.base_commander_skill)
        debug('  base_radioman_skill: %.0f' % self.base_radioman_skill)
        debug('  base_loaders_skill: %.0f' % self.base_loaders_skill)
        debug('  commander_eagleEye: %d' % self.commander_eagleEye)
        debug('  radioman_finder: %d' % self.radioman_finder)
        debug('  camouflage: %s' % str(self.camouflage))
        debug('  brothers_in_arms: %s' % str(self.brothers_in_arms))

        # Check for Stereoscope
        self.stereoscope = self._isOptionalEquipped('stereoscope')
        debug('  stereoscope: %s' % str(self.stereoscope))

        # Check for Ventilation
        self.ventilation = self._isOptionalEquipped('improvedVentilation')
        debug('  ventilation: %s' % str(self.ventilation))

        # Check for Coated Optics
        self.coated_optics = self._isOptionalEquipped('coatedOptics')
        debug('  coated_optics: %s' % str(self.coated_optics))

        # Check for rammer
        self.rammer = self._isOptionalEquipped('Rammer')
        debug('  rammer: %s' % str(self.rammer))

        # Check for Consumable
        self.consumable = self._isConsumableEquipped([
            'chocolate',
            'cocacola',
            'hotCoffee',
            'ration',
            'ration_china',
            'ration_japan',
            'ration_uk'])
        debug('  consumable: %s' % str(self.consumable))

        self.updateConfig(self.item.descriptor, config)


    def updateConfig(self, descr, config):
        cfg = config['minimap']['circles']
        if not cfg['enabled']:
            return

        #debug(vars(descr))
        #debug(vars(descr.type))

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

        # Set values
        cfg['_internal'] = {
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
        }

    # PRIVATE

    @process
    def _updateCrew(self):
        from gui.shared.utils.requesters import Requester

        self.crew = []
        barracks = yield Requester('tankman').getFromInventory()
        for tankman in barracks:
            for crewman in self.item.crew:
                if crewman[1] is not None and crewman[1].invID == tankman.inventoryId:
                    (factor, addition) = tankman.descriptor.efficiencyOnVehicle(self.item.descriptor)
                    crew_member = {
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

                    #debug(tankman.descriptor.role + " " + str(crew_member['level']))
                    self.crew.append({'name': tankman.descriptor.role, 'data': crew_member})

    def _isOptionalEquipped(self, optional_name):
        for item in self.item.descriptor.optionalDevices:
            #debug(vars(item))
            if item is not None and optional_name in item.name:
                return True
        return False

    def _isConsumableEquipped(self, consumable_names):
        from gui.shared.utils.requesters import VehicleItemsRequester
        for item in self.item.eqsLayout:
            #debug(vars(item))
            if item is not None and item.descriptor.name in consumable_names:
                return True
        return False

g_minimap_circles = _MinimapCircles()
