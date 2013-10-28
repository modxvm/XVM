package net.wg.gui.lobby.window
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel;


   public class ExchangeFreeToTankmanInitVO extends DAAPIDataClass
   {
          
      public function ExchangeFreeToTankmanInitVO(param1:Object) {
         super(param1);
      }

      public var tankmanID:int = -1;

      private var _currentSkill:Object;

      public var lastSkillLevel:Number;

      public var nextSkillLevel:Number;

      private var _beforeSkill:CarouselTankmanSkillsModel;

      private var _afterSkill:CarouselTankmanSkillsModel;

      public function get currentSkill() : Object {
         return this._currentSkill;
      }

      public function set currentSkill(param1:Object) : void {
         this._currentSkill = param1;
         this._beforeSkill = this.getNewCurrentSkillInstance(this._currentSkill);
         this._afterSkill = this.getNewCurrentSkillInstance(this._currentSkill);
      }

      public function getNewCurrentSkillInstance(param1:Object) : CarouselTankmanSkillsModel {
         var _loc2_:CarouselTankmanSkillsModel = null;
         if(param1)
         {
            _loc2_ = new CarouselTankmanSkillsModel();
            _loc2_.description = param1.description;
            _loc2_.icon = param1.icon.big;
            _loc2_.roleIcon = param1.icon.role;
            _loc2_.isActive = param1.isActive;
            _loc2_.isCommon = param1.roleType == CarouselTankmanSkillsModel.ROLE_TYPE_COMMON;
            _loc2_.roleType = param1.roleType;
            _loc2_.isPerk = param1.isPerk;
            _loc2_.level = param1.level;
            _loc2_.userName = param1.userName;
            _loc2_.name = param1.name;
            _loc2_.tankmanID = this.tankmanID;
         }
         return _loc2_;
      }

      public function get beforeSkill() : CarouselTankmanSkillsModel {
         return this._beforeSkill;
      }

      public function get afterSkill() : CarouselTankmanSkillsModel {
         return this._afterSkill;
      }
   }

}