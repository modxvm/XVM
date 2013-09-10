package net.wg.infrastructure.managers 
{
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public interface ISoundManager extends net.wg.infrastructure.base.meta.ISoundManagerMeta
    {
        function playControlsSnd(arg1:String, arg2:String, arg3:String):void;

        function addSoundsHdlrs(arg1:net.wg.infrastructure.interfaces.entity.ISoundable):void;

        function removeSoundHdlrs(arg1:net.wg.infrastructure.interfaces.entity.ISoundable):void;
    }
}
