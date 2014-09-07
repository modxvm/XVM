package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortIntelFilterMeta extends IEventDispatcher
    {
        
        function onTryToSearchByClanAbbrS(param1:String, param2:int) : String;
        
        function onClearClanTagSearchS() : void;
        
        function as_setData(param1:Object) : void;
        
        function as_setMaxClanAbbreviateLength(param1:uint) : void;
        
        function as_setSearchResult(param1:String) : void;
        
        function as_setFilterStatus(param1:String) : void;
        
        function as_setFilterButtonStatus(param1:String, param2:Boolean) : void;
        
        function as_setupCooldown(param1:Boolean) : void;
    }
}
