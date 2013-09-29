package net.wg.gui.lobby.techtree.interfaces 
{
    import net.wg.utils.*;
    
    public interface IValueObject
    {
        function fromArray(arg1:Array, arg2:net.wg.utils.ILocale):void;

        function fromObject(arg1:Object, arg2:net.wg.utils.ILocale):void;
    }
}
