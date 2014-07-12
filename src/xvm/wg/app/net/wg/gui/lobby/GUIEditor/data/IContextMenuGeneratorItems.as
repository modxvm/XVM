package net.wg.gui.lobby.GUIEditor.data
{
    import net.wg.infrastructure.interfaces.IContextItem;
    
    public interface IContextMenuGeneratorItems
    {
        
        function generateItemsContextMenu(param1:String) : Vector.<IContextItem>;
    }
}
