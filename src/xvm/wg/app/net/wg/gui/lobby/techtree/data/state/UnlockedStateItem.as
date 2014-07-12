package net.wg.gui.lobby.techtree.data.state
{
    import net.wg.gui.lobby.techtree.constants.NodeState;
    
    public class UnlockedStateItem extends ResearchStateItem
    {
        
        public function UnlockedStateItem(param1:StateProperties, param2:StateProperties, param3:StateProperties, param4:StateProperties) {
            super(NodeState.UNLOCKED,param1);
            this.autoUnlocked = param2;
            this.rootNotInventory = param3;
            this.rootInInventory = param4;
        }
        
        private var autoUnlocked:StateProperties;
        
        private var rootNotInventory:StateProperties;
        
        private var rootInInventory:StateProperties;
        
        override public function resolveProps(param1:Number, param2:Number, param3:Boolean = false) : StateProperties {
            var _loc4_:StateProperties = super.resolveProps(param1,param2,param3);
            if((param2 & NodeState.UNLOCKED) > 0)
            {
                _loc4_ = (param2 & NodeState.IN_INVENTORY) > 0?this.rootInInventory:this.rootNotInventory;
            }
            else if((param1 & NodeState.AUTO_UNLOCKED) > 0)
            {
                _loc4_ = this.autoUnlocked;
            }
            
            return _loc4_;
        }
    }
}
