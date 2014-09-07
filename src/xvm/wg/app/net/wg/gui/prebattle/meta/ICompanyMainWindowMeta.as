package net.wg.gui.prebattle.meta
{
    import flash.events.IEventDispatcher;
    
    public interface ICompanyMainWindowMeta extends IEventDispatcher
    {
        
        function getCompanyNameS() : String;
        
        function showFAQWindowS() : void;
        
        function as_setWindowTitle(param1:String, param2:String) : void;
    }
}
