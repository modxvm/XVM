package net.wg.gui.lobby.techtree.interfaces
{
    import net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings;

    public interface INationTreeDataProvider extends INodesDataProvider
    {

        function getScrollIndex() : Number;

        function getDisplaySettings() : NationDisplaySettings;
    }
}
