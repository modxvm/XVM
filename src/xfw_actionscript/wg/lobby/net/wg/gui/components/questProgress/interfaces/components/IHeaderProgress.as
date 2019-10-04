package net.wg.gui.components.questProgress.interfaces.components
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;

    public interface IHeaderProgress extends IUIComponentEx
    {

        function setData(param1:IHeaderProgressData, param2:int) : void;
    }
}
