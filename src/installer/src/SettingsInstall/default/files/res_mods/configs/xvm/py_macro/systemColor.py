from xvm_main.python.logger import *
import xvm_main.python.config as config
from xfw.events import registerEvent, overrideMethod

import BigWorld
from Account import PlayerAccount
from Avatar import PlayerAvatar
from gui.Scaleform.daapi.view.battle.shared.messages.fading_messages import FadingMessages
from helpers.EdgeDetectColorController import g_instance


isSquad = False
isTeamKill = False

def toHTMLColor(color):
    return '#{}'.format(color[2:]) if color[:2] == '0x' else color


@registerEvent(FadingMessages, '_populate')
def _populate(self):
    ally_dead = toHTMLColor(config.get('colors/system/ally_dead', None))
    enemy_dead = toHTMLColor(config.get('colors/system/enemy_dead', None))
    for k, v in self._FadingMessages__messages.iteritems():
        if k[:6] == 'DEATH_':
            message, colors = v
            if ('red' in colors) and (ally_dead is not None):
                self._FadingMessages__messages[k] = "<font color='{}'>{}</font>".format(enemy_dead, message), colors
            elif ('green' in colors) and (enemy_dead is not None):
                self._FadingMessages__messages[k] = "<font color='{}'>{}</font>".format(ally_dead, message), colors


def colorVector(color, default):
    try:
        color = '{}{}'.format(color[-6:], 'FF')
        return tuple(int(color[i:i+2], 16) / 255.0 for i in (0, 2, 4, 6))
    except ValueError:
        return default


@overrideMethod(g_instance, '_EdgeDetectColorController__changeColor')
def __changeColor(base, diff):
    if 'isColorBlind' not in diff:
        return
    cType = 'colorBlind' if diff['isColorBlind'] else 'common'
    isHangar = isinstance(BigWorld.player(), PlayerAccount)
    colors = g_instance._EdgeDetectColorController__colors[cType]

    if isSquad:
        friend = colorVector(config.get('colors/system/squadman_alive', '#FFB964'), colors['friend'])
        enemy = colorVector(config.get('colors/system/enemy_alive', '#2C9AFF'), colors['enemy'])
    elif isTeamKill:
        currentColor = config.get('colors/system/teamKiller_alive', '#00EAFF')
        friend = colorVector(currentColor, colors['friend'])
        enemy = colorVector(currentColor, colors['enemy'])
    else:
        friend = colorVector(config.get('colors/system/ally_alive', '#96FF00'), colors['friend'])
        enemy = colorVector(config.get('colors/system/enemy_alive', '#2C9AFF'), colors['enemy'])

    colorsSet = (colors['hangar'] if isHangar else colors['self'],
                 enemy,
                 friend,
                 colors['flag'])
    BigWorld.wgSetEdgeDetectColors(colorsSet)


@registerEvent(PlayerAvatar, 'onEnterWorld')
def onEnterWorld(self, prereqs):
    g_instance.updateColors()


@registerEvent(PlayerAvatar, 'targetFocus')
def PlayerAvatar_targetFocus(self, entity):
    global isSquad, isTeamKill
    if entity in self._PlayerAvatar__vehicles:
        prev_isSquad = isSquad
        getArenaDP = self.guiSessionProvider.getArenaDP()
        isSquad = getArenaDP.isSquadMan(vID=entity.id)
        prev_isTeamKill = isTeamKill
        isTeamKill = getArenaDP.isTeamKiller(vID=entity.id)
        if (prev_isSquad != isSquad) or (prev_isTeamKill != isTeamKill):
            g_instance.updateColors()

