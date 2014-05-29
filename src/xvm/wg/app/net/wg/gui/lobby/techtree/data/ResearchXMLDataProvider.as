package net.wg.gui.lobby.techtree.data
{
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.data.vo.ResearchDisplayInfo;
   import net.wg.gui.lobby.techtree.data.vo.VehGlobalStats;
   import net.wg.gui.lobby.techtree.data.vo.ExtraInformation;
   import net.wg.gui.lobby.techtree.data.vo.PrimaryClass;
   import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
   import net.wg.gui.lobby.techtree.data.vo.ShopPrice;


   public class ResearchXMLDataProvider extends ResearchVODataProvider
   {
          
      public function ResearchXMLDataProvider() {
         super();
      }

      override public function parse(param1:Object) : void {
         var _loc5_:* = NaN;
         var _loc6_:XML = null;
         var _loc7_:NodeData = null;
         var _loc8_:ResearchDisplayInfo = null;
         clearUp();
         NodeData.setDisplayInfoClass(ResearchDisplayInfo);
         var _loc2_:String = String(param1);
         var _loc3_:XML = new XML(_loc2_);
         _loc3_.ignoreWhite = true;
         var _loc4_:XML = _loc3_.children()[0];
         for each (_loc6_ in _loc4_.children())
         {
            _loc7_ = this.getNodeData(_loc6_);
            _loc5_ = topData.length;
            if(!isNaN(_loc7_.id))
            {
               topLevelIdxCache[_loc7_.id] = _loc5_;
               topData.push(_loc7_);
            }
         }
         _loc4_ = _loc3_.children()[1];
         for each (_loc6_ in _loc4_.children())
         {
            _loc7_ = this.getNodeData(_loc6_);
            _loc5_ = nodeData.length;
            if(!isNaN(_loc7_.id))
            {
               nodeIdxCache[_loc7_.id] = _loc5_;
               nodeData.push(_loc7_);
               _loc8_ = _loc7_.displayInfo as ResearchDisplayInfo;
               depthOfPaths.push(_loc8_ != null?_loc8_.getDepthOfPath():0);
            }
         }
         _loc4_ = _loc3_.children()[2];
         global = new VehGlobalStats(Number(_loc4_.child("enableInstallItems").text()) == 1?true:false,_loc4_.child("statusString").text(),new ExtraInformation(_loc4_.child("extraInfo").child("type").text(),_loc4_.child("extraInfo").child("title").text(),_loc4_.child("extraInfo").child("benefitsHead").text(),_loc4_.child("extraInfo").child("benefitsList").text()),_loc4_.child("freeXP").text(),Number(_loc4_.child("hasNationTree").text()) == 1?true:false);
      }

      private function getNodeDisplayInfo(param1:XML) : ResearchDisplayInfo {
         var _loc3_:XML = null;
         var _loc2_:Array = [];
         for each (_loc3_ in param1.child("path").children())
         {
            _loc2_.push(_loc3_.text());
         }
         return new ResearchDisplayInfo(_loc2_,param1.child("renderer").text(),param1.child("level").text());
      }

      private function getNodeData(param1:XML) : NodeData {
         var _loc2_:NodeData = null;
         var _loc4_:XML = null;
         _loc2_ = new NodeData();
         var _loc3_:Array = [];
         for each (_loc4_ in param1.child("unlockProps").child("required").children())
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
         _loc2_.shopPrice = new ShopPrice(param1.child("shopPrice").child("credits").text(),param1.child("shopPrice").child("gold").text(),param1.child("shopPrice").child("actionPriceData").text());
         _loc2_.displayInfo = this.getNodeDisplayInfo(param1.child("display")[0]);
         return _loc2_;
      }
   }

}