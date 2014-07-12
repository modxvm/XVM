package net.wg.gui.rally.controls
{
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import flash.display.InteractiveObject;
    
    public interface ISlotRendererHelper
    {
        
        function initControlsState(param1:RallySimpleSlotRenderer) : void;
        
        function updateComponents(param1:RallySimpleSlotRenderer, param2:IRallySlotVO) : void;
        
        function onControlRollOver(param1:InteractiveObject, param2:RallySimpleSlotRenderer, param3:IRallySlotVO, param4:* = null) : void;
    }
}
