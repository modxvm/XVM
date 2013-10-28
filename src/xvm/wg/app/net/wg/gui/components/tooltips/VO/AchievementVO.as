package net.wg.gui.components.tooltips.VO
{
   import net.wg.gui.components.tooltips.helpers.Utils;


   public class AchievementVO extends Object
   {
          
      public function AchievementVO(param1:Object) {
         super();
         this.parsHash(param1);
      }

      public var aName:String = null;

      public var description:String = null;

      public var inactive:Boolean = false;

      public var historyDescr:String = null;

      public var section:String = null;

      public var type:String = null;

      public var value:Number = NaN;

      public var icon:String = null;

      public var params:Array = null;

      public var stats:Object = null;

      public var vehicleToKill:Array = null;

      public var vehicleToKillLeft:Number = 0;

      public var isInDossier:Boolean = false;

      public var classParams:Array = null;

      public var achievedOn:String = null;

      public var closeToRecord:Array = null;

      private function parsHash(param1:Object) : void {
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:* = NaN;
         var _loc8_:uint = 0;
         var _loc9_:* = undefined;
         var _loc10_:Object = null;
         this.aName = (param1.hasOwnProperty("name")) && !(param1["name"] == undefined)?param1["name"]:null;
         this.description = (param1.hasOwnProperty("descr")) && !(param1["descr"] == undefined)?Utils.instance.htmlWrapper(param1["descr"],Utils.instance.COLOR_NORMAL,12,"$TextFont"):null;
         var _loc2_:String = (param1.hasOwnProperty("condition")) && !(param1["condition"] == undefined) && !(param1["condition"] == "")?Utils.instance.htmlWrapper(param1["condition"],Utils.instance.COLOR_SUB_NORMAL,12,"$TextFont"):null;
         if(_loc2_)
         {
            this.description = this.description?this.description + "<br/><br/>" + _loc2_:_loc2_;
         }
         this.inactive = (param1.hasOwnProperty("inactive")) && !(param1["inactive"] == undefined)?param1["inactive"]:false;
         this.historyDescr = (param1.hasOwnProperty("historyDescr")) && !(param1["historyDescr"] == "") && !(param1["historyDescr"] == undefined)?param1["historyDescr"]:null;
         this.section = (param1.hasOwnProperty("section")) && !(param1["section"] == undefined)?param1["section"]:null;
         this.type = (param1.hasOwnProperty("type")) && !(param1["type"] == undefined)?param1["type"]:null;
         this.value = (param1.hasOwnProperty("value")) && !(param1["value"] == undefined)?param1["value"]:NaN;
         this.icon = (param1.hasOwnProperty("icon")) && !(param1["icon"] == undefined)?param1["icon"]:null;
         this.isInDossier = (param1.hasOwnProperty("isInDossier")) && !(param1["isInDossier"] == undefined)?param1["isInDossier"]:null;
         var _loc3_:Boolean = (param1.hasOwnProperty("params")) && !(param1["params"] == undefined)?true:false;
         if(_loc3_)
         {
            if(param1["params"]  is  Array && param1["params"][0]  is  Array)
            {
               _loc4_ = param1["params"][0];
               this.params = [];
               _loc5_ = _loc4_.length;
               _loc6_ = "";
               _loc7_ = NaN;
               _loc8_ = 0;
               while(_loc8_ < _loc5_)
               {
                  _loc9_ = _loc4_[_loc8_];
                  _loc6_ = _loc9_[0];
                  if((_loc6_ == "vehiclesToKill" || _loc6_ == "vehiclesToResearch") && _loc9_[1]  is  Array)
                  {
                     this.vehicleToKill = _loc9_[1];
                     _loc7_ = _loc9_[2];
                     this.vehicleToKillLeft = _loc7_ - this.vehicleToKill.length;
                     if(this.vehicleToKillLeft < 0)
                     {
                        this.vehicleToKillLeft = 0;
                     }
                  }
                  else
                  {
                     _loc7_ = _loc9_[1];
                  }
                  this.params.push(
                     {
                        "id":_loc6_,
                        "val":_loc7_
                     }
                  );
                  _loc8_++;
               }
            }
         }
         this.stats = (param1.hasOwnProperty("stats")) && !(param1["stats"] == undefined)?param1["stats"]:null;
         if(this.stats)
         {
            this.classParams = (param1["stats"].hasOwnProperty("classParams")) && !(param1["stats"]["classParams"] == undefined)?param1["stats"]["classParams"]:null;
         }
         if((param1.hasOwnProperty("records")) && !(param1["records"] == undefined) && !(param1["records"] == null))
         {
            _loc10_ = param1["records"];
            this.achievedOn = (_loc10_.hasOwnProperty("current")) && !(_loc10_["current"] == undefined) && !(_loc10_["current"] == null)?_loc10_["current"]:null;
            this.closeToRecord = (_loc10_.hasOwnProperty("nearest")) && !(_loc10_["nearest"] == undefined) && !(_loc10_["nearest"] == null)?_loc10_["nearest"]:null;
         }
      }
   }

}