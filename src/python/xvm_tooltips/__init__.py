"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# Imports
#

# stdlib
import logging
from math import degrees, pi

# BigWorld/WoT
import BigWorld
import ResMgr
import nations
import gui.shared.tooltips.vehicle as tooltips_vehicle
from gun_rotation_shared import calcPitchLimitsFromDesc
from gui import g_htmlTemplates
from gui.shared import g_eventBus
from gui.shared.formatters import text_styles
from gui.shared.tooltips import formatters
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.items_parameters import formatters as param_formatter
from gui.shared.items_parameters.formatters import measureUnitsForParameter, MEASURE_UNITS
from gui.shared.items_parameters.params_helper import getParameters as getParameters_helper
from gui.shared.tooltips import getUnlockPrice
from gui.shared.utils.requesters.ItemsRequester import ItemsRequester
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.Scaleform.locale.MENU import MENU
from gui.Scaleform.locale.TOOLTIPS import TOOLTIPS
from gui.Scaleform.locale.STORAGE import STORAGE
from gui.Scaleform.locale.RES_ICONS import RES_ICONS
from gui.Scaleform.framework.tooltip_mgr import ToolTip
from gui.shared.tooltips.module import ModuleBlockTooltipData
from gui.impl.backport.backport_system_locale import getNiceNumberFormat
from items import _xml
from helpers import i18n
from constants import SHELL_TYPES, ITEM_DEFS_PATH

# XFW
from xfw import *

# XVM Main
import xvm_main.python.config as config
from xvm_main.python.consts import *
from xvm_main.python.logger import *
from xvm_main.python.vehinfo import _getRanges
from xvm_main.python.vehinfo_tiers import getTiers
from xvm_main.python.xvm import l10n

# Per-realm
if getRegion() != 'RU':
    from gui.shared.items_parameters.params_helper import similarCrewComparator as crewComparator_helper
else:
    from gui.shared.items_parameters.params_helper import idealCrewComparator as crewComparator_helper



#
# Globals
#

shellData = None
carousel_tooltips_cache = {}
styles_templates = {}
toolTipDelayIntervalId = None
weightTooHeavy = False
p_replacement = None # will be something like <font size... color...>



#
# Constants
#

class XVM_TOOLTIPS(object):
    HIDE = 'xvm_hide_tooltip'



#
# Classes
#

class ShellData(object):

    def __init__(self):
        self.shells = {}
        self.shell()
        self.data = {'costShell': {}}

    def shell(self):
        xmlPath = ''
        for nation in nations.NAMES:
            xmlPath = '%s%s%s%s' % (ITEM_DEFS_PATH, 'vehicles/', nation, '/components/shells.xml')
            xmlCtx_s = (((None, '{}/{}'.format(xmlPath, n)), s) for n, s in ResMgr.openSection(xmlPath).items() if (n != 'icons') and (n != 'xmlns:xmlref'))
            id_xmlCtx_s = ((_xml.readInt(xmlCtx, s, 'id', 0, 65535), xmlCtx, s) for xmlCtx, s in xmlCtx_s)
            self.shells[nation] = [i for i, xmlCtx, s in id_xmlCtx_s if s.readBool('improved', False)]
        ResMgr.purge(xmlPath, True)

    def typeShell(self, gun):
        self.data['costShell'] = {}
        for shell in gun.shots:
            shell_id = shell.shell.id
            self.data['costShell'][shell.shell.compactDescr] = 'gold' if shell_id[1] in self.shells[nations.NAMES[shell_id[0]]] else 'silver'
        return self.data['costShell']



#
# Handlers
#

def _i18n_makeString(base, key, *args, **kwargs):
    if config.get('tooltips/logLocalization', False):
        log('l10n key: ' + key + ', value: ' + base(key, *args, **kwargs))
    if key in config.get('tooltips/hideTooltips', []):
        return XVM_TOOLTIPS.HIDE
    return base(key, *args, **kwargs)

# tooltip delay to resolve performance issue
def _ToolTip_onCreateComplexTooltip(base, self, tooltipId, stateType):
    if tooltipId is None or XVM_TOOLTIPS.HIDE not in tooltipId:
        _createTooltip(self, lambda: _onCreateComplexTooltip_callback(base, self, tooltipId, stateType))

