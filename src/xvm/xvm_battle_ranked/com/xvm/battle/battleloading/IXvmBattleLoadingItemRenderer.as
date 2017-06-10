/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
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

        function get rankIcon():BattleAtlasSprite;
        function get badgeIcon():BattleAtlasSprite;
        function get nameField():TextField;
        function get vehicleField():TextField;
        function get vehicleIcon():BattleAtlasSprite;
        function get vehicleLevelIcon():BattleAtlasSprite;
        function get vehicleTypeIcon():BattleAtlasSprite;
        function get playerActionMarker():PlayerActionMarker;
        function get selfBg():BattleAtlasSprite;
        function get icoIGR():BattleAtlasSprite;

        function setData(data:Object):void;

        function invalidate2(param1:uint=4294967295):void;

        function addChild(child:DisplayObject):DisplayObject;
        function addChildAt(child:DisplayObject, index:int):DisplayObject;
        function getChildIndex(child:DisplayObject):int;
    }
}
