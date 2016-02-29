""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.14',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.14'],
    # optional
}


#####################################################################
# imports

import traceback
import sys
from math import degrees, pi

import BigWorld
import game
import gui.shared.tooltips.vehicle as tooltips_vehicle
from gun_rotation_shared import calcPitchLimitsFromDesc
from helpers import i18n
from gui import g_htmlTemplates
from gui.shared import g_eventBus, g_itemsCache
from gui.shared.formatters import text_styles
from gui.shared.tooltips import formatters
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.tooltips.module import ModuleParamsField
from gui.shared.utils import ItemsParameters, ParametersCache
from gui.shared.utils.requesters.ItemsRequester import ItemsRequester
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.Scaleform.locale.MENU import MENU
from gui.Scaleform.locale.TOOLTIPS import TOOLTIPS
from gui.Scaleform.framework.ToolTip import ToolTip
from gui.Scaleform.daapi.view.battle.ConsumablesPanel import ConsumablesPanel
from gui.Scaleform.daapi.view.meta.ModuleInfoMeta import ModuleInfoMeta
from xfw import *

import xvm_main.python.config as config
from xvm_main.python.constants import *
from xvm_main.python.logger import *
from xvm_main.python.vehinfo import _getRanges
from xvm_main.python.vehinfo_tiers import getTiers
from xvm_main.python.vehinfo_camo import getCamoValues
from xvm_main.python.xvm import l10n
# import "private" copy of text_styles for patching
orig_text_styles = sys.modules.pop('gui.shared.formatters.text_styles')
import gui.shared.formatters.text_styles as patched_text_styles
sys.modules['gui.shared.formatters.text_styles'] = orig_text_styles

#####################################################################
# globals

shells_vehicles_compatibility = {}
carousel_tooltips_cache = {}
styles_templates = {}
toolTipDelayIntervalId = None
weightTooHeavy = None  # will be localized red 'weight (kg)'

#####################################################################
# initialization/finalization

def start():
    g_eventBus.addListener(XVM_EVENT.RELOAD_CONFIG, tooltips_clear_cache)

    # patching text_styles for our font/size
    patched_text_styles._getStyle = text_styles_getStyle
    tooltips_vehicle.text_styles = patched_text_styles

BigWorld.callback(0, start)


@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XVM_EVENT.RELOAD_CONFIG, tooltips_clear_cache)


#####################################################################
# handlers

# tooltip delay to resolve performance issue
@overrideMethod(ToolTip, 'onCreateComplexTooltip')
def ToolTip_onCreateComplexTooltip(base, self, tooltipId, stateType):
    # log('ToolTip_onCreateComplexTooltip')
    _createTooltip(self, lambda:_onCreateComplexTooltip_callback(base, self, tooltipId, stateType))


# tooltip delay to resolve performance issue
# suppress carousel tooltips
@overrideMethod(ToolTip, 'onCreateTypedTooltip')
def ToolTip_onCreateTypedTooltip(base, self, type, *args):
    # log('ToolTip_onCreateTypedTooltip')
    try:
        if type == TOOLTIPS_CONSTANTS.CAROUSEL_VEHICLE and config.get('hangar/carousel/suppressCarouselTooltips'):
            return
    except Exception as ex:
        err(traceback.format_exc())

    _createTooltip(self, lambda:_onCreateTypedTooltip_callback(base, self, type, *args))


# adds delay for tooltip appearance
def _createTooltip(self, func):
    try:
        global toolTipDelayIntervalId
        self.xvm_hide()
        tooltipDelay = config.get('tooltips/tooltipsDelay', 0.4)
        toolTipDelayIntervalId = BigWorld.callback(tooltipDelay, func)
    except Exception as ex:
        err(traceback.format_exc())


def _onCreateTypedTooltip_callback(base, self, type, *args):
    # log('ToolTip_onCreateTypedTooltip_callback')
    global toolTipDelayIntervalId
    toolTipDelayIntervalId = None
    base(self, type, *args)


