import com.xvm.DefaultConfig;
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
        if (wrapper.m_type == null || wrapper.vehicleClass == null || wrapper.entryName == null || wrapper.entryName == "")
            return;

        if (wrapper.entryName == "control")
            return;

        if (wrapper.m_type == "player" && wrapper.entryName == "postmortemCamera")
            return;

        var color = null;
        if (Config.s_config.battle.useStandardMarkers)
        {
            if (wrapper.entryName == "base")
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
            if (wrapper.entryName == "base")
            {
                var aa = Config.s_config.colors.system["ally_alive"];
                var aad = DefaultConfig.config.colors.system["ally_alive"];
                if (wrapper.vehicleClass == "blue" && aa == aad)
                    return;
                var ea = Config.s_config.colors.system["enemy_alive"];
                var ead = DefaultConfig.config.colors.system["enemy_alive"];
                if (wrapper.vehicleClass == "red" && ea == ead)
                    return;
            }
            var entryName = (wrapper.entryName != "base" && wrapper.entryName != "spawn") ? wrapper.entryName
                : (wrapper.vehicleClass == "red") ? "enemy" : (wrapper.vehicleClass == "blue") ? "ally" : null;
            if (entryName != null)
                color = ColorsManager.getSystemColor(entryName, wrapper.isDead);
            if (wrapper.entryName == "base")
                wrapper.setEntryName("control");
        }

        if (color != null)
        {
            GraphicsUtil.colorize(wrapper.teamPoint || wrapper.player/*.litIcon*/, color,
                wrapper.player ? Config.s_config.consts.VM_COEFF_MM_PLAYER : Config.s_config.consts.VM_COEFF_MM_BASE);
        }
    }
}
