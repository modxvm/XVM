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
        self.crew = {}
        self.base_commander_skill = 100.0
        self.brothers_in_arms = False
        self.ventilation = False
        self.consumable = False
        self.commander_eagleEye = 0.0
        self.radioman_finder = 0.0
        self.is_commander_radioman = False
        self.camouflage = []
        self.coated_optics = False

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

        # Update crew
        self._updateCrew()

        # Check for Ventilation
        self.ventilation = self._isOptionalEquipped("improvedVentilation")
        #debug("ventilation: %s" % str(self.ventilation))

        # Check for Consumable
        self.consumable = \
            self._isConsumableEquipped("ration") or \
            self._isConsumableEquipped("chocolate") or \
            self._isConsumableEquipped("cocacola") or \
            self._isConsumableEquipped("hotCoffee")
        #debug("consumable: %s" % str(self.consumable))

        # Check for Brothers In Arms
        self.brothers_in_arms = True
        for name, data in self.crew.iteritems():
            if "brotherhood" not in data["skill"] or data["skill"]["brotherhood"] != 100:
                self.brothers_in_arms = False
                break

        # Base commander skill
        self.base_commander_skill = self.crew["commander"]["level"]
        # TODO: penalty for wrong vehicle
        debug("Commander Skill: %f" % self.base_commander_skill)

        # Search other skills
        self.camouflage = []
        for name, data in self.crew.iteritems():
            if "commander_eagleEye" in data["skill"]:
                ee_skill = data["skill"]["commander_eagleEye"]
                if self.commander_eagleEye < ee_skill:
                    self.commander_eagleEye = ee_skill
            if "radioman_finder" in data["skill"]:
                rf_skill = data["skill"]["radioman_finder"]
                if self.radioman_finder < rf_skill:
                    self.radioman_finder = rf_skill
                    self.is_commander_radioman = name == "commander"
            self.camouflage.append({
                'name':name,
                'skill':data["skill"]["camouflage"] if "camouflage" in data["skill"] else 0})

        debug("commander_eagleEye: %f" % self.commander_eagleEye)
        debug("radioman_finder: %f" % self.radioman_finder)
        debug("camouflage: %f" % self.camouflage)

        # Check for Coated Optics
        self.coated_optics = self._isOptionalEquipped("coatedOptics")
        debug("Coated Optics: " + str(self.coated_optics))


    def updateConfig(self, config):
        cfg = config['minimap']['circles']
        if not cfg['enabled']:
            return

        descr = BigWorld.player().vehicleTypeDescriptor
        #debug(vars(descr))
        #debug(vars(descr.type))

        # View Distance
        view_distance = descr.turret["circularVisionRadius"]

        # Artillery Range
        artillery_range = 0
        if "SPG" in descr.type.tags:
            for shell in descr.gun["shots"]:
                artillery_range = max(artillery_range, round(math.pow(shell["speed"],2) / shell["gravity"]))

        # Shell Range
        shell_range = 0
        for shell in descr.gun["shots"]:
            shell_range = max(shell_range, shell["maxDistance"])
        # do not show for range more then 707m (maximum marker visibility range)
        if shell_range >= 707:
            shell_range = 0

        # Set values
        cfg['_internal'] = {
            'view_distance_vehicle': view_distance,
            'view_base_commander_skill': self.base_commander_skill,
            'view_brothers_in_arms': self.brothers_in_arms,
            'view_ventilation': self.ventilation,
            'view_consumable': self.consumable,
            'view_commander_eagleEye': self.commander_eagleEye,
            'view_radioman_finder': self.radioman_finder,
            'view_is_commander_radioman': self.is_commander_radioman,
            'view_camouflage': self.camouflage,
            'view_coated_optics': self.coated_optics,
            'artillery_range': artillery_range,
            'shell_range': shell_range,
        }

    # PRIVATE

    @process
    def _updateCrew(self):
        from gui.shared.utils.requesters import Requester
        self.crew.clear()

        barracks = yield Requester('tankman').getFromInventory()
        for tankman in barracks:
            for crewman in self.item.crew:
                if crewman[1] is not None and crewman[1].invID == tankman.inventoryId:
                    factor = tankman.descriptor.efficiencyOnVehicle(self.item.descriptor)

                    crew_member = {
                        "level": tankman.descriptor.roleLevel * factor[0],
                        "skill": {}
                    }

                    skills = []
                    for skill_name in tankman.descriptor.skills:
                        skills.append({ "name": skill_name, "level": 100 })

                    if len(skills) != 0:
                        skills[-1]["level"] = tankman.descriptor.lastSkillLevel

                    for skill in skills:
                        crew_member["skill"][skill["name"]] = skill["level"]

                    self.crew[tankman.descriptor.role] = crew_member

    def _isOptionalEquipped(self, optional_name):
        for item in self.item.descriptor.optionalDevices:
            #debug(vars(item))
            if item is not None and optional_name in item.name:
                return True
        return False

    def _isConsumableEquipped(self, consumable_name):
        from gui.shared.utils.requesters import VehicleItemsRequester
        for item in self.item.eqsLayout:
            #debug(vars(item))
            if item is not None and consumable_name in item.descriptor.name:
                return True
        return False

g_minimap_circles = _MinimapCircles()
