package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IBarracksMeta extends IEventDispatcher
    {
        
        function invalidateTanksListS() : void;
        
        function setFilterS(param1:Number, param2:String, param3:String, param4:String, param5:String) : void;
        
        function onShowRecruitWindowClickS(param1:Object, param2:Boolean) : void;
        
        function unloadTankmanS(param1:String) : void;
        
        function dismissTankmanS(param1:String) : void;
        
        function buyBerthsS() : void;
        
        function closeBarracksS() : void;
        
        function setTankmenFilterS() : void;
        
        function openPersonalCaseS(param1:String, param2:uint) : void;
        
        function as_setTankmen(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object, param6:Number, param7:Array) : void;
        
        function as_updateTanksList(param1:Array) : void;
        
        function as_setTankmenFilter(param1:Number, param2:String, param3:String, param4:String, param5:String) : void;
    }
}
