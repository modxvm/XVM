package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IPersonalCaseMeta extends IEventDispatcher
    {
        
        function dismissTankmanS(param1:int) : void;
        
        function unloadTankmanS(param1:int, param2:int) : void;
        
        function getCommonDataS() : void;
        
        function getDossierDataS() : void;
        
        function getRetrainingDataS() : void;
        
        function retrainingTankmanS(param1:int, param2:int, param3:int) : void;
        
        function getSkillsDataS() : void;
        
        function getDocumentsDataS() : void;
        
        function addTankmanSkillS(param1:int, param2:String) : void;
        
        function dropSkillsS() : void;
        
        function changeTankmanPassportS(param1:int, param2:int, param3:int, param4:int) : void;
        
        function openExchangeFreeToTankmanXpWindowS() : void;
        
        function as_setCommonData(param1:Object) : void;
        
        function as_setDossierData(param1:Object) : void;
        
        function as_setRetrainingData(param1:Object) : void;
        
        function as_setSkillsData(param1:Array) : void;
        
        function as_setDocumentsData(param1:Object) : void;
    }
}
