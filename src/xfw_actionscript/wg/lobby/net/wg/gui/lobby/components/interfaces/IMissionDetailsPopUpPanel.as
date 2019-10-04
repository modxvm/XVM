package net.wg.gui.lobby.components.interfaces
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.infrastructure.interfaces.IDAAPIDataClass;

    public interface IMissionDetailsPopUpPanel extends IUIComponentEx
    {

        function setData(param1:IDAAPIDataClass) : void;
    }
}
