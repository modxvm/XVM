package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IEventHeaderMeta extends IEventDispatcher
    {

        function menuItemClickS(param1:String) : void;

        function as_setVisible(param1:Boolean) : void;

        function as_setCoins(param1:int) : void;

        function as_setDifficulty(param1:int) : void;

        function as_setScreen(param1:String) : void;

        function as_setHangarMenuData(param1:Array) : void;

        function as_setButtonCounter(param1:String, param2:String) : void;

        function as_removeButtonCounter(param1:String) : void;
    }
}
