/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.extraFields
{
    import com.xvm.vo.*;
    import flash.display.*;

    public interface IExtraFieldGroupHolder
    {
        function get isLeftPanel():Boolean;
        function get substrateHolder():Sprite;
        function get bottomHolder():Sprite;
        function get normalHolder():Sprite;
        function get topHolder():Sprite;
        function getSchemeNameForPlayer(options:IVOMacrosOptions):String;
        function getSchemeNameForVehicle(options:IVOMacrosOptions):String;
    }
}
