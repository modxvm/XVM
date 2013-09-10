package net.wg.gui.lobby.tankman 
{
    public class PersonalCaseSkillsModel extends Object
    {
        public function PersonalCaseSkillsModel()
        {
            super();
            return;
        }

        public var rankId:String="";

        public var isHeader:Boolean=false;

        public var title:String="";

        public var desc:String="";

        public var enabled:Boolean=false;

        public var name:String="";

        public var tankmanID:int=0;

        public var selfSkill:Boolean=false;

        public var hasNewSkills:Boolean=false;
    }
}
