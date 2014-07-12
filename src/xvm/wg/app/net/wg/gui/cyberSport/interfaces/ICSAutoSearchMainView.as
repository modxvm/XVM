package net.wg.gui.cyberSport.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.entity.IDisplayable;
    import net.wg.infrastructure.interfaces.entity.IFocusContainer;
    import net.wg.gui.cyberSport.vo.AutoSearchVO;
    import scaleform.clik.events.InputEvent;
    
    public interface ICSAutoSearchMainView extends IDisposable, IDisplayable, IFocusContainer
    {
        
        function stopTimer() : void;
        
        function enableButton(param1:Boolean) : void;
        
        function set changeState(param1:AutoSearchVO) : void;
        
        function handleInput(param1:InputEvent) : void;
    }
}
