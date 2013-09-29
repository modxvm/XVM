package net.wg.infrastructure.interfaces 
{
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface IMinimapEntry extends net.wg.infrastructure.interfaces.entity.IUpdatable
    {
        function isTeamPoint():Boolean;

        function init(arg1:String, arg2:String, arg3:String, arg4:String):void;
    }
}
