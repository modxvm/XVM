package net.wg.gui.lobby.tankman 
{
    public class CarouselTankmanSkillsModel extends Object
    {
        public function CarouselTankmanSkillsModel()
        {
            super();
            return;
        }

        public static const ROLE_TYPE_COMMON:String="common";

        public var name:String=null;

        public var description:String=null;

        public var icon:String="";

        public var roleIcon:String="";

        public var isActive:Boolean=false;

        public var isCommon:Boolean=false;

        public var isPerk:Boolean=false;

        public var level:int=-1;

        public var userName:String=null;

        public var isNewSkill:Boolean=false;

        public var skillsCountForLearn:int=0;

        public var enabled:Boolean=true;

        public var roleType:String=null;

        public var tankmanID:int=-1;
    }
}
