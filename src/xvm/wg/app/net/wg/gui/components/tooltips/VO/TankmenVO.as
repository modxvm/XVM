package net.wg.gui.components.tooltips.VO
{
   import net.wg.gui.components.tooltips.helpers.Utils;


   public class TankmenVO extends Object
   {
          
      public function TankmenVO(param1:Object) {
         super();
         this.parsHash(param1);
      }

      public var vName:String = "";

      public var rank:String = "";

      public var vehicleContour:String = "";

      public var currentVehicleType:String = "";

      public var params:Array = null;

      public var vehicleName:String = "";

      public var currentVehicleName:String = "";

      public var isCurrentVehiclePremium:Boolean = false;

      public var newSkillsCount:Number = 0;

      public var status:Boolean = false;

      public var statusHeader:String = null;

      public var statusLevel:String = null;

      public var statusText:String = null;

      private function parsHash(param1:Object) : void {
         var _loc14_:uint = 0;
         this.vName = (param1.hasOwnProperty("name")) && !(param1["name"] == undefined)?param1["name"]:"";
         this.rank = (param1.hasOwnProperty("rank")) && !(param1["rank"] == undefined)?param1["rank"]:"";
         this.vehicleContour = (param1.hasOwnProperty("vehicleContour")) && !(param1["vehicleContour"] == undefined)?param1["vehicleContour"]:"";
         this.currentVehicleType = (param1.hasOwnProperty("currentVehicleType")) && !(param1["currentVehicleType"] == undefined)?param1["currentVehicleType"]:"";
         this.newSkillsCount = (param1.hasOwnProperty("newSkillsCount")) && !(param1["newSkillsCount"] == undefined)?param1["newSkillsCount"]:0;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:* = "";
         _loc3_ = (param1.hasOwnProperty("penalty")) && !(param1["penalty"] == undefined)?param1["penalty"]:0;
         _loc4_ = (param1.hasOwnProperty("fromEquipment")) && !(param1["fromEquipment"] == undefined)?param1["fromEquipment"]:0;
         _loc5_ = (param1.hasOwnProperty("fromCommander")) && !(param1["fromCommander"] == undefined)?param1["fromCommander"]:0;
         _loc6_ = (param1.hasOwnProperty("fromSkills")) && !(param1["fromSkills"] == undefined)?param1["fromSkills"]:0;
         _loc2_ = (param1.hasOwnProperty("roleLevel")) && !(param1["roleLevel"] == undefined)?param1["roleLevel"]:0;
         var _loc8_:Number = _loc3_ + _loc4_;
         var _loc9_:String = _loc8_ == 0?"":this.getSign(_loc8_) + _loc8_.toString();
         var _loc10_:String = _loc5_ == 0?"":this.getSign(_loc5_) + _loc5_.toString();
         var _loc11_:String = _loc6_ == 0?"":this.getSign(_loc6_) + _loc6_.toString();
         if(!(_loc8_ == 0) || !(_loc5_ == 0) || !(_loc6_ == 0))
         {
            _loc7_ = " (" + _loc2_ + _loc9_ + _loc10_ + _loc11_ + ")";
         }
         else
         {
            _loc7_ = "";
         }
         _loc2_ = _loc2_ + (_loc8_ + _loc5_ + _loc6_);
         this.vehicleName = (param1.hasOwnProperty("vehicleName")) && !(param1["vehicleName"] == undefined)?param1["vehicleName"]:"";
         this.currentVehicleName = (param1.hasOwnProperty("currentVehicleName")) && !(param1["currentVehicleName"] == undefined)?param1["currentVehicleName"]:"";
         this.isCurrentVehiclePremium = (param1.hasOwnProperty("isCurrentVehiclePremium")) && !(param1["isCurrentVehiclePremium"] == undefined)?param1["isCurrentVehiclePremium"]:false;
         var _loc12_:String = _loc3_ < 0?Utils.instance.COLOR_ALERT:Utils.instance.COLOR_NORMAL;
         this.params = [];
         this.params[0] = [];
         this.params[0][0] = param1.role;
         this.params[0][1] = Utils.instance.htmlWrapper(_loc2_.toString() + "%" + _loc7_,_loc12_,12,"$TextFont");
         var _loc13_:Array = param1.hasOwnProperty("skills")?param1["skills"]:[];
         if(_loc13_.length > 0 && !(_loc13_[0].id == "new_skill"))
         {
            _loc14_ = 0;
            while(_loc14_ < _loc13_.length)
            {
               this.params[_loc14_ + 1] = [];
               this.params[_loc14_ + 1][0] = (_loc13_[_loc14_].hasOwnProperty("label")) && !(_loc13_[_loc14_]["label"] == undefined)?_loc13_[_loc14_]["label"]:"";
               this.params[_loc14_ + 1][1] = (_loc13_[_loc14_].hasOwnProperty("level")) && !(_loc13_[_loc14_]["level"] == undefined)?_loc13_[_loc14_]["level"] + "%":"";
               this.params[_loc14_ + 1][2] = (_loc13_[_loc14_].hasOwnProperty("enabled")) && !(_loc13_[_loc14_]["enabled"] == undefined)?_loc13_[_loc14_]["enabled"]:"";
               _loc14_++;
            }
         }
         if((param1.hasOwnProperty("status")) && !(param1["status"] == undefined))
         {
            this.statusHeader = (param1["status"].hasOwnProperty("header")) && !(param1["status"]["header"] == undefined)?param1["status"]["header"]:"";
            this.statusLevel = (param1["status"].hasOwnProperty("level")) && !(param1["status"]["level"] == undefined)?param1["status"]["level"]:"";
            this.statusText = (param1["status"].hasOwnProperty("text")) && !(param1["status"]["text"] == undefined)?param1["status"]["text"]:"";
         }
         else
         {
            this.statusHeader = null;
            this.statusLevel = null;
            this.statusText = null;
         }
         if((this.statusHeader) || (this.statusText))
         {
            this.status = true;
         }
      }

      private function getSign(param1:Number) : String {
         return param1 >= 0?"+":"";
      }
   }

}