def _onCreateComplexTooltip_callback(base, self, tooltipId, stateType):
    # log('_onCreateComplexTooltip_callback')
    global toolTipDelayIntervalId
    toolTipDelayIntervalId = None
    base(self, tooltipId, stateType)


def _ToolTip_xvm_hide(self):
    # log('_ToolTip_xvm_hide')
    global toolTipDelayIntervalId
    if toolTipDelayIntervalId is not None:
        BigWorld.cancelCallback(toolTipDelayIntervalId)
        toolTipDelayIntervalId = None

ToolTip.xvm_hide = _ToolTip_xvm_hide


#############################
# carousel events

@overrideMethod(tooltips_vehicle.VehicleInfoTooltipData, '_packBlocks')
def VehicleInfoTooltipData_packBlocks(base, self, *args, **kwargs):
    result = base(self, *args, **kwargs)
    result = [item for item in result if item.get('data', {}).get('blocksData')]
    return result

@overrideMethod(tooltips_vehicle.AdditionalStatsBlockConstructor, 'construct')
def AdditionalStatsBlockConstructor_construct(base, self):
    if config.get('tooltips/hideBottomText'):
        lockBlock = self._makeLockBlock()
        if lockBlock is not None:
            return [lockBlock]
        return []
    else:
        return base(self)

# patched _getStyle to use out font/size
def text_styles_getStyle(style, ctx = {}):
    if style not in styles_templates:
        styles_templates[style] = g_htmlTemplates['html_templates:lobby/textStyle'].format(style)
        if "'14'" in styles_templates[style] and '$FieldFont' in styles_templates[style]:
            styles_templates[style] = styles_templates[style].replace("size='14'", "size='%s'" % config.get('tooltips/fontSize', 14)).replace("face='$FieldFont'", "face='%s'" % config.get('tooltips/fontName', '$FieldFont'))
    return styles_templates[style] % ctx


def tooltip_add_param(self, result, param0, param1):
    result.append(formatters.packTextParameterBlockData(name=patched_text_styles.main(param0), value=patched_text_styles.stats(param1), valueWidth=90, padding=formatters.packPadding(left=self.leftPadding, right=self.rightPadding)))


