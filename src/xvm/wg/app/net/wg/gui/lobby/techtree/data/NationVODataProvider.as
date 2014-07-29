package net.wg.gui.lobby.techtree.data
{
    import net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider;
    import net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings;
    import net.wg.gui.lobby.techtree.data.vo.NodeData;
    import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
    import net.wg.utils.ILocale;
    
    public class NationVODataProvider extends AbstractDataProvider implements INationTreeDataProvider
    {
        
        public function NationVODataProvider()
        {
            this._displaySettings = new NationDisplaySettings();
            super();
        }
        
        protected var _scrollIndex:Number = -1;
        
        protected var _displaySettings:NationDisplaySettings;
        
        public function get scrollIndex() : Number
        {
            return this._scrollIndex;
        }
        
        public function get displaySettings() : NationDisplaySettings
        {
            return this._displaySettings;
        }
        
        override public function parse(param1:Object) : void
        {
            var _loc5_:NodeData = null;
            clearUp();
            NodeData.setDisplayInfoClass(NTDisplayInfo);
            var _loc2_:Array = param1.nodes;
            var _loc3_:ILocale = App.utils.locale;
            if(param1.hasOwnProperty("scrollIndex"))
            {
                this._scrollIndex = param1.scrollIndex;
            }
            if(param1.hasOwnProperty("displaySettings"))
            {
                this._displaySettings.fromObject(param1.displaySettings,_loc3_);
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
    }
}
