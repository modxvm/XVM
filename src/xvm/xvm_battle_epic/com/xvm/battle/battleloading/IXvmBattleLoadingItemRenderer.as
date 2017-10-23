/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.battleloading
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.battle.components.*;
    import net.wg.gui.components.icons.*;

    public interface IXvmBattleLoadingItemRenderer
    {
        function get DEFAULTS():XvmItemRendererDefaults;

        function get f_rankIcon():BattleAtlasSprite;
        function get f_badgeIcon():BattleAtlasSprite;
        function get f_nameField():TextField;
        function get f_vehicleField():TextField;
        function get f_vehicleIcon():BattleAtlasSprite;
        function get f_vehicleLevelIcon():BattleAtlasSprite;
        function get f_vehicleTypeIcon():BattleAtlasSprite;
        function get f_playerActionMarker():PlayerActionMarker;
        function get f_selfBg():BattleAtlasSprite;
        function get f_icoIGR():BattleAtlasSprite;

        function setData(data:Object):void;

        function invalidate2(param1:uint=4294967295):void;

        function addChild(child:DisplayObject):DisplayObject;
        function addChildAt(child:DisplayObject, index:int):DisplayObject;
        function getChildIndex(child:DisplayObject):int;
    }
}
