package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface ICustomizationBuyWindowMeta extends IEventDispatcher
    {

        function buyS() : void;

        function closeS() : void;

        function selectItemS(param1:uint, param2:Boolean) : void;

        function deselectItemS(param1:uint, param2:Boolean) : void;

        function changePriceItemS(param1:uint, param2:uint) : void;

        function applyToTankChangedS(param1:Boolean) : void;

        function updateAutoProlongationS() : void;

        function onAutoProlongationCheckboxAddedS() : void;

        function as_setInitData(param1:Object) : void;

        function as_setTitles(param1:Object) : void;

        function as_setTotalData(param1:Object) : void;

        function as_setData(param1:Object) : void;

        function as_setBuyBtnState(param1:Boolean, param2:String, param3:String, param4:Boolean) : void;
    }
}
