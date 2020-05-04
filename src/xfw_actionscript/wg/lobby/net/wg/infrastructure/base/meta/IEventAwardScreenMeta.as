package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventAwardScreenMeta extends IEventDispatcher
    {

        function onCloseWindowS() : void;

        function onPlaySoundS(param1:String) : void;

        function onButtonS() : void;

        function as_setData(param1:Object) : void;

        function as_setCloseBtnEnabled(param1:Boolean) : void;
    }
}
