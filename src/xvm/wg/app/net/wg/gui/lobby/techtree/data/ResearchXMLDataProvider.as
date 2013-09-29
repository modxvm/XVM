package net.wg.gui.lobby.techtree.data 
{
    import net.wg.gui.lobby.techtree.data.vo.*;
    
    public class ResearchXMLDataProvider extends net.wg.gui.lobby.techtree.data.ResearchVODataProvider
    {
        public function ResearchXMLDataProvider()
        {
            super();
            return;
        }

        public override function parse(arg1:Object):void
        {
            var loc4:*=NaN;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            clearUp();
            net.wg.gui.lobby.techtree.data.vo.NodeData.setDisplayInfoClass(net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo);
            var loc1:*=String(arg1);
            var loc2:*=new XML(loc1);
            loc2.ignoreWhite = true;
            var loc3:*=loc2.children()[0];
            var loc8:*=0;
            var loc9:*=loc3.children();
            for each (loc5 in loc9) 
            {
                loc6 = this.getNodeData(loc5);
                loc4 = topData.length;
                if (isNaN(loc6.id)) 
                {
                    continue;
                }
                topLevelIdxCache[loc6.id] = loc4;
                topData.push(loc6);
            }
            loc3 = loc2.children()[1];
            loc8 = 0;
            loc9 = loc3.children();
            for each (loc5 in loc9) 
            {
                loc6 = this.getNodeData(loc5);
                loc4 = nodeData.length;
                if (isNaN(loc6.id)) 
                {
                    continue;
                }
                nodeIdxCache[loc6.id] = loc4;
                nodeData.push(loc6);
                loc7 = loc6.displayInfo as net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo;
                depthOfPaths.push(loc7 == null ? 0 : loc7.getDepthOfPath());
            }
            loc3 = loc2.children()[2];
            global = new net.wg.gui.lobby.techtree.data.vo.VehGlobalStats(Number(loc3.child("enableInstallItems").text()) != 1 ? false : true, loc3.child("statusString").text(), new net.wg.gui.lobby.techtree.data.vo.ExtraInformation(loc3.child("extraInfo").child("type").text(), loc3.child("extraInfo").child("title").text(), loc3.child("extraInfo").child("benefitsHead").text(), loc3.child("extraInfo").child("benefitsList").text()), loc3.child("freeXP").text(), Number(loc3.child("hasNationTree").text()) != 1 ? false : true);
            return;
        }

        internal function getNodeDisplayInfo(arg1:XML):net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo
        {
            var loc2:*=null;
            var loc1:*=[];
            var loc3:*=0;
            var loc4:*=arg1.child("path").children();
            for each (loc2 in loc4) 
            {
                loc1.push(loc2.text());
            }
            return new net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo(loc1, arg1.child("renderer").text(), arg1.child("level").text());
        }

        internal function getNodeData(arg1:XML):net.wg.gui.lobby.techtree.data.vo.NodeData
        {
            var loc1:*=null;
            var loc3:*=null;
            loc1 = new net.wg.gui.lobby.techtree.data.vo.NodeData();
            var loc2:*=[];
            var loc4:*=0;
            var loc5:*=arg1.child("unlockProps").child("required").children();
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
