""" xvm (c) sirmax 2013-2014 """

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
        self.ventilation = False
        self.consumable = False
        self.brothers_in_arms = False
        self.commander_skill = 0.0
        self.other_bonus = 0.0
        self.binoculars = False
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

        # Calculate commander bonus
        self.commander_skill = self.crew["commander"]["level"]
        if self.brothers_in_arms == True:
            self.commander_skill += 5.0
        if self.ventilation == True:
            self.commander_skill += 5.0
        if self.consumable == True:
            self.commander_skill += 10.0
        debug("Commander Skill: %f" % self.commander_skill)

        # Calculate other bonuses
        self.other_bonus = 1.0
        for name, data in self.crew.iteritems():
            # Calculate recon skills
            if "commander_eagleEye" in data["skill"]:
                self.other_bonus *= 1.0 + ( 0.0002 * data["skill"]["commander_eagleEye"] )
            # Calculate Situational Awareness Skill
            if "radioman_finder" in data["skill"]:
                self.other_bonus *= 1.0 + ( 0.0003 * data["skill"]["radioman_finder"] )
        debug("other_bonus: %f" % self.other_bonus)

        # Check for Binoculars
        self.binoculars = self._isOptionalEquipped("stereoscope")
        debug("Binoculars: " + str(self.binoculars))

        # Check for Coated Optics
        self.coated_optics = self._isOptionalEquipped("coatedOptics")
        debug("Coated Optics: " + str(self.coated_optics))


    def updateConfig(self, config):
        cfg = config['minimap']['circles']
        if not cfg['enabled']:
            return

        player = BigWorld.player()
        vehId = player.playerVehicleID
        descr = player.vehicleTypeDescriptor
        name = descr.name.replace(':','-')
        #debug(name)
        #debug(vars(descr))
        #debug(vars(descr.type))

        # Calculate final values

        # View Distance
        view_distance = descr.turret["circularVisionRadius"]
        view_distance = ((view_distance / 0.875) * (0.00375 * self.commander_skill + 0.5)) * self.other_bonus

        # Binocular Distance
        binocular_distance = view_distance * 1.25
        #binocular_distance = min(445, binocular_distance)

        # View Distance with Coated Optics (Binoculars don't include Coated Optics)
        if self.coated_optics == True:
            view_distance = min(view_distance * 1.1, 500)
        #view_distance = min(445, view_distance);

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

        #if IS_DEVELOPMENT:
        #    view_distance = 400
        #    binocular_distance = 500
        #    artillery_range = 600
        #    shell_range = 300

        # Set values
        cfg['_internal'] = {
            'view_distance': view_distance,
            'binocular_distance': binocular_distance,
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
