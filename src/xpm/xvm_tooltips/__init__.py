""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION = '3.0.0'
XFW_MOD_URL = 'http://www.modxvm.com/'
XFW_MOD_UPDATE_URL = 'http://www.modxvm.com/en/download-xvm/'
XFW_GAME_VERSIONS  = ['0.9.7','0.9.8']

#####################################################################

import traceback

import BigWorld
from math import degrees, pi
from helpers import i18n

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *
from xvm_main.python.vehinfo import _getRanges
from xvm_main.python.vehinfo_tiers import getTiers
from xvm_main.python.vehinfo_camo import getCamoValues
from xvm_main.python.xvm import l10n
from gun_rotation_shared import calcPitchLimitsFromDesc

#####################################################################
# event handlers

# overriding tooltips for tanks in hangar, configuration in tooltips.xc
def VehicleParamsField_getValue(base, self):
    try:
        from gui.shared.utils import ItemsParameters, ParametersCache
        result = list()
        vehicle = self._tooltip.item
        configuration = self._tooltip.context.getParamsConfiguration(vehicle)
        params = configuration.params
        crew = configuration.crew
        eqs = configuration.eqs
        devices = configuration.devices
        veh_descr = vehicle.descriptor
        gun = vehicle.gun.descriptor
        turret = vehicle.turret.descriptor
        vehicleCommonParams = dict(ItemsParameters.g_instance.getParameters(veh_descr))
        vehicleRawParams = dict(ParametersCache.g_instance.getParameters(veh_descr))
        result.append([])
        veh_type_inconfig = vehicle.type.replace('AT-SPG', 'TD')
        clipGunInfoShown = False
        premium_shells = {}
        for shell in vehicle.shells:
            premium_shells[shell.intCompactDescr] = shell.isPremium
        if params:
            values = config.get('tooltips/%s' % veh_type_inconfig)
            if values and len(values):
                params_list = values # overriding parameters
            else:
                params_list = self.PARAMS.get(vehicle.type, 'default')               # old way
            for paramName in params_list:
                if paramName == 'turretArmor' and not vehicle.hasTurrets:
                    continue
                #maxHealth
                if paramName == 'maxHealth':
                    result[-1].append([h1_pad(i18n.makeString('#menu:vehicleInfo/params/maxHealth')), h1_pad(veh_descr.maxHealth)])
                    continue
                #battle tiers
                if paramName == 'battleTiers':
                    (minTier, maxTier) = getTiers(vehicle.level, vehicle.type, vehicle.name)
                    result[-1].append([h1_pad(l10n('Battle tiers')), h1_pad('%s..%s' % (minTier, maxTier))])
                    continue
                #gravity
                if paramName == 'gravity':
                    gravity_str = '%g' % round(veh_descr.shot['gravity'], 2)
                    result[-1].append([h1_pad(l10n('gravity')), h1_pad(gravity_str)])
                    continue
                #camo coeffitients
                if paramName == 'camo_coeff':
                    topTurret = veh_descr.type.turrets[0][-1]
                    camo_coeff_arr = getCamoValues(vehicle.name, turret['name'] == topTurret['name'], gun['name'])
                    camo_coeff_str = '/'.join(map(smart_round, camo_coeff_arr))
                    result[-1].append([h1_pad(l10n('camoCoeff') + ' <p>(%)</p>'), h1_pad(camo_coeff_str)])
                    continue
                #radioRange
                if paramName == 'radioRange':
                    radioRange_str = '%s' % int(vehicle.radio.descriptor['distance'])
                    result[-1].append([i18n.makeString('#menu:moduleInfo/params/radioDistance').replace('h>', 'h1>'), h1_pad(radioRange_str)])
                    continue
                #explosionRadius
                if paramName == 'explosionRadius':
                    explosionRadiusMin = 999
                    explosionRadiusMax = 0
                    for shot in gun['shots']:
                        if 'explosionRadius' in shot['shell']:
                            if shot['shell']['explosionRadius'] < explosionRadiusMin:
                                explosionRadiusMin = shot['shell']['explosionRadius']
                            if shot['shell']['explosionRadius'] > explosionRadiusMax:
                                explosionRadiusMax = shot['shell']['explosionRadius']
                    if explosionRadiusMax == 0: # no HE
                        continue
                    explosionRadius_str = '%g' % round(explosionRadiusMin, 2)
                    if explosionRadiusMin != explosionRadiusMax:
                        explosionRadius_str += '/%g' % gold_pad(round(explosionRadiusMax, 2))
                    result[-1].append([self._getParameterValue(paramName, vehicleCommonParams, vehicleRawParams)[0], h1_pad(explosionRadius_str)])
                    continue
                #shellSpeedSummary
                if paramName == 'shellSpeedSummary':
                    shellSpeedSummary_arr = []
                    for shot in gun['shots']:
                        shellSpeed_str = '%g' % round(shot['speed'] * 1.25)
                        if premium_shells[shot['shell']['compactDescr']]:
                            shellSpeed_str = gold_pad(shellSpeed_str)
                        shellSpeedSummary_arr.append(shellSpeed_str)
                    shellSpeedSummary_str = '/'.join(shellSpeedSummary_arr)
                    result[-1].append([h1_pad('%s <p>%s</p>' % (l10n('shellSpeed'), l10n('(m/sec)'))), h1_pad(shellSpeedSummary_str)])
                    continue
                #piercingPowerAvg
                if paramName == 'piercingPowerAvg':
                    piercingPowerAvg = '%g' % veh_descr.shot['piercingPower'][0]
                    result[-1].append([i18n.makeString('#menu:moduleInfo/params/avgPiercingPower').replace('h>', 'h1>'), h1_pad(piercingPowerAvg)])
                    continue
                #piercingPowerAvgSummary
                if paramName == 'piercingPowerAvgSummary':
                    piercingPowerAvgSummary_arr = []
                    for shot in gun['shots']:
                        piercingPower_str = '%g' % shot['piercingPower'][0]
                        if premium_shells[shot['shell']['compactDescr']]:
                            piercingPower_str = gold_pad(piercingPower_str)
                        piercingPowerAvgSummary_arr.append(piercingPower_str)
                    piercingPowerAvgSummary_str = '/'.join(piercingPowerAvgSummary_arr)
                    result[-1].append([i18n.makeString('#menu:moduleInfo/params/avgPiercingPower').replace('h>', 'h1>'), h1_pad(piercingPowerAvgSummary_str)])
                    continue
                #damageAvgSummary
                if paramName == 'damageAvgSummary':
                    damageAvgSummary_arr = []
                    for shot in gun['shots']:
                        damageAvg_str = '%g' % shot['shell']['damage'][0]
                        if premium_shells[shot['shell']['compactDescr']]:
                            damageAvg_str = gold_pad(damageAvg_str)
                        damageAvgSummary_arr.append(damageAvg_str)
                    damageAvgSummary_str = '/'.join(damageAvgSummary_arr)
                    result[-1].append([i18n.makeString('#menu:moduleInfo/params/avgDamage').replace('h>', 'h1>'), h1_pad(damageAvgSummary_str)])
                    continue
                #magazine loading
                if (paramName == 'reloadTimeSecs' or paramName == 'rateOfFire') and vehicle.gun.isClipGun():
                    if clipGunInfoShown:
                        continue
                    (shellsCount, shellReloadingTime) = gun['clip']
                    reloadMagazineTime = gun['reloadTime']
                    shellReloadingTime_str = '%g' % round(shellReloadingTime, 2)
                    reloadMagazineTime_str = '%g' % round(reloadMagazineTime, 2)
                    result[-1].append([i18n.makeString('#menu:moduleInfo/params/shellsCount').replace('h>', 'h1>'), h1_pad(shellsCount)])
                    result[-1].append([i18n.makeString('#menu:moduleInfo/params/shellReloadingTime').replace('h>', 'h1>'), h1_pad(shellReloadingTime_str)])
                    result[-1].append([i18n.makeString('#menu:moduleInfo/params/reloadMagazineTime').replace('h>', 'h1>'), h1_pad(reloadMagazineTime_str)])
                    clipGunInfoShown = True
                    continue
                #rate of fire
                if paramName == 'rateOfFire' and not vehicle.gun.isClipGun():
                    rateOfFire_str = '%g' % round(60 / gun['reloadTime'], 2)
                    result[-1].append([i18n.makeString('#menu:moduleInfo/params/reloadTime').replace('h>', 'h1>'), h1_pad(rateOfFire_str)])
                    continue
                # gun traverse limits
                if paramName == 'traverseLimits' and gun['turretYawLimits']:
                    (traverseMin, traverseMax) = gun['turretYawLimits']
                    traverseLimits_str = '%g..+%g' % (round(degrees(traverseMin)), round(degrees(traverseMax)))
                    result[-1].append([h1_pad(l10n('traverseLimits')), h1_pad(traverseLimits_str)])
                    continue
                # elevation limits (front)
                if paramName == 'pitchLimits':
                    (pitchMax, pitchMin) = calcPitchLimitsFromDesc(0, gun['pitchLimits'])
                    pitchLimits_str = '%g..+%g' % (round(degrees(-pitchMin)), round(degrees(-pitchMax)))
                    result[-1].append([h1_pad(l10n('pitchLimits')), h1_pad(pitchLimits_str)])
                    continue
                # elevation limits (side)
                if paramName == 'pitchLimitsSide':
                    if gun['turretYawLimits'] and abs(degrees(gun['turretYawLimits'][0])) < 89: continue # can't look aside 90 degrees
                    (pitchMax, pitchMin) = calcPitchLimitsFromDesc(pi / 2, gun['pitchLimits'])
                    pitchLimits_str = '%g..+%g' % (round(degrees(-pitchMin)), round(degrees(-pitchMax)))
                    result[-1].append([h1_pad(l10n('pitchLimitsSide')), h1_pad(pitchLimits_str)])
                    continue
                # elevation limits (rear)
                if paramName == 'pitchLimitsRear':
                    if gun['turretYawLimits']: continue # can't look back
                    (pitchMax, pitchMin) = calcPitchLimitsFromDesc(pi, gun['pitchLimits'])
                    pitchLimits_str = '%g..+%g' % (round(degrees(-pitchMin)), round(degrees(-pitchMax)))
                    result[-1].append([h1_pad(l10n('pitchLimitsRear')), h1_pad(pitchLimits_str)])
                    continue
                # shooting range
                if paramName == 'shootingRadius':
                    viewRange, shellRadius, artiRadius = _getRanges(turret, gun, vehicle.nationName, vehicle.type)
                    if vehicle.type == 'SPG':
                        result[-1].append([h1_pad('%s <p>%s</p>' % (l10n('shootingRadius'), l10n('(m)'))), h1_pad(artiRadius)])
                    elif shellRadius < 707:
                        result[-1].append([h1_pad('%s <p>%s</p>' % (l10n('shootingRadius'), l10n('(m)'))), h1_pad(shellRadius)])
                    continue
                #reverse max speed
                if paramName == 'speedLimits':
                    (speedLimitForward, speedLimitReverse) = veh_descr.physics['speedLimits']
                    speedLimits_str = str(int(speedLimitForward * 3.6)) + '/' + str(int(speedLimitReverse * 3.6))
                    result[-1].append([self._getParameterValue(paramName, vehicleCommonParams, vehicleRawParams)[0], speedLimits_str])
                    continue
                #turret rotation speed
                if paramName == 'turretRotationSpeed':
                    if not vehicle.hasTurrets:
                        paramName = 'gunRotationSpeed'
                    turretRotationSpeed_str = str(int(degrees(veh_descr.turret['rotationSpeed'])))
                    result[-1].append([self._getParameterValue(paramName, vehicleCommonParams, vehicleRawParams)[0], turretRotationSpeed_str])
                    continue
                #terrain resistance
                if paramName == 'terrainResistance':
                    resistances_arr = []
                    for key in veh_descr.chassis['terrainResistance']:
                        resistances_arr.append('%g' % round(key, 2))
                    terrainResistance_str = '/'.join(resistances_arr)
                    result[-1].append([h1_pad(l10n('terrainResistance')), h1_pad(terrainResistance_str)])
                    continue
                #custom text
                if paramName.startswith('TEXT:'):
                    customtext = paramName[5:]
                    localizedMacroStart = customtext.find('{{l10n:')
                    if localizedMacroStart >= 0: # localization macro found
                        localizedMacroEnd = customtext.index('}}', localizedMacroStart)
                        localizedMacroText = customtext[localizedMacroStart + 7:localizedMacroEnd]
                        customtext = customtext[:localizedMacroStart] + l10n(localizedMacroText) + customtext[localizedMacroEnd + 2:]
                    result[-1].append([h1_pad(customtext), ''])
                    continue
                if paramName in vehicleCommonParams or paramName in vehicleRawParams:
                    result[-1].append(self._getParameterValue(paramName, vehicleCommonParams, vehicleRawParams))

        if vehicle.isInInventory:
            # optional devices icons, must be in the end
            if 'optDevicesIcons' in params_list:
                optDevicesIcons_arr = []
                for key in vehicle.optDevices:
                    if key:
                        imgPath = 'img://gui' + key.icon.lstrip('.')
                    else:
                        imgPath = 'img://gui/maps/icons/artefact/empty.png'
                    optDevicesIcons_arr.append('<img src="%s" height="16" width="16">' % imgPath)
                optDevicesIcons_str = ' '.join(optDevicesIcons_arr)
                result[-1].append([optDevicesIcons_str, ''])

            # equipment icons, must be in the end
            if 'equipmentIcons' in params_list:
                equipmentIcons_arr = []
                for key in vehicle.eqs:
                    if key:
                        imgPath = 'img://gui' + key.icon.lstrip('.')
                    else:
                        imgPath = 'img://gui/maps/icons/artefact/empty.png'
                    equipmentIcons_arr.append('<img src="%s" height="16" width="16">' % imgPath)
                equipmentIcons_str = ' '.join(equipmentIcons_arr)
                if config.get('tooltips/combineIcons') and optDevicesIcons_str:
                    result[-1][-1][0] += ' ' + equipmentIcons_str
                else:
                    result[-1].append([equipmentIcons_str, ''])

        # crew roles icons, must be in the end
        if 'crewRolesIcons' in params_list:
            imgPath = 'img://../mods/shared_resources/xvm/res/icons/tooltips/roles'
            crewRolesIcons_arr = []
            for tankman_role in vehicle.descriptor.type.crewRoles:
                crewRolesIcons_arr.append('<img src="%s/%s.png" height="16" width="16">' % (imgPath, tankman_role[0]))
            crewRolesIcons_str = ''.join(crewRolesIcons_arr)
            result[-1].append([crewRolesIcons_str, ''])

        result.append([])
        if config.get('tooltips/hideBottomText'):
            pass
        else:
            if crew:
                currentCrewSize = 0
                if vehicle.isInInventory:
                    currentCrewSize = len([ x for _, x in vehicle.crew if x is not None ])
                result[-1].append({'label': 'crew',
                 'current': currentCrewSize,
                 'total': len(vehicle.descriptor.type.crewRoles)})
            if eqs:
                result[-1].append({'label': 'equipments',
                 'current': len([ x for x in vehicle.eqs if x ]),
                 'total': len(vehicle.eqs)})
            if devices:
                result[-1].append({'label': 'devices',
                 'current': len([ x for x in vehicle.descriptor.optionalDevices if x ]),
                 'total': len(vehicle.descriptor.optionalDevices)})

        return result
    except Exception as ex:
        err(traceback.format_exc())
        return base(self)

