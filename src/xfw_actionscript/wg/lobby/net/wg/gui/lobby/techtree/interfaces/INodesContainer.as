package net.wg.gui.lobby.techtree.interfaces
{
    import net.wg.infrastructure.interfaces.IUIComponentEx;

    public interface INodesContainer extends IUIComponentEx
    {

        function getNodeByID(param1:Number) : IRenderer;

        function getNation() : String;

        function get rootRenderer() : IRenderer;
    }
}
