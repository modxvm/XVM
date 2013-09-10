package net.wg.gui.lobby.window 
{
    import net.wg.data.daapi.base.*;
    import net.wg.gui.lobby.tankman.*;
    
    public class ExchangeFreeToTankmanInitVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function ExchangeFreeToTankmanInitVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function get currentSkill():Object
        {
            return this._currentSkill;
        }

        public function set currentSkill(arg1:Object):void
        {
            this._currentSkill = arg1;
            this._beforeSkill = this.getNewCurrentSkillInstance(this._currentSkill);
            this._afterSkill = this.getNewCurrentSkillInstance(this._currentSkill);
            return;
        }

        public function getNewCurrentSkillInstance(arg1:Object):net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel
        {
            var loc1:*=null;
            if (arg1) 
            {
                loc1 = new net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel();
                loc1.description = arg1.description;
                loc1.icon = arg1.icon.big;
                loc1.roleIcon = arg1.icon.role;
                loc1.isActive = arg1.isActive;
                loc1.isCommon = arg1.roleType == net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel.ROLE_TYPE_COMMON;
                loc1.roleType = arg1.roleType;
                loc1.isPerk = arg1.isPerk;
                loc1.level = arg1.level;
                loc1.userName = arg1.userName;
                loc1.name = arg1.name;
                loc1.tankmanID = this.tankmanID;
            }
            return loc1;
        }

        public function get beforeSkill():net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel
        {
            return this._beforeSkill;
        }

        public function get afterSkill():net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel
        {
            return this._afterSkill;
        }

        public var tankmanID:int=-1;

        internal var _currentSkill:Object;

        public var lastSkillLevel:Number;

        public var nextSkillLevel:Number;

        internal var _beforeSkill:net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel;

        internal var _afterSkill:net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel;
    }
}