# in battle, add tooltip for HE shells - explosion radius
def ConsumablesPanel__makeShellTooltip(base, self, descriptor, piercingPower):
    result = base(self, descriptor, piercingPower)
    try:
        if 'explosionRadius' in descriptor:
            key_str = i18n.makeString('#menu:tank_params/explosionRadius')
            result = result.replace('{/BODY}', '\n%s: %g{/BODY}' % (key_str, round(descriptor['explosionRadius'], 2)))
    except Exception as ex:
        err(traceback.format_exc())
    return result

# suppress carousel tooltips
def ToolTip_onCreateTypedTooltip(base, self, type, *args):
    try:
        if type == 'carouselVehicle' and config.get('hangar/carousel/suppressCarouselTooltips'):
            return
    except Exception as ex:
        err(traceback.format_exc())
    base(self, type, *args)

#####################################################################
# Utility functions

def h1_pad(text):
    return '<h1>%s</h1>' % text

def gold_pad(text):
    return "<font color='#FFC363'>%s</font>" % text

def smart_round(value):
    if value >= 10:
        return '%g' % round(value)
    elif value >= 1:
        return '%g' % round(value, 1)
    else: # < 1
        return '%g' % round(value, 2)

#####################################################################
# Register events

def _RegisterEvents():
    from gui.shared.tooltips.vehicle import VehicleParamsField
    OverrideMethod(VehicleParamsField, '_getValue', VehicleParamsField_getValue)
    from gui.Scaleform.daapi.view.battle.ConsumablesPanel import ConsumablesPanel
    OverrideMethod(ConsumablesPanel, '_ConsumablesPanel__makeShellTooltip', ConsumablesPanel__makeShellTooltip)
    from gui.Scaleform.framework.ToolTip import ToolTip
    OverrideMethod(ToolTip, 'onCreateTypedTooltip', ToolTip_onCreateTypedTooltip)

BigWorld.callback(0, _RegisterEvents)
