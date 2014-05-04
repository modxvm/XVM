import com.xvm.*;
import wot.Minimap.MinimapEntry

/**
 * @author sirmax
 */
class wot.Minimap.view.MarkerColor
{
    public static function setColor(wrapper:net.wargaming.ingame.MinimapEntry):Void
    {
        if (wrapper.m_type == null || wrapper.vehicleClass == null || wrapper.entryName == null || wrapper.entryName == "")
            return;

        if (wrapper.entryName == MinimapEntry.STATIC_ICON_CONTROL)
            return;

        if (wrapper.m_type == "player" && wrapper.entryName == "postmortemCamera")
            return;

        if (Config.config == null)
        {
            // wait for config
            setTimeout(function() { MarkerColor.setColor(wrapper); }, 1);
            return;
        }

        var color = null;
        if (Config.config.markers.useStandardMarkers)
        {
            if (wrapper.entryName == MinimapEntry.STATIC_ICON_BASE)
                return;
            var schemeName = wrapper.entryName != "spawn" ? wrapper.colorSchemeName
                : (wrapper.vehicleClass == "red") ? "vm_enemy" : (wrapper.vehicleClass == "blue") ? "vm_ally" : null;
            if (!schemeName)
                return;
            color = wrapper.colorsManager.getRGB(schemeName);
        }
        else
        {
            // use standard team bases if color is not changed
            if (wrapper.entryName == MinimapEntry.STATIC_ICON_BASE)
            {
                var aa = Config.config.colors.system["ally_alive"];
                var aad = Defines.C_ALLY_ALIVE;
                if (wrapper.vehicleClass == "blue" && aa == aad)
                    return;
                var ea = Config.config.colors.system["enemy_alive"];
                var ead = Defines.C_ENEMY_ALIVE;
                if (wrapper.vehicleClass == "red" && ea == ead)
                    return;
            }
            var entryName = (wrapper.entryName != MinimapEntry.STATIC_ICON_BASE && wrapper.entryName != "spawn") ? wrapper.entryName
                : (wrapper.vehicleClass == "red") ? "enemy" : (wrapper.vehicleClass == "blue") ? "ally" : null;
            if (entryName == "teamKiller" && wrapper.m_type == "enemy")
                entryName = "enemy";
            if (entryName != null)
                color = ColorsManager.getSystemColor(entryName, wrapper.isDead);
            if (wrapper.entryName == MinimapEntry.STATIC_ICON_BASE)
                wrapper.setEntryName(MinimapEntry.STATIC_ICON_CONTROL);
        }

        if (color != null)
        {
            GraphicsUtil.colorize(wrapper.teamPoint || wrapper.player/*.litIcon*/, color,
                wrapper.player ? Config.config.consts.VM_COEFF_MM_PLAYER : Config.config.consts.VM_COEFF_MM_BASE);
        }
    }
}
