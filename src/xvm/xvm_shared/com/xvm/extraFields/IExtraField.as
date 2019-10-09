/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.extraFields
{
    import com.greensock.TimelineLite;
    import com.xvm.battle.events.PlayerStateEvent;
    import com.xvm.types.cfg.CExtraField;
    import com.xvm.vo.IVOMacrosOptions;
    import flash.geom.Rectangle;
    import net.wg.infrastructure.interfaces.IDisplayObject;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public interface IExtraField extends IDisplayObject, IDisposable
    {
        function get xValue():Number;
        function get yValue():Number;
        function get widthValue():Number;
        function get heightValue():Number;
        function get cfg():CExtraField;
        function set mouseEnabled(value:Boolean):void;
        function set buttonMode(value:Boolean):void;
        function get tweens():TimelineLite;
        function set tweens(value:TimelineLite):void;
        function get tweensIn():TimelineLite;
        function set tweensIn(value:TimelineLite):void;
        function get tweensOut():TimelineLite;
        function set tweensOut(value:TimelineLite):void;
        function update(options:IVOMacrosOptions, bindToIconOffset:int = 0, offsetX:int = 0, offsetY:int = 0, bounds:Rectangle = null):void;
        function updateOnEvent(e:PlayerStateEvent):void;
        function onKeyEvent(key:Number, isDown:Boolean):void
    }
}
