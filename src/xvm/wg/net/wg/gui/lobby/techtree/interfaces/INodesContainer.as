package net.wg.gui.lobby.techtree.interfaces 
{
    import scaleform.clik.interfaces.*;
    
    public interface INodesContainer extends scaleform.clik.interfaces.IUIComponent
    {
        function getNodeByID(arg1:Number):net.wg.gui.lobby.techtree.interfaces.IRenderer;

        function getRootNode():net.wg.gui.lobby.techtree.interfaces.IRenderer;

        function isParentUnlocked(arg1:Number, arg2:Number):Boolean;

        function getNation():String;
    }
}
