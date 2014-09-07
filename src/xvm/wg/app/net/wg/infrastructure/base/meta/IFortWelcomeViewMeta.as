package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortWelcomeViewMeta extends IEventDispatcher
    {
        
        function onCreateBtnClickS() : void;
        
        function onNavigateS(param1:String) : void;
        
        function as_setWarningText(param1:String, param2:String, param3:String) : void;
        
        function as_setHyperLinks(param1:String, param2:String, param3:String) : void;
        
        function as_setCommonData(param1:Object) : void;
        
        function as_setRequirementText(param1:String) : void;
    }
}
