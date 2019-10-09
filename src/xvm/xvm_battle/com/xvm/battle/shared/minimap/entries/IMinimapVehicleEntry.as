/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.shared.minimap.entries
{
    import com.xvm.battle.events.*;
    import com.xvm.extraFields.*;

    public interface IMinimapVehicleEntry
    {
        function get extraFields():ExtraFieldsGroup;
        function set extraFields(value:ExtraFieldsGroup):void;
        function get extraFieldsAlt():ExtraFieldsGroup;
        function set extraFieldsAlt(value:ExtraFieldsGroup):void;
        function playerStateChanged(e:PlayerStateEvent):void;
        function update():void;
        function onEnterFrame():void;

        function get x():Number;
        function set x(value:Number):void;
        function get y():Number;
        function set y(value:Number):void;
        function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
        function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void;
    }
}
