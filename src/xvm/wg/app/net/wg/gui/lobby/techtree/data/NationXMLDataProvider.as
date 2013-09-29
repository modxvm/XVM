package net.wg.gui.lobby.techtree.data 
{
    import flash.geom.*;
    import net.wg.gui.lobby.techtree.data.vo.*;
    
    public class NationXMLDataProvider extends net.wg.gui.lobby.techtree.data.NationVODataProvider
    {
        public function NationXMLDataProvider()
        {
            super();
            return;
        }

        public override function parse(arg1:Object):void
        {
            var loc4:*=NaN;
            var loc5:*=null;
            var loc7:*=null;
            clearUp();
            var loc1:*=String(arg1);
            var loc2:*=new XML(loc1);
            loc2.ignoreWhite = true;
            var loc3:*=loc2.children()[0];
            var loc8:*=0;
            var loc9:*=loc3.children();
            for each (loc5 in loc9) 
            {
                loc7 = this.getNodeData(loc5);
                loc4 = nodeData.length;
                if (isNaN(loc7.id)) 
                {
                    continue;
                }
                nodeIdxCache[loc7.id] = loc4;
                nodeData.push(loc7);
            }
            if ((loc4 = loc2.children()[1].text()) > -1) 
            {
                _scrollIndex = loc4;
            }
            var loc6:*=loc2.children()[2];
            _displaySettings = new net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings(loc6.child("nodeRendererName").text(), loc6.child("isLevelDisplayed").text());
            return;
        }

        internal function getNodeDisplayInfo(arg1:XML):net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc1:*=[];
            var loc7:*=0;
            var loc8:*=arg1.child("lines").children();
            for each (loc4 in loc8) 
            {
                loc3 = {"outLiteral":loc4.child("outLiteral").text(), "outPin":[loc4.child("outPin").child("x").text(), loc4.child("outPin").child("y").text()], "inPins":[]};
                var loc9:*=0;
                var loc10:*=loc4.child("inPins").children();
                for each (loc5 in loc10) 
                {
                    loc2 = {"childID":loc5.child("childID").text(), "inPin":[loc5.child("inPin").child("x").text(), loc5.child("inPin").child("y").text()], "viaPins":[]};
                    var loc11:*=0;
                    var loc12:*=loc5.child("viaPins").children();
                    for each (loc6 in loc12) 
                    {
                        loc2.viaPins.push([loc6.child("x").text(), loc6.child("y").text()]);
                    }
                    loc3.inPins.push(loc2);
                }
                loc1.push(loc3);
            }
            return new net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo(arg1.child("row").text(), arg1.child("column").text(), new flash.geom.Point(arg1.child("position").child("x").text(), arg1.child("position").child("y").text()), loc1);
        }

        internal function getNodeData(arg1:XML):net.wg.gui.lobby.techtree.data.vo.NodeData
        {
            var loc3:*=null;
            var loc1:*=new net.wg.gui.lobby.techtree.data.vo.NodeData();
            var loc2:*=[];
            var loc4:*=0;
            var loc5:*=arg1.child("unlockProps").child("topIDs").children();
            for each (loc3 in loc5) 
            {
                loc2.push(Number(loc3.toString()));
            }
            loc1.id = arg1.child("id").text();
            loc1.nameString = arg1.child("nameString").text();
            loc1.primaryClass = new net.wg.gui.lobby.techtree.data.vo.PrimaryClass(arg1.child("class").child("name").text(), arg1.child("class").child("userString").text());
            loc1.level = int(arg1.child("level").text());
            loc1.earnedXP = arg1.child("earnedXP").text();
            loc1.state = arg1.child("state").text();
            loc1.unlockProps = new net.wg.gui.lobby.techtree.data.vo.UnlockProps(arg1.child("unlockProps").child("parentID").text(), arg1.child("unlockProps").child("unlockIdx").text(), arg1.child("unlockProps").child("xpCost").text(), loc2);
            loc1.iconPath = arg1.child("iconPath").text();
            loc1.smallIconPath = arg1.child("smallIconPath").text();
            loc1.longName = arg1.child("longName").text();
            loc1.pickleDump = arg1.child("dump").text();
            loc1.shopPrice = new net.wg.gui.lobby.techtree.data.vo.ShopPrice(arg1.child("shopPrice").child("credits").text(), arg1.child("shopPrice").child("gold").text());
            loc1.displayInfo = this.getNodeDisplayInfo(arg1.child("display")[0]);
            return loc1;
        }
    }
}