# tooltip delay to resolve performance issue
# suppress carousel tooltips
def _ToolTip_onCreateTypedTooltip(base, self, type, *args):
    if type == TOOLTIPS_CONSTANTS.CAROUSEL_VEHICLE and config.get('hangar/carousel/suppressCarouselTooltips'):
        return

    if isinstance(args[0], basestring) and XVM_TOOLTIPS.HIDE in args[0]:
        return
    _createTooltip(self, lambda: _onCreateTypedTooltip_callback(base, self, type, *args))

def _ToolTip_onHideTooltip(base, self, tooltipId):
    self.xvm_hide()
    base(self, tooltipId)

def _ToolTip_hide(self):
    self.xvm_hide()

# adds delay for tooltip appearance
def _createTooltip(self, func):
    try:
        global toolTipDelayIntervalId
        self.xvm_hide()
        tooltipDelay = config.get('tooltips/tooltipsDelay', 0.4)
        toolTipDelayIntervalId = BigWorld.callback(tooltipDelay, func)
    except Exception as ex:
        logging.getLogger('XVM/Tooltips').exception('_createTooltip')

def _onCreateTypedTooltip_callback(base, self, type, *args):
    try:
        global toolTipDelayIntervalId
        toolTipDelayIntervalId = None
        base(self, type, *args)
    except Exception as ex:
        logging.getLogger('XVM/Tooltips').exception('_onCreateTypedTooltip_callback')

def _onCreateComplexTooltip_callback(base, self, tooltipId, stateType):
    try:
        global toolTipDelayIntervalId
        toolTipDelayIntervalId = None
        base(self, tooltipId, stateType)
    except Exception as ex:
        logging.getLogger('XVM/Tooltips').exception('_onCreateComplexTooltip_callback')

def _ToolTip_xvm_hide(self):
    global toolTipDelayIntervalId
    if toolTipDelayIntervalId is not None:
        BigWorld.cancelCallback(toolTipDelayIntervalId)
        toolTipDelayIntervalId = None


#############################
# carousel events

def VehicleInfoTooltipData_packBlocks(base, self, *args, **kwargs):
    result = base(self, *args, **kwargs)
    result = [item for item in result if item.get('data', {}).get('blocksData')]
    return result


def SimplifiedStatsBlockConstructor_construct(base, self):
    if config.get('tooltips/hideSimplifiedVehParams'):
        return []
    else:
        return base(self)


def CrystalBlockConstructor_construct(base, self):
    if config.get('tooltips/hideCrystalBlock'):
        return [], None
    else:
        return base(self)


def AdditionalStatsBlockConstructor_construct(base, self):
    if config.get('tooltips/hideBottomText'):
        return []
    else:
        return base(self)

# TODO:1.5.0: disabled, is required?
#@overrideMethod(text_styles, "_getStyle")
def text_styles_getStyle(base, style, ctx = None):
    if ctx is None:
        ctx = {}
    try:
        if style not in styles_templates:
            template = g_htmlTemplates['html_templates:lobby/textStyle'][style].source
            template_string = template if type(template) is str else template['text']
            if "size='14'" in template_string and "face='$FieldFont'" in template_string:
                template_string = template_string \
                    .replace("size='14'", "size='%s'" % config.get('tooltips/fontSize', 14)) \
                    .replace("face='$FieldFont'", "face='%s'" % config.get('tooltips/fontName', '$FieldFont'))
            styles_templates[style] = template_string if type(template) is str else {'text': template_string}
        if type(styles_templates[style]) is str:
            return styles_templates[style]
        else:
            if ctx:
                return styles_templates[style]['text'] % ctx
            else:
                return base(style, ctx)
    except Exception:
        logging.getLogger('XVM/Tooltips').exception('text_styles_getStyle')
        return base(style, ctx)


