package net.wg.infrastructure.interfaces 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface IDragDropListDelegate extends net.wg.infrastructure.interfaces.entity.IDroppable, net.wg.infrastructure.interfaces.entity.IDisposable
    {
        function setPairedDropLists(arg1:__AS3__.vec.Vector.<flash.display.InteractiveObject>):void;
    }
}
