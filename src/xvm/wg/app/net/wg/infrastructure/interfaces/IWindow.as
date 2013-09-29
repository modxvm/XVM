package net.wg.infrastructure.interfaces 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.interfaces.*;
    import scaleform.clik.utils.*;
    
    public interface IWindow extends net.wg.infrastructure.interfaces.entity.IDraggable, flash.events.IEventDispatcher, net.wg.infrastructure.interfaces.entity.IDisposable, scaleform.clik.interfaces.IUIComponent
    {
        function getTitleBtnEx():net.wg.gui.components.controls.TextFieldShort;

        function getTitleBtn():scaleform.clik.controls.Button;

        function getCloseBtn():scaleform.clik.controls.Button;

        function setMaxWidth(arg1:Number):void;

        function setMaxHeight(arg1:Number):void;

        function getMinWidth():Number;

        function setMinWidth(arg1:Number):void;

        function getMinHeight():Number;

        function setMinHeight(arg1:Number):void;

        function setTitleIcon(arg1:String):void;

        function getConstraints():scaleform.clik.utils.Constraints;

        function updateSize(arg1:Number, arg2:Number, arg3:Boolean=false):void;

        function getBackground():flash.display.MovieClip;

        function getIconMovie():flash.display.MovieClip;

        function setSize(arg1:Number, arg2:Number):void;

        function get sourceView():net.wg.infrastructure.interfaces.IAbstractWindowView;

        function set sourceView(arg1:net.wg.infrastructure.interfaces.IAbstractWindowView):void;

        function get useBottomBtns():Boolean;

        function set useBottomBtns(arg1:Boolean):void;

        function set title(arg1:String):void;

        function get contentPadding():Object;

        function set contentPadding(arg1:Object):void;

        function get formBgPadding():scaleform.clik.utils.Padding;

        function set formBgPadding(arg1:scaleform.clik.utils.Padding):void;
    }
}
