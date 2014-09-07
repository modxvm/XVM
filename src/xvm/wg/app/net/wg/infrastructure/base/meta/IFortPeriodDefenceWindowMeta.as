package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    import net.wg.gui.lobby.fortifications.data.PeriodDefenceVO;
    
    public interface IFortPeriodDefenceWindowMeta extends IEventDispatcher
    {
        
        function onApplyS(param1:PeriodDefenceVO) : void;
        
        function onCancelS() : void;
        
        function as_setData(param1:Object) : void;
        
        function as_setTexts(param1:Object) : void;
    }
}
