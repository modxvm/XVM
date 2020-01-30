package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IBobAnnouncementWidgetMeta extends IEventDispatcher
    {

        function onClickS() : void;

        function playSoundS(param1:String) : void;

        function as_setEnabled(param1:Boolean) : void;

        function as_setEventTitle(param1:String) : void;

        function as_setCurrentRealm(param1:String) : void;

        function as_showAnnouncement(param1:String, param2:String, param3:Boolean, param4:Boolean) : void;
    }
}