# overriding tooltips for tanks in hangar, configuration in tooltips.xc
@overrideMethod(tooltips_vehicle.CommonStatsBlockConstructor, 'construct')
def CommonStatsBlockConstructor_construct(base, self):
    try:
        vehicle = self.vehicle
        cache_result = carousel_tooltips_cache.get(vehicle.intCD)
        if cache_result:
            return cache_result
        result = [formatters.packTitleDescBlock(patched_text_styles.middleTitle(i18n.makeString(TOOLTIPS.TANKCARUSEL_MAINPROPERTY)), padding=formatters.packPadding(left=self.leftPadding, right=self.rightPadding, bottom=8))]
        params = self.configuration.params
        veh_descr = vehicle.descriptor
        gun = vehicle.gun.descriptor
        turret = vehicle.turret.descriptor
        vehicleCommonParams = dict(ItemsParameters.g_instance.getParameters(veh_descr))
        vehicleRawParams = dict(ParametersCache.g_instance.getParameters(veh_descr))
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
                params_list = self.PARAMS.get(vehicle.type, 'default') # original parameters
            for paramName in params_list:
                if paramName == 'turretArmor' and not vehicle.hasTurrets:
                    continue
                #maxHealth
                elif paramName == 'maxHealth':
                    tooltip_add_param(self, result, h1_pad(i18n.makeString('#menu:vehicleInfo/params/maxHealth')), h1_pad(veh_descr.maxHealth))
                #battle tiers
                elif paramName == 'battleTiers':
                    (minTier, maxTier) = getTiers(vehicle.level, vehicle.type, vehicle.name)
                    tooltip_add_param(self, result, h1_pad(l10n('Battle tiers')), h1_pad('%s..%s' % (minTier, maxTier)))
                #camo coeffitients
                elif paramName == 'camo_coeff':
                    topTurret = veh_descr.type.turrets[0][-1]
                    camo_coeff_arr = getCamoValues(vehicle.name, turret['name'] == topTurret['name'], gun['name'])
                    camo_coeff_str = '/'.join(map(camo_smart_round, camo_coeff_arr))
                    tooltip_add_param(self, result, h1_pad(l10n('camoCoeff') + ' <p>(%)</p>'), h1_pad(camo_coeff_str))
                #explosionRadius
                elif paramName == 'explosionRadius':
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
                        explosionRadius_str += '/%s' % gold_pad('%g' % round(explosionRadiusMax, 2))
                    tooltip_add_param(self, result, self._getParameterValue(paramName, vehicleCommonParams, vehicleRawParams)[0], h1_pad(explosionRadius_str))
                #shellSpeedSummary
                elif paramName == 'shellSpeedSummary':
                    shellSpeedSummary_arr = []
                    for shot in gun['shots']:
                        shellSpeed_str = '%g' % round(shot['speed'] * 1.25)
                        if premium_shells[shot['shell']['compactDescr']]:
                            shellSpeed_str = gold_pad(shellSpeed_str)
                        shellSpeedSummary_arr.append(shellSpeed_str)
                    shellSpeedSummary_str = '/'.join(shellSpeedSummary_arr)
                    tooltip_add_param(self, result, h1_pad('%s <p>%s</p>' % (l10n('shellSpeed'), l10n('(m/sec)'))), h1_pad(shellSpeedSummary_str))
                #piercingPowerAvg
                elif paramName == 'piercingPowerAvg':
                    piercingPowerAvg = '%g' % veh_descr.shot['piercingPower'][0]
                    tooltip_add_param(self, result, i18n.makeString('#menu:moduleInfo/params/avgPiercingPower').replace('h>', 'h1>'), h1_pad(piercingPowerAvg))
                #piercingPowerAvgSummary
                elif paramName == 'piercingPowerAvgSummary':
                    piercingPowerAvgSummary_arr = []
                    for shot in gun['shots']:
                        piercingPower_str = '%g' % shot['piercingPower'][0]
                        if premium_shells[shot['shell']['compactDescr']]:
                            piercingPower_str = gold_pad(piercingPower_str)
                        piercingPowerAvgSummary_arr.append(piercingPower_str)
                    piercingPowerAvgSummary_str = '/'.join(piercingPowerAvgSummary_arr)
                    tooltip_add_param(self, result, i18n.makeString('#menu:moduleInfo/params/avgPiercingPower').replace('h>', 'h1>'), h1_pad(piercingPowerAvgSummary_str))
                #damageAvgSummary
                elif paramName == 'damageAvgSummary':
                    damageAvgSummary_arr = []
                    for shot in gun['shots']:
                        damageAvg_str = '%g' % shot['shell']['damage'][0]
                        if premium_shells[shot['shell']['compactDescr']]:
                            damageAvg_str = gold_pad(damageAvg_str)
                        damageAvgSummary_arr.append(damageAvg_str)
                    damageAvgSummary_str = '/'.join(damageAvgSummary_arr)
                    tooltip_add_param(self, result, i18n.makeString('#menu:moduleInfo/params/avgDamage').replace('h>', 'h1>'), h1_pad(damageAvgSummary_str))
                #magazine loading
                elif (paramName == 'reloadTimeSecs' or paramName == 'rateOfFire') and vehicle.gun.isClipGun():
                    if clipGunInfoShown:
                        continue
                    (shellsCount, shellReloadingTime) = gun['clip']
                    reloadMagazineTime = gun['reloadTime']
                    shellReloadingTime_str = '%g' % round(shellReloadingTime, 2)
                    reloadMagazineTime_str = '%g' % round(reloadMagazineTime, 2)
                    tooltip_add_param(self, result, i18n.makeString('#menu:moduleInfo/params/shellsCount').replace('h>', 'h1>'), h1_pad(shellsCount))
                    tooltip_add_param(self, result, i18n.makeString('#menu:moduleInfo/params/shellReloadingTime').replace('h>', 'h1>'), h1_pad(shellReloadingTime_str))
                    tooltip_add_param(self, result, i18n.makeString('#menu:moduleInfo/params/reloadMagazineTime').replace('h>', 'h1>'), h1_pad(reloadMagazineTime_str))
                    clipGunInfoShown = True
                #rate of fire
                elif paramName == 'rateOfFire' and not vehicle.gun.isClipGun():
                    rateOfFire_str = '%g' % round(60 / gun['reloadTime'], 2)
                    tooltip_add_param(self, result, i18n.makeString('#menu:moduleInfo/params/reloadTime').replace('h>', 'h1>'), h1_pad(rateOfFire_str))
                # gun traverse limits
                elif paramName == 'traverseLimits' and gun['turretYawLimits']:
                    (traverseMin, traverseMax) = gun['turretYawLimits']
                    traverseLimits_str = '%g..+%g' % (round(degrees(traverseMin)), round(degrees(traverseMax)))
                    tooltip_add_param(self, result, h1_pad(l10n('traverseLimits')), h1_pad(traverseLimits_str))
                # elevation limits (front)
                elif paramName == 'pitchLimits':
                    (pitchMax, pitchMin) = calcPitchLimitsFromDesc(0, gun['pitchLimits'])
                    pitchLimits_str = '%g..+%g' % (round(degrees(-pitchMin)), round(degrees(-pitchMax)))
                    tooltip_add_param(self, result, h1_pad(l10n('pitchLimits')), h1_pad(pitchLimits_str))
                # elevation limits (side)
                elif paramName == 'pitchLimitsSide':
                    if gun['turretYawLimits'] and abs(degrees(gun['turretYawLimits'][0])) < 89: continue # can't look aside 90 degrees
                    (pitchMax, pitchMin) = calcPitchLimitsFromDesc(pi / 2, gun['pitchLimits'])
                    pitchLimits_str = '%g..+%g' % (round(degrees(-pitchMin)), round(degrees(-pitchMax)))
                    tooltip_add_param(self, result, h1_pad(l10n('pitchLimitsSide')), h1_pad(pitchLimits_str))
                # elevation limits (rear)
                elif paramName == 'pitchLimitsRear':
                    if gun['turretYawLimits']: continue # can't look back
                    (pitchMax, pitchMin) = calcPitchLimitsFromDesc(pi, gun['pitchLimits'])
                    pitchLimits_str = '%g..+%g' % (round(degrees(-pitchMin)), round(degrees(-pitchMax)))
                    tooltip_add_param(self, result, h1_pad(l10n('pitchLimitsRear')), h1_pad(pitchLimits_str))
                # shooting range
                elif paramName == 'shootingRadius':
                    viewRange, shellRadius, artiRadius = _getRanges(turret, gun, vehicle.nationName, vehicle.type)
                    if vehicle.type == 'SPG':
                        tooltip_add_param(self, result, h1_pad('%s <p>%s</p>' % (l10n('shootingRadius'), l10n('(m)'))), h1_pad(artiRadius))
                    elif shellRadius < 707:
                        tooltip_add_param(self, result, h1_pad('%s <p>%s</p>' % (l10n('shootingRadius'), l10n('(m)'))), h1_pad(shellRadius))
                #reverse max speed
                elif paramName == 'speedLimits':
                    (speedLimitForward, speedLimitReverse) = veh_descr.physics['speedLimits']
                    speedLimits_str = str(int(speedLimitForward * 3.6)) + '/' + str(int(speedLimitReverse * 3.6))
                    tooltip_add_param(self, result, self._getParameterValue(paramName, vehicleCommonParams, vehicleRawParams)[0], speedLimits_str)
                #turret rotation speed
                elif paramName == 'turretRotationSpeed' or paramName == 'gunRotationSpeed':
                    #if not vehicle.hasTurrets:
                    paramName = 'gunRotationSpeed'
                    turretRotationSpeed_str = str(int(degrees(veh_descr.turret['rotationSpeed'])))
                    tooltip_add_param(self, result, i18n.makeString('#menu:moduleInfo/params/rotationSpeed').replace('h>', 'h1>'), turretRotationSpeed_str)
                #terrain resistance
                elif paramName == 'terrainResistance':
                    resistances_arr = []
                    for key in veh_descr.chassis['terrainResistance']:
                        resistances_arr.append('%g' % round(key, 2))
                    terrainResistance_str = '/'.join(resistances_arr)
                    tooltip_add_param(self, result, h1_pad(l10n('terrainResistance')), h1_pad(terrainResistance_str))
                #custom text
                elif paramName.startswith('TEXT:'):
                    customtext = paramName[5:]
                    tooltip_add_param(self, result, h1_pad(l10n(customtext)), '')
                elif paramName in vehicleCommonParams or paramName in vehicleRawParams:
                    param0, param1 = self._getParameterValue(paramName, vehicleCommonParams, vehicleRawParams)
                    tooltip_add_param(self, result, param0, param1)
                #radioRange
                elif paramName == 'radioRange':
                    radioRange_str = '%s' % int(vehicle.radio.descriptor['distance'])
                    tooltip_add_param(self, result, i18n.makeString('#menu:moduleInfo/params/radioDistance').replace('h>', 'h1>'), h1_pad(radioRange_str))
                #gravity
                elif paramName == 'gravity':
                    gravity_str = '%g' % round(veh_descr.shot['gravity'], 2)
                    tooltip_add_param(self, result, h1_pad(l10n('gravity')), h1_pad(gravity_str))
                #inner name, for example - ussr:R100_SU122A
                elif paramName == 'innerName':
                    tooltip_add_param(self, result, h1_pad(vehicle.name), '')
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
                tooltip_add_param(self, result, optDevicesIcons_str, '')

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
                    tmp_list = []
                    tooltip_add_param(self, tmp_list, equipmentIcons_str, '')
                    result[-1]['data']['name'] += ' ' + tmp_list[0]['data']['name']
                else:
                    tooltip_add_param(self, result, equipmentIcons_str, '')

        # crew roles icons, must be in the end
        if 'crewRolesIcons' in params_list:
            imgPath = 'img://../mods/shared_resources/xvm/res/icons/tooltips/roles'
            crewRolesIcons_arr = []
            for tankman_role in vehicle.descriptor.type.crewRoles:
                crewRolesIcons_arr.append('<img src="%s/%s.png" height="16" width="16">' % (imgPath, tankman_role[0]))
            crewRolesIcons_str = ''.join(crewRolesIcons_arr)
            tooltip_add_param(self, result, crewRolesIcons_str, '')

        carousel_tooltips_cache[vehicle.intCD] = result
        return result
    except Exception as ex:
        err(traceback.format_exc())
        return base(self)