# add to hangar tooltips display the missing experience to unlock the vehicle
def StatusBlockConstructor_construct(base, self):
    block = base(self)
    if block and config.get('tooltips/showXpToUnlockVeh'):
        try:
            techTreeNode = self.configuration.node
            vehicle = self.vehicle
            isUnlocked = vehicle.isUnlocked
            parentCD = int(techTreeNode.unlockProps.parentID) if techTreeNode is not None else None
            if parentCD is not None:
                isAvailable, cost, need, defCost, discount = getUnlockPrice(vehicle.intCD, parentCD, vehicle.level)
                if isAvailable and not isUnlocked and need > 0 and techTreeNode is not None:
                    icon = "<img src='{}' vspace='{}'".format(RES_ICONS.MAPS_ICONS_LIBRARY_XPCOSTICON_1.replace('..', 'img://gui'), -3)
                    template = "<font face='$TitleFont' size='14'><font color='#ff2717'>{}</font> {}</font> {}"
                    block[0]['data']['text'] = template.format(i18n.makeString(STORAGE.BLUEPRINTS_CARD_CONVERTREQUIRED), need, icon)
            return block
        except Exception:
            logging.getLogger('XVM/Tooltips').exception('StatusBlockConstructor_construct')
            return block
    else:
        return block

# overriding tooltips for tanks in hangar, configuration in tooltips.xc
def CommonStatsBlockConstructor_construct(base, self):
    try:
        self.leftPadding = -15
        vehicle = self.vehicle
        cache_result = carousel_tooltips_cache.get(vehicle.intCD)
        if cache_result:
            return cache_result
        result = []
        if not config.get('tooltips/hideSimplifiedVehParams'):
            result.append(formatters.packTitleDescBlock(text_styles.middleTitle(i18n.makeString(TOOLTIPS.TANKCARUSEL_MAINPROPERTY)), padding=formatters.packPadding(left=0, right=self.rightPadding, bottom=8)))
        params = self.configuration.params
        veh_descr = vehicle.descriptor
        gun = vehicle.gun.descriptor
        turret = vehicle.turret.descriptor
        comparator = crewComparator_helper(vehicle)
        vehicleCommonParams = getParameters_helper(vehicle)
        veh_type_inconfig = vehicle.type.replace('AT-SPG', 'TD')
        clipGunInfoShown = False
        costShell = shellData.typeShell(gun)
        if params:
            values = config.get('tooltips/%s' % veh_type_inconfig)
            if values and len(values):
                params_list = values # overriding parameters
            else:
                params_list = self.PARAMS.get(vehicle.type, 'default') # original parameters
            paramInfo = None
            for paramName in params_list:
                if paramName is None:
                    continue
                if paramName == 'rateOfFire':
                    paramName = 'reloadTime'
                if paramName == 'piercingPowerAvg':
                    paramName = 'avgPiercingPower'
                elif paramName == 'traverseLimits':
                    paramName = 'gunYawLimits' if 'gunYawLimits' in vehicleCommonParams else 'turretYawLimits'
                elif paramName == 'radioRange':
                    paramName = 'radioDistance'
                elif paramName == 'reloadTimeSecs' and (gun.clip[0] > 1):
                    paramName = 'clipFireRate'
                elif paramName == 'turretRotationSpeed' and not vehicle.hasTurrets:
                    paramName = 'gunRotationSpeed'
                if paramName in vehicleCommonParams:
                    paramInfo = comparator.getExtendedData(paramName)
                if paramName == 'turretArmor' and not vehicle.hasTurrets:
                    continue
                #maxHealth
                elif paramName == 'maxHealth':
                    tooltip_add_param(self, result, i18n.makeString(MENU.VEHICLEINFO_PARAMS_MAXHEALTH), formatNumber(veh_descr.maxHealth))
                #battle tiers
                elif paramName == 'battleTiers':
                    (minTier, maxTier) = getTiers(vehicle.level, vehicle.type, vehicle.name)
                    tooltip_add_param(self, result, l10n('Battle tiers'), '%s..%s' % (minTier, maxTier))
                #explosionRadius
                elif paramName == 'explosionRadius':
                    explosionRadiusMin = 999
                    explosionRadiusMax = 0
                    for shot in gun.shots:
                        if shot.shell.kind == SHELL_TYPES.HIGH_EXPLOSIVE:
                            explosionRadius = shot.shell.type.explosionRadius
                            if explosionRadius < explosionRadiusMin:
                                explosionRadiusMin = explosionRadius
                            if explosionRadius > explosionRadiusMax:
                                explosionRadiusMax = explosionRadius
                    if explosionRadiusMax == 0: # no HE
                        continue
                    explosionRadius_str = formatNumber(explosionRadiusMin)
                    if explosionRadiusMin != explosionRadiusMax:
                        explosionRadius_str += '/%s' % gold_pad(formatNumber(explosionRadiusMax))
                    tooltip_add_param(self, result, getParameterValue(paramName), explosionRadius_str)
                #shellSpeedSummary
                elif paramName == 'shellSpeedSummary':
                    shellSpeedSummary_arr = []
                    for shot in gun.shots:
                        shellSpeed_str = '%g' % round(shot.speed * 1.25)
                        if costShell[shot.shell.compactDescr] == 'gold':
                            shellSpeed_str = gold_pad(shellSpeed_str)
                        shellSpeedSummary_arr.append(shellSpeed_str)
                    shellSpeedSummary_str = '/'.join(shellSpeedSummary_arr)
                    tooltip_add_param(self, result, tooltip_with_units(l10n('shellSpeed'), l10n('(m/sec)')), shellSpeedSummary_str)
                #piercingPowerAvg
                # elif paramName == 'piercingPowerAvg':
                #     piercingPowerAvg = formatNumber(veh_descr.shot.piercingPower[0])
                #     tooltip_add_param(self, result, replace_p(i18n.makeString(MENU.TANK_PARAMS_AVGPIERCINGPOWER)), piercingPowerAvg)
                #piercingPowerAvgSummary
                elif paramName == 'piercingPowerAvgSummary':
                    piercingPowerAvgSummary_arr = []
                    for shot in gun.shots:
                        piercingPower_str = formatNumber(shot.piercingPower[0])
                        if costShell[shot.shell.compactDescr] == 'gold':
                            piercingPower_str = gold_pad(piercingPower_str)
                        piercingPowerAvgSummary_arr.append(piercingPower_str)
                    piercingPowerAvgSummary_str = '/'.join(piercingPowerAvgSummary_arr)
                    tooltip_add_param(self, result, replace_p(i18n.makeString(MENU.MODULEINFO_PARAMS_AVGPIERCINGPOWER)), piercingPowerAvgSummary_str)
                #damageAvgSummary
                elif paramName == 'damageAvgSummary':
                    damageAvgSummary_arr = []
                    for shot in gun.shots:
                        damage = shot.shell.armorDamage[0] if hasattr(shot.shell, 'armorDamage') else shot.shell.damage[0]
                        damageAvg_str = formatNumber(damage)
                        if costShell[shot.shell.compactDescr] == 'gold':
                            damageAvg_str = gold_pad(damageAvg_str)
                        damageAvgSummary_arr.append(damageAvg_str)
                    damageAvgSummary_str = '/'.join(damageAvgSummary_arr)
                    tooltip_add_param(self, result, replace_p(i18n.makeString(MENU.MODULEINFO_PARAMS_AVGDAMAGE)), damageAvgSummary_str)
                #magazine loading
                # elif (paramName == 'reloadTimeSecs' or paramName == 'rateOfFire') and vehicle.gun.isClipGun():
                #     if clipGunInfoShown:
                #         continue
                #     (shellsCount, shellReloadingTime) = gun.clip
                #     reloadMagazineTime = gun.reloadTime
                #     shellReloadingTime_str = formatNumber(shellReloadingTime)
                #     reloadMagazineTime_str = formatNumber(reloadMagazineTime)
                #     tooltip_add_param(self, result, replace_p(i18n.makeString(MENU.MODULEINFO_PARAMS_SHELLSCOUNT)), shellsCount)
                #     tooltip_add_param(self, result, replace_p(i18n.makeString(MENU.MODULEINFO_PARAMS_SHELLRELOADINGTIME)), shellReloadingTime_str)
                #     tooltip_add_param(self, result, replace_p(i18n.makeString(MENU.MODULEINFO_PARAMS_RELOADMAGAZINETIME)), reloadMagazineTime_str)
                #     clipGunInfoShown = True
                #rate of fire
                # elif paramName == 'rateOfFire' and not vehicle.gun.isClipGun():
                #     rateOfFire_str = formatNumber(60 / gun.reloadTime)
                #     tooltip_add_param(self, result, replace_p(i18n.makeString(MANU.MODULEINFO_PARAMS_RELOADTIME)), rateOfFire_str)
                # gun traverse limits
                # elif paramName == 'traverseLimits' and gun.turretYawLimits:
                #     (traverseMin, traverseMax) = gun.turretYawLimits
                #     traverseLimits_str = '%g..+%g' % (round(degrees(traverseMin)), round(degrees(traverseMax)))
                #     tooltip_add_param(self, result, l10n('traverseLimits'), traverseLimits_str)
                # elevation limits (front)
                # elif paramName == 'pitchLimits':
                #     (pitchMax, pitchMin) = calcPitchLimitsFromDesc(0, gun.pitchLimits)
                #     pitchLimits_str = '%g..+%g' % (round(degrees(-pitchMin)), round(degrees(-pitchMax)))
                #     tooltip_add_param(self, result, l10n('pitchLimits'), pitchLimits_str)
                # elevation limits (side)
                elif paramName == 'pitchLimitsSide':
                    if gun.turretYawLimits and abs(degrees(gun.turretYawLimits[0])) < 89: continue # can't look aside 90 degrees
                    (pitchMax, pitchMin) = calcPitchLimitsFromDesc(pi / 2, gun.pitchLimits)
                    pitchLimits_str = '%g..+%g' % (round(degrees(-pitchMin)), round(degrees(-pitchMax)))
                    tooltip_add_param(self, result, l10n('pitchLimitsSide'), pitchLimits_str)
                # elevation limits (rear)
                elif paramName == 'pitchLimitsRear':
                    if gun.turretYawLimits: continue # can't look back
                    (pitchMax, pitchMin) = calcPitchLimitsFromDesc(pi, gun.pitchLimits)
                    pitchLimits_str = '%g..+%g' % (round(degrees(-pitchMin)), round(degrees(-pitchMax)))
                    tooltip_add_param(self, result, l10n('pitchLimitsRear'), pitchLimits_str)
                # shooting range
                elif paramName == 'shootingRadius':
                    viewRange, shellRadius, artiRadius = _getRanges(turret, gun, vehicle.nationName, vehicle.type)
                    if vehicle.type == 'SPG':
                        if artiRadius > 0:
                            tooltip_add_param(self, result, tooltip_with_units(l10n('shootingRadius'), l10n('(m)')), artiRadius)
                        else:
                            tooltip_add_param(self, result, tooltip_with_units(l10n('flameMaxDistance'), l10n('(m)')), shellRadius)
                    elif shellRadius < 707:
                        tooltip_add_param(self, result, tooltip_with_units(l10n('shootingRadius'), l10n('(m)')), shellRadius)
                #reverse max speed
                elif paramName == 'speedLimits':
                    (speedLimitForward, speedLimitReverse) = veh_descr.physics['speedLimits']
                    speedLimits_str = str(int(speedLimitForward * 3.6)) + '/' + str(int(speedLimitReverse * 3.6))
                    tooltip_add_param(self, result, getParameterValue(paramName), speedLimits_str)
                #turret rotation speed
                # elif paramName == 'turretRotationSpeed' or paramName == 'gunRotationSpeed':
                #     if not vehicle.hasTurrets:
                #         paramName = 'gunRotationSpeed'
                #     turretRotationSpeed_str = str(int(degrees(veh_descr.turret.rotationSpeed)))
                #     tooltip_add_param(self, result, tooltip_with_units(i18n.makeString('#menu:tank_params/%s' % paramName).rstrip(), i18n.makeString(MENU.TANK_PARAMS_GPS)), turretRotationSpeed_str)
                #terrain resistance
                elif paramName == 'terrainResistance':
                    resistances_arr = []
                    for key in veh_descr.chassis.terrainResistance:
                        resistances_arr.append(formatNumber(key))
                    terrainResistance_str = '/'.join(resistances_arr)
                    tooltip_add_param(self, result, l10n('terrainResistance'), terrainResistance_str)
                #radioRange
                # elif paramName == 'radioRange':
                #     radioRange_str = '%s' % int(vehicle.radio.descriptor.distance)
                #     tooltip_add_param(self, result, replace_p(i18n.makeString(MENU.TANK_PARAMS_RADIODISTANCE)), radioRange_str)
                #gravity
                elif paramName == 'gravity':
                    gravity_str = formatNumber(veh_descr.shot.gravity)
                    tooltip_add_param(self, result, l10n('gravity'), gravity_str)
                #inner name, for example - ussr:R100_SU122A
                elif paramName == 'innerName':
                    tooltip_add_param(self, result, vehicle.name, '')
                #custom text
                elif paramName.startswith('TEXT:'):
                    customtext = paramName[5:]
                    tooltip_add_param(self, result, l10n(customtext), '')
                elif paramInfo is not None and paramName in paramInfo.name and paramName in MEASURE_UNITS:
                    valueStr = str(param_formatter.formatParameter(paramName, paramInfo.value))
                    tooltip_add_param(self, result, getParameterValue(paramName), valueStr)
        if vehicle.isInInventory:
            # optional devices icons, must be in the end
            if 'optDevicesIcons' in params_list:
                optDevicesIcons_arr = []
                for key in vehicle.optDevices.installed.getItems():
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
                for key in vehicle.consumables.installed.getItems():
                    if key:
                        imgPath = 'img://gui' + key.icon.lstrip('.')
                    else:
                        imgPath = 'img://gui/maps/icons/artefact/empty.png'
                    equipmentIcons_arr.append('<img src="%s" height="16" width="16">' % imgPath)
                for key in vehicle.battleBoosters.installed.getItems():
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
        if (len(result) > 30) and config.get('tooltips/hideBottomText'): # limitation
            result = result[:30]
        elif (len(result) > 29) and not config.get('tooltips/hideBottomText'): # limitation
            result = result[:29]
        carousel_tooltips_cache[vehicle.intCD] = result
        return result
    except Exception:
        logging.getLogger('XVM/Tooltips').exception('CommonStatsBlockConstructor_construct')
        return base(self)

