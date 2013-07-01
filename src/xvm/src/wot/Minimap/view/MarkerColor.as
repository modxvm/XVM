import com.xvm.ColorsManager;
import com.xvm.Config;
import com.xvm.GraphicsUtil;

/**
 * @author sirmax
 */
class wot.Minimap.view.MarkerColor
{
    public static function setColor(wrapper:net.wargaming.ingame.MinimapEntry):Void
    {
        if (wrapper.m_type == null || wrapper.vehicleClass == null || wrapper.entryName == null)
            return;

        //if (wrapper.entryName != "ally" && wrapper.entryName != "enemy")
        //    com.xvm.Logger.add("type=" + wrapper.m_type + " entryName=" + wrapper.entryName + " vehicleClass=" + wrapper.vehicleClass);

        if (wrapper.entryName == "control")
            return;

        if (wrapper.m_type == "player" && wrapper.entryName == "postmortemCamera")
            return;

        var color = null;
        if (Config.s_config.battle.useStandardMarkers)
        {
            var schemeName = (wrapper.entryName != "base" && wrapper.entryName != "spawn") ? wrapper.colorSchemeName
                : (wrapper.vehicleClass == "red") ? "vm_enemy" : (wrapper.vehicleClass == "blue") ? "vm_ally" : null;

            if (!schemeName)
                return;

            color = wrapper.colorsManager.getRGB(schemeName);
        }
        else
        {
            var entryName = (wrapper.entryName != "base" && wrapper.entryName != "spawn") ? wrapper.entryName
                : (wrapper.vehicleClass == "red") ? "enemy" : (wrapper.vehicleClass == "blue") ? "ally" : null;
            if (entryName != null)
                color = ColorsManager.getSystemColor(entryName, wrapper.isDead);
        }

        if (color != null)
        {
            GraphicsUtil.colorize(wrapper.player || wrapper.teamPoint, color,
                wrapper.player ? Config.s_config.consts.VM_COEFF_MM_PLAYER : Config.s_config.consts.VM_COEFF_MM_BASE); // darker to improve appearance
        }
    }
}
