package net.wg.gui.lobby.techtree.interfaces
{
    public interface IResearchContainer extends INodesContainer
    {
        
        function getRootState() : Number;
        
        function hasUnlockedParent(param1:Number, param2:Number) : Boolean;
        
        function canInstallItems() : Boolean;
        
        function isRootUnlocked() : Boolean;
        
        function getTopLevel() : Vector.<IRenderer>;
        
        function getChildren(param1:IRenderer) : Vector.<IRenderer>;
        
        function getParents(param1:IRenderer) : Vector.<IRenderer>;
    }
}
