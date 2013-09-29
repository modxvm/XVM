package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IPersonalCaseMeta extends flash.events.IEventDispatcher
    {
        function dismissTankmanS(arg1:int):void;

        function unloadTankmanS(arg1:int, arg2:int):void;

        function getCommonDataS():void;

        function getDossierDataS():void;

        function getRetrainingDataS():void;

        function retrainingTankmanS(arg1:int, arg2:int, arg3:int):void;

        function getSkillsDataS():void;

        function getDocumentsDataS():void;

        function addTankmanSkillS(arg1:int, arg2:String):void;

        function dropSkillsS():void;

        function changeTankmanPassportS(arg1:int, arg2:int, arg3:int, arg4:int):void;

        function openExchangeFreeToTankmanXpWindowS():void;

        function as_setCommonData(arg1:Object):void;

        function as_setDossierData(arg1:Object):void;

        function as_setRetrainingData(arg1:Object):void;

        function as_setSkillsData(arg1:Array):void;

        function as_setDocumentsData(arg1:Object):void;
    }
}
