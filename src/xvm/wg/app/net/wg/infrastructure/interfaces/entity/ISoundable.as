package net.wg.infrastructure.interfaces.entity 
{
    import flash.events.*;
    
    public interface ISoundable extends flash.events.IEventDispatcher
    {
        function getSoundType():String;

        function getSoundId():String;

        function getStateOverSnd():String;

        function getStateOutSnd():String;

        function getStatePressSnd():String;
    }
}
