package net.wg.gui.bootcamp.messageWindow.interfaces
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;
    import net.wg.gui.bootcamp.messageWindow.data.MessageContentVO;

    public interface IMessageView extends IUIComponentEx
    {

        function setMessageData(param1:MessageContentVO) : void;
    }
}
