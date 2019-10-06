package net.wg.gui.lobby.techtree.data
{
    import net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider;
    import net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings;
    import net.wg.gui.lobby.techtree.data.vo.NodeData;
    import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
    import net.wg.utils.ILocale;

    public class NationVODataProvider extends AbstractDataProvider implements INationTreeDataProvider
    {

        private static const PROPERTY_SCROLL_INDEX:String = "scrollIndex";

        private static const PROPERTY_DISPLAY_SETTINGS:String = "displaySettings";

        protected var scrollIndex:Number = 0;

        protected var displaySettings:NationDisplaySettings;

        public function NationVODataProvider()
        {
            this.displaySettings = new NationDisplaySettings();
            super();
        }

        override public function parse(param1:Object) : void
        {
            var _loc5_:NodeData = null;
            cleanUp();
            NodeData.setDisplayInfoClass(NTDisplayInfo);
            var _loc2_:Array = param1.nodes;
            var _loc3_:ILocale = App.utils.locale;
            if(param1.hasOwnProperty(PROPERTY_SCROLL_INDEX))
            {
                this.scrollIndex = param1.scrollIndex;
            }
            if(param1.hasOwnProperty(PROPERTY_DISPLAY_SETTINGS))
            {
                this.displaySettings.fromObject(param1.displaySettings,_loc3_);
            }
            var _loc4_:Number = _loc2_.length;
            var _loc6_:Number = 0;
            while(_loc6_ < _loc4_)
            {
                _loc5_ = new NodeData();
                _loc5_.fromObject(_loc2_[_loc6_],_loc3_);
                nodeIdxCache[_loc5_.id] = nodeData.length;
                nodeData.push(_loc5_);
                _loc6_++;
            }
        }

        override public function setItemField(param1:String, param2:Number, param3:Object) : Boolean
        {
            var _loc4_:Boolean = super.setItemField(param1,param2,param3);
            if(!_loc4_)
            {
                switch(param1)
                {
                    case NodeData.VEH_COMPARE_TREE_NODE_DATA:
                        _loc4_ = this.setVehCompareTreeNode(param2,param3);
                        break;
                }
            }
            return _loc4_;
        }

        override protected function onDispose() : void
        {
            if(this.displaySettings != null)
            {
                this.displaySettings.dispose();
                this.displaySettings = null;
            }
            super.onDispose();
        }

        public function getDisplaySettings() : NationDisplaySettings
        {
            return this.displaySettings;
        }

        public function getScrollIndex() : Number
        {
            return this.scrollIndex;
        }

        private function setVehCompareTreeNode(param1:Number, param2:Object) : Boolean
        {
            var _loc3_:* = false;
            if(param1 < nodeData.length && nodeData[param1] != null)
            {
                nodeData[param1].setVehCompareTreeNode(param2);
                _loc3_ = true;
            }
            return _loc3_;
        }
    }
}
