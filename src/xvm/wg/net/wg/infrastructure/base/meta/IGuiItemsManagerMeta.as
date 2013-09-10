package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IGuiItemsManagerMeta extends flash.events.IEventDispatcher
    {
        function _getItemAttributeS(arg1:int, arg2:Object, arg3:String):Object;

        function _callItemMethodS(arg1:int, arg2:Object, arg3:String, arg4:Array):Object;
    }
}
