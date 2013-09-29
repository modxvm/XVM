package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IBattleLoadingMeta extends flash.events.IEventDispatcher
    {
        function getDataS():void;

        function as_setMapBG(arg1:String):void;

        function as_setProgress(arg1:Number):void;

        function as_setMapName(arg1:String):void;

        function as_setBattleTypeName(arg1:String):void;

        function as_setBattleTypeFrameNum(arg1:Number):void;

        function as_setBattleTypeFrameName(arg1:String):void;

        function as_setWinText(arg1:String):void;

        function as_setTeams(arg1:String, arg2:String):void;

        function as_setTip(arg1:String):void;

        function as_setTeamValues(arg1:Object):void;
    }
}
