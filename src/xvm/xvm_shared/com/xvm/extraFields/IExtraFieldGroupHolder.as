/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.extraFields
{
    import flash.display.*;

    public interface IExtraFieldGroupHolder
    {
        function get isLeftPanel():Boolean;
        function get substrateHolder():MovieClip;
        function get bottomHolder():MovieClip;
        function get normalHolder():MovieClip;
        function get topHolder():MovieClip;
        function getSchemeNameForPlayer():String;
        function getSchemeNameForVehicle():String;
    }
}
