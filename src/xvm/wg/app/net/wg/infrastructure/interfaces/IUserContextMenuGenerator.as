package net.wg.infrastructure.interfaces 
{
    import __AS3__.vec.*;
    import net.wg.data.daapi.*;
    
    public interface IUserContextMenuGenerator
    {
        function generateData(arg1:net.wg.data.daapi.PlayerInfo, arg2:Number=NaN):__AS3__.vec.Vector.<net.wg.infrastructure.interfaces.IContextItem>;
    }
}
