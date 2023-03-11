/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.battleloading
{
    import flash.text.TextField;
    import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import net.wg.gui.components.controls.BadgeComponent;
    import net.wg.gui.components.icons.PlayerActionMarker;

    public interface IXvmBattleLoadingItemRendererBase
    {
        function get DEFAULTS():XvmItemRendererDefaults;

        function get badgeIcon():BadgeComponent;
        function get nameField():TextField;
        function get vehicleField():TextField;
        function get vehicleIcon():BattleAtlasSprite;
        function get vehicleLevelIcon():BattleAtlasSprite;
        function get vehicleTypeIcon():BattleAtlasSprite;
        function get playerActionMarker():PlayerActionMarker;
        function get selfBg():BattleAtlasSprite;
        function get icoIGR():BattleAtlasSprite;

        function setData(data:DAAPIVehicleInfoVO):void;
    }
}
