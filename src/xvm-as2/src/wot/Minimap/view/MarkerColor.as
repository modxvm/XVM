/**
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */

import com.xvm.*;
import wot.Minimap.*;

class wot.Minimap.view.MarkerColor
{
    public static function setColor(wrapper:net.wargaming.ingame.MinimapEntry):Void
    {
        var wr_entryName = wrapper.orig_entryName || wrapper.entryName;
        if (wrapper.m_type == null || wrapper.vehicleClass == null || wr_entryName == null || wr_entryName == "")
            return;

        if (wr_entryName == MinimapConstants.STATIC_ICON_CONTROL)
            return;

        if ((wrapper.m_type == "player" || wrapper.m_type == "normalWithSector") && wr_entryName == "postmortemCamera")
            return;

        var color = null;
        if (Config.config.markers.useStandardMarkers)
        {
            if (wr_entryName == MinimapConstants.STATIC_ICON_BASE)
                return;
            var schemeName = wr_entryName != MinimapConstants.STATIC_ICON_SPAWN ? wrapper.colorSchemeName
                : (wrapper.vehicleClass == "red") ? "vm_enemy" : (wrapper.vehicleClass == "blue") ? "vm_ally" : null;
            if (!schemeName)
                return;
            color = wrapper.colorsManager.getRGB(schemeName);
        }
        else
        {
            // use standard team bases if color is not changed
            var isBase:Boolean = wr_entryName == MinimapConstants.STATIC_ICON_BASE;
            var isSpawn:Boolean = wr_entryName == MinimapConstants.STATIC_ICON_SPAWN;
            if (isBase)
            {
                var aa = Config.config.colors.system["ally_base"];
                var aad = Defines.C_ALLY_ALIVE;
                if (wrapper.vehicleClass == "blue" && aa == aad)
                    return;
                var ea = Config.config.colors.system["enemy_base"];
                var ead = Defines.C_ENEMY_ALIVE;
                if (wrapper.vehicleClass == "red" && ea == ead)
                    return;
            }
            var entryName = (!isBase && !isSpawn) ? wr_entryName
                : (wrapper.vehicleClass == "red") ? "enemy" : (wrapper.vehicleClass == "blue") ? "ally" : null;
            if (entryName == "teamKiller" && wrapper.m_type == "enemy")
                entryName = "enemy";
            if (entryName != null)
                color = ColorsManager.getSystemColor(entryName, wrapper.isDead, false, isBase);
            if (wrapper.entryName == MinimapConstants.STATIC_ICON_BASE)
            {
                if (wrapper.orig_entryName == null)
                    wrapper.orig_entryName = wrapper.entryName;
                wrapper.setEntryName(MinimapConstants.STATIC_ICON_CONTROL);
            }
        }

        if (color != null)
        {
            GraphicsUtil.colorize(wrapper.teamPoint || wrapper.player/*.litIcon*/, color,
                wrapper.player ? Config.config.consts.VM_COEFF_MM_PLAYER : Config.config.consts.VM_COEFF_MM_BASE);
        }
    }
}