# add '#menu:moduleInfo/params/weightTooHeavy' (red 'weight (kg)')
# def makeString(base, key, *args, **kwargs):
#     if key == '#menu:moduleInfo/params/weightTooHeavy':
#         global weightTooHeavy
#         if weightTooHeavy is None:
#             weightTooHeavy = '<h>%s</h>' % red_pad(strip_html_tags(i18n.makeString(MENU.MODULEINFO_PARAMS_WEIGHT))) # localized red 'weight (kg)'
#         return weightTooHeavy
#     return base(key, *args, **kwargs)



#
# Handlers/Overweight
#

# paint 'weight (kg)' with red if module does not fit due to overweight
def formatters_formatModuleParamName(base, paramName, vDescr=None):
    builder = text_styles.builder()
    if weightTooHeavy and paramName == 'weight':
        builder.addStyledText(text_styles.error, MENU.moduleinfo_params(paramName))
        builder.addStyledText(text_styles.error, param_formatter.MEASURE_UNITS.get(paramName, ''))
        return builder.render()
    return base(paramName, vDescr)


def ModuleBlockTooltipData_packBlocks(base, self, *args, **kwargs):
    try:
        global weightTooHeavy
        module = self.context.buildItem(*args, **kwargs)
        statusConfig = self.context.getStatusConfiguration(module)
        vehicle = statusConfig.vehicle
        slotIdx = statusConfig.slotIdx
        if vehicle is not None:
            isFit, reason = module.mayInstall(vehicle, slotIdx)
            weightTooHeavy = not isFit and reason == 'too heavy'
    except Exception:
        logging.getLogger('XVM/Tooltips').exception('ModuleBlockTooltipData_packBlocks')
    return base(self, *args, **kwargs)