# in battle, add tooltip for HE shells - explosion radius
@overrideMethod(ConsumablesPanel, '_ConsumablesPanel__makeShellTooltip')
def ConsumablesPanel__makeShellTooltip(base, self, descriptor, piercingPower):
    result = base(self, descriptor, piercingPower)
    try:
        if 'explosionRadius' in descriptor:
            key_str = i18n.makeString('#menu:tank_params/explosionRadius')
            result = result.replace('{/BODY}', '\n%s: %g{/BODY}' % (key_str, round(descriptor['explosionRadius'], 2)))
    except Exception as ex:
        err(traceback.format_exc())
    return result

# show compatible vehicles for shells info window in warehouse and shop
@overrideMethod(ModuleInfoMeta, 'as_setModuleInfoS')
def ModuleInfoMeta_as_setModuleInfoS(base, self, moduleInfo):
    try:
        if moduleInfo.get('type') == 'shell':
            if not shells_vehicles_compatibility:
                relate_shells_vehicles()
            if self.moduleCompactDescr in shells_vehicles_compatibility:
                moduleInfo['compatible'].append({'type': i18n.makeString(MENU.moduleinfo_compatible('vehicles')), 'value': ', '.join(shells_vehicles_compatibility[self.moduleCompactDescr])})
    except Exception as ex:
        err(traceback.format_exc())
    base(self, moduleInfo)

