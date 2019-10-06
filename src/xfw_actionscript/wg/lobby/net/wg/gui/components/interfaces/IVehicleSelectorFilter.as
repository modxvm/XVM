package net.wg.gui.components.interfaces
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;

    public interface IVehicleSelectorFilter extends IUIComponentEx
    {

        function setData(param1:IVehicleSelectorFilterVO) : void;
    }
}
