package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IBattleHintPanelMeta extends IEventDispatcher
    {

        function onPlaySoundS(param1:String) : void;

        function as_setData(param1:String, param2:String, param3:String, param4:int, param5:int) : void;
    }
}
