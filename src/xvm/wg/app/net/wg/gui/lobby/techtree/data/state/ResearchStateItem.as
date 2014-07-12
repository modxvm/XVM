package net.wg.gui.lobby.techtree.data.state
{
    public class ResearchStateItem extends NodeStateItem
    {
        
        public function ResearchStateItem(param1:uint, param2:StateProperties) {
            super(param1,param2);
        }
        
        public function resolveProps(param1:Number, param2:Number, param3:Boolean = false) : StateProperties {
            return getProps();
        }
    }
}
