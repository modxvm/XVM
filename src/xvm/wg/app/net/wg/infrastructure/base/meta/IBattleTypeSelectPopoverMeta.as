package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IBattleTypeSelectPopoverMeta extends IEventDispatcher
    {
        
        function selectFightS(param1:String) : void;
        
        function demoClickS() : void;
        
        function getTooltipDataS(param1:String) : String;
        
        function as_update(param1:Array, param2:Boolean, param3:Boolean) : void;
        
        function as_setDemonstrationEnabled(param1:Boolean) : void;
    }
}
