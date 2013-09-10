package net.wg.gui.lobby.techtree.data.state 
{
    public class NodeStateItem extends Object
    {
        public function NodeStateItem(arg1:uint, arg2:net.wg.gui.lobby.techtree.data.state.StateProperties)
        {
            super();
            this.state = arg1;
            this.props = arg2;
            return;
        }

        public function getState():uint
        {
            return this.state;
        }

        public function getProps():net.wg.gui.lobby.techtree.data.state.StateProperties
        {
            return this.props;
        }

        internal var state:uint;

        internal var props:net.wg.gui.lobby.techtree.data.state.StateProperties;
    }
}
