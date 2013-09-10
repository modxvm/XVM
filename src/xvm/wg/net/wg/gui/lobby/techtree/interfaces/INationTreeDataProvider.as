package net.wg.gui.lobby.techtree.interfaces 
{
    import net.wg.gui.lobby.techtree.data.vo.*;
    
    public interface INationTreeDataProvider extends net.wg.gui.lobby.techtree.interfaces.INodesDataProvider
    {
        function get scrollIndex():Number;

        function get displaySettings():net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings;
    }
}
