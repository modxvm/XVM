package net.wg.gui.lobby.techtree.data
{
    import net.wg.gui.lobby.techtree.data.vo.NodeData;
    import net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings;
    import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
    import flash.geom.Point;
    import net.wg.gui.lobby.techtree.data.vo.PrimaryClass;
    import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
    import net.wg.gui.lobby.techtree.data.vo.ShopPrice;
    
    public class NationXMLDataProvider extends NationVODataProvider
    {
        
        public function NationXMLDataProvider()
        {
            super();
        }
        
        override public function parse(param1:Object) : void
        {
            var _loc5_:* = NaN;
            var _loc6_:XML = null;
            var _loc8_:NodeData = null;
            clearUp();
            var _loc2_:String = String(param1);
            var _loc3_:XML = new XML(_loc2_);
            _loc3_.ignoreWhite = true;
            var _loc4_:XML = _loc3_.children()[0];
            for each(_loc6_ in _loc4_.children())
            {
                _loc8_ = this.getNodeData(_loc6_);
                _loc5_ = nodeData.length;
                if(!isNaN(_loc8_.id))
                {
                    nodeIdxCache[_loc8_.id] = _loc5_;
                    nodeData.push(_loc8_);
                }
            }
            _loc5_ = _loc3_.children()[1].text();
            if(_loc5_ > -1)
            {
                _scrollIndex = _loc5_;
            }
            var _loc7_:XML = _loc3_.children()[2];
            _displaySettings = new NationDisplaySettings(_loc7_.child("nodeRendererName").text(),_loc7_.child("isLevelDisplayed").text());
        }
        
        private function getNodeDisplayInfo(param1:XML) : NTDisplayInfo
        {
            /*
             * Decompilation error
             * Code may be obfuscated
             * Error type: TranslateException
             */
            throw new Error("Not decompiled due to error");
        }
        
        private function getNodeData(param1:XML) : NodeData
        {
            var _loc4_:XML = null;
            var _loc2_:NodeData = new NodeData();
            var _loc3_:Array = [];
            for each(_loc4_ in param1.child("unlockProps").child("topIDs").children())
            {
                _loc3_.push(Number(_loc4_.toString()));
            }
            _loc2_.id = param1.child("id").text();
            _loc2_.nameString = param1.child("nameString").text();
            _loc2_.primaryClass = new PrimaryClass(param1.child("class").child("name").text(),param1.child("class").child("userString").text());
            _loc2_.level = int(param1.child("level").text());
            _loc2_.earnedXP = param1.child("earnedXP").text();
            _loc2_.state = param1.child("state").text();
            _loc2_.unlockProps = new UnlockProps(param1.child("unlockProps").child("parentID").text(),param1.child("unlockProps").child("unlockIdx").text(),param1.child("unlockProps").child("xpCost").text(),_loc3_);
            _loc2_.iconPath = param1.child("iconPath").text();
            _loc2_.smallIconPath = param1.child("smallIconPath").text();
            _loc2_.longName = param1.child("longName").text();
            _loc2_.shopPrice = new ShopPrice(param1.child("shopPrice").child("credits").text(),param1.child("shopPrice").child("gold").text());
            _loc2_.displayInfo = this.getNodeDisplayInfo(param1.child("display")[0]);
            return _loc2_;
        }
    }
}