# add '#menu:moduleInfo/params/weightTooHeavy' (red 'weight (kg)')
@overrideMethod(i18n, 'makeString')
def makeString(base, key, *args, **kwargs):
    if key == '#menu:moduleInfo/params/weightTooHeavy':
        global weightTooHeavy
        if weightTooHeavy is None:
            weightTooHeavy = '<h>%s</h>' % red_pad(strip_html_tags(i18n.makeString('#menu:moduleInfo/params/weight'))) # localized red 'weight (kg)'
        return weightTooHeavy
    return base(key, *args, **kwargs)

# paint 'weight (kg)' with red if module does not fit due to overweight
@overrideMethod(ModuleParamsField, '_getValue')
def ModuleParamsField_getValue(base, self, *args, **kwargs):
    result = base(self, *args, **kwargs)
    try:
        try:
            param_name = result[0][-1][0]
        except:
            param_name = 'wrong item'
        if param_name == 'weight':
            module = self._tooltip.item
            configuration = self._tooltip.context.getStatusConfiguration(module)
            vehicle = configuration.vehicle
            slotIdx = configuration.slotIdx
            if vehicle is not None:
                isFit, reason = module.mayInstall(vehicle, slotIdx)
                if not isFit and reason == 'too heavy':
                    result[0][-1][0] = 'weightTooHeavy'
    except Exception as ex:
        err(traceback.format_exc())
    return result


