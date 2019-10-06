package net.wg.gui.components.tooltips.inblocks.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.IEventDispatcher;
    import flash.display.DisplayObject;

    public interface ITooltipBlock extends IDisposable, IEventDispatcher
    {

        function setBlockData(param1:Object) : void;

        function getWidth() : Number;

        function getHeight() : Number;

        function getDisplayObject() : DisplayObject;

        function getBg() : DisplayObject;

        function getStretchBg() : Boolean;

        function setBlockWidth(param1:int) : void;

        function isBlockInvalid() : Boolean;

        function tryValidateBlock() : void;
    }
}
