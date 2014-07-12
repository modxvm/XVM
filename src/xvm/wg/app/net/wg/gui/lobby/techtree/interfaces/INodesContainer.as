package net.wg.gui.lobby.techtree.interfaces
{
   import scaleform.clik.interfaces.IUIComponent;
   
   public interface INodesContainer extends IUIComponent
   {
      
      function getNodeByID(param1:Number) : IRenderer;
      
      function getRootNode() : IRenderer;
      
      function isParentUnlocked(param1:Number, param2:Number) : Boolean;
      
      function getNation() : String;
   }
}