def ItemsRequester_invalidateItems(self, itemTypeID, uniqueIDs):
    try:
        if itemTypeID == GUI_ITEM_TYPE.VEHICLE:
            for veh_id in uniqueIDs:
                carousel_tooltips_cache[veh_id] = {}
    except Exception:
        logging.getLogger('XVM/Tooltips').exception('ItemsRequester_invalidateItems')
        carousel_tooltips_cache.clear()


def ItemsRequester_clear(*args, **kwargs):
    tooltips_clear_cache(*args, **kwargs)


def tooltips_clear_cache(*args, **kwargs):
    carousel_tooltips_cache.clear()
    styles_templates.clear()


#
# Helpers
#

def h1_pad(text):
    return '<h1>%s</h1>' % text

def gold_pad(text):
    return "<font color='%s'>%s</font>" % (config.get('tooltips/goldColor', '#FFC363'), text)

def red_pad(text):
    return "<font color='#FF0000'>%s</font>" % text


def tooltip_add_param(self, result, param0, param1):
    result.append(formatters.packTextParameterBlockData(name=text_styles.main(param0), value=text_styles.stats(param1), valueWidth=107, padding=formatters.packPadding(left=self.leftPadding, right=self.rightPadding)))

def tooltip_with_units(value, units):
    return '%s %s' % (value, text_styles.standard(units))

