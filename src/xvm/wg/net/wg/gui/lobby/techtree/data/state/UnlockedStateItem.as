package net.wg.gui.lobby.techtree.data.state 
{
    import net.wg.gui.lobby.techtree.constants.*;
    
    public class UnlockedStateItem extends net.wg.gui.lobby.techtree.data.state.ResearchStateItem
    {
        public function UnlockedStateItem(arg1:net.wg.gui.lobby.techtree.data.state.StateProperties, arg2:net.wg.gui.lobby.techtree.data.state.StateProperties, arg3:net.wg.gui.lobby.techtree.data.state.StateProperties, arg4:net.wg.gui.lobby.techtree.data.state.StateProperties)
        {
            super(net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED, arg1);
            this.autoUnlocked = arg2;
            this.rootNotInventory = arg3;
            this.rootInInventory = arg4;
            return;
        }

        public override function resolveProps(arg1:Number, arg2:Number, arg3:Boolean=false):net.wg.gui.lobby.techtree.data.state.StateProperties
        {
            var loc1:*=super.resolveProps(arg1, arg2, arg3);
            if ((arg2 & net.wg.gui.lobby.techtree.constants.NodeState.UNLOCKED) > 0) 
            {
                loc1 = (arg2 & net.wg.gui.lobby.techtree.constants.NodeState.IN_INVENTORY) > 0 ? this.rootInInventory : this.rootNotInventory;
            }
            else if ((arg1 & net.wg.gui.lobby.techtree.constants.NodeState.AUTO_UNLOCKED) > 0) 
            {
                loc1 = this.autoUnlocked;
            }
            return loc1;
        }

        internal var autoUnlocked:net.wg.gui.lobby.techtree.data.state.StateProperties;

        internal var rootNotInventory:net.wg.gui.lobby.techtree.data.state.StateProperties;

        internal var rootInInventory:net.wg.gui.lobby.techtree.data.state.StateProperties;
    }
}
