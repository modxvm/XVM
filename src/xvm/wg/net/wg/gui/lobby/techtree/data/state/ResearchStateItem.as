package net.wg.gui.lobby.techtree.data.state 
{
    public class ResearchStateItem extends net.wg.gui.lobby.techtree.data.state.NodeStateItem
    {
        public function ResearchStateItem(arg1:uint, arg2:net.wg.gui.lobby.techtree.data.state.StateProperties)
        {
            super(arg1, arg2);
            return;
        }

        public function resolveProps(arg1:Number, arg2:Number, arg3:Boolean=false):net.wg.gui.lobby.techtree.data.state.StateProperties
        {
            return getProps();
        }
    }
}
