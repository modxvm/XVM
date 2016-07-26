/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.extraFields
{
    import com.xvm.vo.*;
    import com.xvm.battle.events.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
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
        function update(options:IVOMacrosOptions, bindToIconOffset:Number = 0, offsetX:Number = 0, offsetY:Number = 0, bounds:Rectangle = null):void;
        function updateOnEvent(e:PlayerStateEvent):void;
        function onKeyEvent(key:Number, isDown:Boolean):void
    }
}
