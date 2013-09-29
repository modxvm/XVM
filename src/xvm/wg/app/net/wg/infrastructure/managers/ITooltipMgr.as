package net.wg.infrastructure.managers 
{
    import net.wg.data.managers.*;
    
    public interface ITooltipMgr
    {
        function hide():void;

        function showSpecial(arg1:String, arg2:net.wg.data.managers.ITooltipProps, ... rest):void;

        function showComplex(arg1:String, arg2:net.wg.data.managers.ITooltipProps=null):void;

        function showComplexWithParams(arg1:String, arg2:net.wg.data.managers.IToolTipParams, arg3:net.wg.data.managers.ITooltipProps=null):void;

        function show(arg1:String, arg2:net.wg.data.managers.ITooltipProps=null):void;

        function showLocal(arg1:String, arg2:Object, arg3:net.wg.data.managers.ITooltipProps=null):void;
    }
}
