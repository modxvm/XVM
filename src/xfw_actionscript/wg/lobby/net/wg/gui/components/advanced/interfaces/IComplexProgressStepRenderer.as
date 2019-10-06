package net.wg.gui.components.advanced.interfaces
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.gui.lobby.referralSystem.data.ProgressStepVO;

    public interface IComplexProgressStepRenderer extends IUIComponentEx
    {

        function setData(param1:ProgressStepVO) : void;

        function get showLine() : Boolean;

        function set showLine(param1:Boolean) : void;
    }
}
