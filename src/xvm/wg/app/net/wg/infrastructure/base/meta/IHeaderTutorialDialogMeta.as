package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IHeaderTutorialDialogMeta extends IEventDispatcher
    {
        
        function onButtonClickS(param1:String, param2:Boolean) : void;
        
        function as_setSettings(param1:Object) : void;
    }
}
