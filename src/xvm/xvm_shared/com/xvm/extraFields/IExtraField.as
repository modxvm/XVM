/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.extraFields
{
    import com.xvm.battle.events.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import flash.geom.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;

    public interface IExtraField extends IDisplayObject, IDisposable
    {
        function get xValue():Number;
        function get yValue():Number;
        function get widthValue():Number;
        function get heightValue():Number;
        function get cfg():CExtraField;
        function set mouseEnabled(value:Boolean):void;
        function set buttonMode(value:Boolean):void;
        function update(options:IVOMacrosOptions, bindToIconOffset:int = 0, offsetX:int = 0, offsetY:int = 0, bounds:Rectangle = null):void;
        function updateOnEvent(e:PlayerStateEvent):void;
        function onKeyEvent(key:Number, isDown:Boolean):void
    }
}
