package net.wg.gui.lobby.techtree.interfaces
{
    import net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings;
    
    public interface INationTreeDataProvider extends INodesDataProvider
    {
        
        function get scrollIndex() : Number;
        
        function get displaySettings() : NationDisplaySettings;
    }
}
