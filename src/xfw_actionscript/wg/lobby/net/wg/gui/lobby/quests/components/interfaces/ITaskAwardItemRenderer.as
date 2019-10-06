package net.wg.gui.lobby.quests.components.interfaces
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.data.VO.AwardsItemVO;

    public interface ITaskAwardItemRenderer extends IUIComponentEx
    {

        function setData(param1:AwardsItemVO) : void;
    }
}