def getParameterValue(paramName):
    return text_styles.main(i18n.makeString(MENU.tank_params(paramName))) + text_styles.standard(measureUnitsForParameter(paramName))

def formatNumber(value):
    if value > 99:
        value = round(value)
    elif value > 9:
        value = round(value, 1)
    else:
        value = round(value, 2)
    return str(getNiceNumberFormat(value))

# replace <h>text1 <p>text2</p></h> with: text1 text_styles.standard(text2)
def replace_p(text):
    global p_replacement
    if not p_replacement:
        p_replacement = text_styles.standard('').split('>', 1)[0] + '>'
    return text.replace('<p>', p_replacement).replace('</p>', '</font>').replace('<h>', '').replace('</h>', '')



#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized, shellData
    if not __initialized:
        shellData = ShellData()
        ToolTip.xvm_hide = _ToolTip_xvm_hide

        overrideMethod(i18n, 'makeString')(_i18n_makeString)
        overrideMethod(ToolTip, 'onCreateComplexTooltip')(_ToolTip_onCreateComplexTooltip)
        overrideMethod(ToolTip, 'onCreateTypedTooltip')(_ToolTip_onCreateTypedTooltip)
        overrideMethod(ToolTip, 'onHideTooltip')(_ToolTip_onHideTooltip)
        registerEvent(ToolTip, 'hide', prepend=True)(_ToolTip_hide)
        overrideMethod(tooltips_vehicle.VehicleInfoTooltipData, '_packBlocks')(VehicleInfoTooltipData_packBlocks)
        overrideMethod(tooltips_vehicle.SimplifiedStatsBlockConstructor, 'construct')(SimplifiedStatsBlockConstructor_construct)
        overrideMethod(tooltips_vehicle.CrystalBlockConstructor, 'construct')(CrystalBlockConstructor_construct)
        overrideMethod(tooltips_vehicle.AdditionalStatsBlockConstructor, 'construct')(AdditionalStatsBlockConstructor_construct)
        overrideMethod(tooltips_vehicle.StatusBlockConstructor, 'construct')(StatusBlockConstructor_construct)
        overrideMethod(tooltips_vehicle.CommonStatsBlockConstructor, 'construct')(CommonStatsBlockConstructor_construct)
        # overrideMethod(i18n, 'makeString')(makeString)
        overrideMethod(param_formatter, 'formatModuleParamName')(formatters_formatModuleParamName)
        overrideMethod(ModuleBlockTooltipData, '_packBlocks')(ModuleBlockTooltipData_packBlocks)
        registerEvent(ItemsRequester, '_invalidateItems')(ItemsRequester_invalidateItems)
        registerEvent(ItemsRequester, 'clear')(ItemsRequester_clear)

        g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, tooltips_clear_cache)

        __initialized = True


def xfw_module_fini():
    global __initialized, shellData
    if __initialized:
        shellData = None
        g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, tooltips_clear_cache)

        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