#####################################################################
# Utility functions

def h1_pad(text):
    return '<h1>%s</h1>' % text

def gold_pad(text):
    return "<font color='%s'>%s</font>" % (config.get('tooltips/goldColor', '#FFC363'), text)

def red_pad(text):
    return "<font color='#FF0000'>%s</font>" % text

def camo_smart_round(value):
    if value == 0:
        return '?'
    if value >= 10:
        return '%g' % round(value)
    if value >= 1:
        return '%g' % round(value, 1)
    return '%g' % round(value, 2) # < 1

# make dict: shells => compatible vehicles
def relate_shells_vehicles():
    global shells_vehicles_compatibility
    try:
        shells_vehicles_compatibility = {}
        for vehicle in g_itemsCache.items.getVehicles().values():
            if vehicle.name.find('_IGR') > 0 or vehicle.name.find('_training') > 0:
                continue
            for turrets in vehicle.descriptor.type.turrets:
                for turret in turrets:
                    for gun in turret['guns']:
                        for shot in gun['shots']:
                            shell_id = shot['shell']['compactDescr']
                            if shell_id in shells_vehicles_compatibility:
                                if vehicle.userName not in shells_vehicles_compatibility[shell_id]:
                                    shells_vehicles_compatibility[shell_id].append(vehicle.userName)
                            else:
                                shells_vehicles_compatibility[shell_id] = [vehicle.userName]
    except Exception as ex:
        err(traceback.format_exc())
        shells_vehicles_compatibility = {}


@registerEvent(ItemsRequester, '_invalidateItems')
def ItemsRequester_invalidateItems(self, itemTypeID, uniqueIDs):
    try:
        if itemTypeID == GUI_ITEM_TYPE.VEHICLE:
            for veh_id in uniqueIDs:
                carousel_tooltips_cache[veh_id] = {}
    except Exception as ex:
        err(traceback.format_exc())
        carousel_tooltips_cache.clear()


@registerEvent(ItemsRequester, 'clear')
def ItemsRequester_clear(*args, **kwargs):
    tooltips_clear_cache(*args, **kwargs)


def tooltips_clear_cache(*args, **kwargs):
    carousel_tooltips_cache.clear()
    styles_templates.clear()

