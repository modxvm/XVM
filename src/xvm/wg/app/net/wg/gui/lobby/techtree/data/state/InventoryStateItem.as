package net.wg.gui.lobby.techtree.data.state
{
   import net.wg.gui.lobby.techtree.constants.NodeState;
   
   public class InventoryStateItem extends ResearchStateItem
   {
      
      public function InventoryStateItem(param1:StateProperties, param2:StateProperties, param3:StateProperties, param4:StateProperties) {
         super(NodeState.UNLOCKED | NodeState.IN_INVENTORY,param1);
         this.autoUnlocked = param2;
         this.parentLocked = param3;
         this.parentUnlocked = param4;
      }
      
      private var autoUnlocked:StateProperties;
      
      private var parentLocked:StateProperties;
      
      private var parentUnlocked:StateProperties;
      
      override public function resolveProps(param1:Number, param2:Number, param3:Boolean = false) : StateProperties {
         var _loc4_:StateProperties = super.resolveProps(param1,param2,param3);
         if((param2 & NodeState.UNLOCKED) > 0)
         {
            _loc4_ = param3?this.parentUnlocked:this.parentLocked;
         }
         else if((param1 & NodeState.AUTO_UNLOCKED) > 0)
         {
            _loc4_ = this.autoUnlocked;
         }
         
         return _loc4_;
      }
   }
}
