package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IProfileSummaryMeta extends flash.events.IEventDispatcher
    {
        function getPersonalScoreWarningTextS(arg1:Object):String;

        function getGlobalRatingS(arg1:String):Number;
    }
}
