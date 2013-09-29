package net.wg.gui.lobby.tankman 
{
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class SkillDropModel extends Object implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function SkillDropModel()
        {
            this.dropSkillFree = new DropSkillsCost();
            this.dropSkillCredits = new DropSkillsCost();
            this.dropSkillGold = new DropSkillsCost();
            super();
            return;
        }

        public function get nation():String
        {
            return App.utils.nations.getNationName(this.nationID);
        }

        public function dispose():void
        {
            this.dropSkillFree = null;
            this.dropSkillCredits = null;
            this.dropSkillGold = null;
            return;
        }

        public static function parseFromObject(arg1:Object):net.wg.gui.lobby.tankman.SkillDropModel
        {
            var loc3:*=null;
            var loc1:*=new SkillDropModel();
            loc1.credits = arg1.money[0];
            loc1.gold = arg1.money[1];
            loc1.compactDescriptor = arg1.tankman.strCD;
            loc1.tankmanName = arg1.tankman.firstUserName + " " + arg1.tankman.lastUserName;
            loc1.tankmanIcon = arg1.tankman.icon.big;
            loc1.roleIcon = arg1.tankman.iconRole.small;
            loc1.roleLevel = arg1.tankman.roleLevel;
            loc1.nationID = arg1.tankman.nationID;
            var loc2:*=arg1.tankman.skills;
            loc1.skillsCount = loc2.length;
            if (loc1.skillsCount > 0) 
            {
                loc3 = loc2[(loc1.skillsCount - 1)];
                loc1.lastSkill = loc3.icon.small;
                loc1.lastSkillLevel = loc3.level;
            }
            if (loc1.skillsCount > 1) 
            {
                loc3 = loc2[loc1.skillsCount - 2];
                loc1.preLastSkill = loc3.icon.small;
            }
            loc1.hasNewSkill = arg1.hasNewSkills;
            loc1.dropSkillFree = DropSkillsCost.parseFromObject(arg1.dropSkillsCost[0]);
            loc1.dropSkillFree.id = 0;
            loc1.dropSkillCredits = DropSkillsCost.parseFromObject(arg1.dropSkillsCost[1]);
            loc1.dropSkillCredits.id = 1;
            loc1.dropSkillGold = DropSkillsCost.parseFromObject(arg1.dropSkillsCost[2]);
            loc1.dropSkillGold.id = 2;
            loc1.defaultSavingMode = arg1.defaultSavingMode;
            return loc1;
        }

        public var gold:int=0;

        public var credits:int=0;

        public var compactDescriptor:String="";

        public var tankmanName:String="";

        public var tankmanIcon:String="";

        public var roleIcon:String="";

        public var roleLevel:Number=NaN;

        public var nationID:Number=NaN;

        public var skillsCount:int=0;

        public var lastSkill:String=null;

        public var lastSkillLevel:Number=NaN;

        public var preLastSkill:String=null;

        public var hasNewSkill:Boolean;

        public var dropSkillFree:DropSkillsCost;

        public var dropSkillCredits:DropSkillsCost;

        public var dropSkillGold:DropSkillsCost;

        public var defaultSavingMode:int;
    }
}


class DropSkillsCost extends Object
{
    public function DropSkillsCost()
    {
        super();
        return;
    }

    public static function parseFromObject(arg1:Object):DropSkillsCost
    {
        var loc1:*=new DropSkillsCost();
        loc1.gold = arg1.gold;
        loc1.credits = arg1.credits;
        loc1.xpReuseFraction = arg1.xpReuseFraction;
        return loc1;
    }

    public var credits:int;

    public var gold:int;

    public var xpReuseFraction:Number;

    public var id:int;
}