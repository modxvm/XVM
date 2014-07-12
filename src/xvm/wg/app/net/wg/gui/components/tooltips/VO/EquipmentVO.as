package net.wg.gui.components.tooltips.VO
{
   import net.wg.utils.ILocale;
   import net.wg.data.constants.ValObject;
   import net.wg.gui.components.tooltips.ToolTipSpecial;
   import net.wg.gui.components.tooltips.helpers.Utils;
   
   public class EquipmentVO extends Object
   {
      
      public function EquipmentVO(param1:Object) {
         super();
         this.parsHash(param1);
      }
      
      public var eName:String = "";
      
      public var type:String = "";
      
      public var icon:String = "";
      
      public var extraModuleInfo:ExtraModuleInfoVO = null;
      
      public var tooHeavy:Boolean = false;
      
      public var level:Number = NaN;
      
      public var complex:Boolean = false;
      
      public var complexHeader:String = "";
      
      public var complexNote:String = "";
      
      public var descr:String = "";
      
      public var gold:Boolean = false;
      
      public var removeable:Boolean = false;
      
      public var haveResearchXP:Boolean = false;
      
      public var stats:Object = null;
      
      public var useGold:Boolean = false;
      
      public var useCredits:Boolean = false;
      
      public var isAction:Boolean = false;
      
      public var params:Array = null;
      
      public var paramsEx:Object = null;
      
      public var paramsAdd:Array = null;
      
      public var status:Boolean = false;
      
      public var statusHeader:String = "";
      
      public var statusText:String = "";
      
      public var statusLevel:String = "";
      
      public var effectOnUse:String = "";
      
      public var effectAlways:String = "";
      
      public var effectRestriction:String = "";
      
      public var actionPrc:Number = NaN;
      
      private var hiddenVehicleCount:Number = 0;
      
      public var defSellPrice:Array = null;
      
      public var defBuyPrice:Array = null;
      
      private function parsHash(param1:Object) : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:ILocale = null;
         this.eName = (param1.hasOwnProperty("name")) && !(param1["name"] == undefined)?param1["name"]:"";
         this.type = (param1.hasOwnProperty("type")) && !(param1["type"] == undefined)?param1["type"]:"";
         this.icon = (param1.hasOwnProperty("icon")) && !(param1["icon"] == undefined)?param1["icon"]:"";
         this.extraModuleInfo = param1.hasOwnProperty(ValObject.EXTRA_MODULE_INFO)?new ExtraModuleInfoVO(param1[ValObject.EXTRA_MODULE_INFO]):null;
         this.tooHeavy = (param1.hasOwnProperty("tooHeavy")) && !(param1["tooHeavy"] == undefined)?param1["tooHeavy"]:"";
         this.level = (param1.hasOwnProperty("level")) && !(param1["level"] == undefined)?param1["level"]:NaN;
         this.complex = (param1.hasOwnProperty("note")) && !(param1["note"] == undefined)?true:false;
         if(this.complex)
         {
            this.complexHeader = (param1["note"].hasOwnProperty("title")) && !(param1["note"]["title"] == undefined)?param1["note"]["title"]:"";
            this.complexNote = (param1["note"].hasOwnProperty("text")) && !(param1["note"]["text"] == undefined)?param1["note"]["text"]:"";
         }
         this.descr = (param1.hasOwnProperty("descr")) && !(param1["descr"] == undefined)?param1["descr"]:"";
         this.gold = (param1.hasOwnProperty("gold")) && !(param1["gold"] == undefined)?param1["gold"]:"";
         this.removeable = (param1.hasOwnProperty("removeable")) && !(param1["removeable"] == undefined)?param1["removeable"]:"";
         this.haveResearchXP = (param1.hasOwnProperty("haveResearchXP")) && !(param1["haveResearchXP"] == undefined)?param1["haveResearchXP"]:"";
         this.stats = (param1.hasOwnProperty("stats")) && !(param1["stats"] == undefined) && param1["stats"] is Array?param1["stats"]:null;
         if(this.stats)
         {
            _loc2_ = this.stats.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = this.stats[_loc3_];
               _loc5_ = _loc4_[0];
               if(_loc5_ == ToolTipSpecial.ID_BUY_PRICE || _loc5_ == ToolTipSpecial.ID_SELL_PRICE)
               {
                  _loc6_ = _loc4_[1];
                  _loc7_ = _loc6_[0] is Array?_loc6_[0][0]:_loc6_[0];
                  _loc8_ = _loc6_[0] is Array?_loc6_[0][1]:_loc6_[1];
                  if(_loc7_ > 0)
                  {
                     this.useCredits = true;
                  }
                  if(_loc8_ > 0)
                  {
                     this.useGold = true;
                  }
               }
               else if(_loc5_ == VehicleBaseVO.DEF_BUY_PRICE)
               {
                  this.defBuyPrice = _loc4_[1];
               }
               else if(_loc5_ == VehicleBaseVO.DEF_SELL_PRICE)
               {
                  this.defSellPrice = _loc4_[1];
               }
               else if(_loc5_ == VehicleBaseVO.ACTION_PRC)
               {
                  _loc9_ = _loc4_[1];
                  this.isAction = !(_loc9_ == 0);
                  this.actionPrc = _loc9_;
               }
               else if(_loc5_ == "hiddenVehicleCount")
               {
                  this.hiddenVehicleCount = _loc4_[1];
               }
               
               
               
               
               _loc3_++;
            }
         }
         if((param1.hasOwnProperty("params")) && !(param1["params"] == undefined))
         {
            this.params = (param1["params"][0]) && (!(param1["params"][0] == undefined)) && param1["params"][0].length > 0?param1["params"][0]:null;
            this.paramsAdd = (param1["params"][1]) && (!(param1["params"][1] == undefined)) && param1["params"][1].length > 0?param1["params"][1]:null;
         }
         else
         {
            this.params = null;
            this.paramsAdd = null;
         }
         if(param1.hasOwnProperty("paramsEx"))
         {
            this.paramsEx = new EquipmentParamVO(param1["paramsEx"]);
         }
         this.status = (param1.hasOwnProperty("status")) && !(param1["status"] == undefined)?param1["status"]:false;
         if(this.status)
         {
            this.statusHeader = (param1["status"].hasOwnProperty("header")) && !(param1["status"]["header"] == undefined)?param1["status"]["header"]:"";
            this.statusText = (param1["status"].hasOwnProperty("text")) && !(param1["status"]["text"] == undefined)?param1["status"]["text"]:"";
            if(this.hiddenVehicleCount > 0 && !(this.statusText == ""))
            {
               _loc10_ = App.utils.locale;
               this.statusText = this.statusText + ("<br/>" + Utils.instance.htmlWrapper(_loc10_.makeString(TOOLTIPS.SUITABLEVEHICLE_HIDDENVEHICLECOUNT),Utils.instance.COLOR_ADD_INFO,14,"$TitleFont") + " " + Utils.instance.htmlWrapper(this.hiddenVehicleCount.toString(),Utils.instance.COLOR_NUMBER,14,"$TitleFont"));
            }
            this.statusLevel = (param1["status"].hasOwnProperty("level")) && !(param1["status"]["level"] == undefined)?param1["status"]["level"]:"";
            this.status = !(this.statusHeader == "") || !(this.statusText == "");
         }
         if((param1.hasOwnProperty("effect")) && !(param1["effect"] == undefined))
         {
            this.effectOnUse = (param1["effect"].hasOwnProperty("onUse")) && !(param1["effect"]["onUse"] == undefined)?param1["effect"]["onUse"]:"";
            this.effectAlways = (param1["effect"].hasOwnProperty("always")) && !(param1["effect"]["always"] == undefined)?param1["effect"]["always"]:"";
            this.effectRestriction = (param1["effect"].hasOwnProperty("restriction")) && !(param1["effect"]["restriction"] == undefined)?param1["effect"]["restriction"]:"";
         }
      }
   }
}
