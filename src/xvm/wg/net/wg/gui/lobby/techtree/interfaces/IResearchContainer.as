package net.wg.gui.lobby.techtree.interfaces 
{
    import __AS3__.vec.*;
    
    public interface IResearchContainer extends net.wg.gui.lobby.techtree.interfaces.INodesContainer
    {
        function getRootState():Number;

        function hasUnlockedParent(arg1:Number, arg2:Number):Boolean;

        function canInstallItems():Boolean;

        function isRootUnlocked():Boolean;

        function getTopLevel():__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>;

        function getChildren(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>;

        function getParents(arg1:net.wg.gui.lobby.techtree.interfaces.IRenderer):__AS3__.vec.Vector.<net.wg.gui.lobby.techtree.interfaces.IRenderer>;
    }
}
