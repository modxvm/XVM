package net.wg.gui.lobby.tankman 
{
    public class PersonalCaseModel extends Object
    {
        public function PersonalCaseModel()
        {
            this.nativeVehicle = new NativeVehicle();
            this.skills = [];
            super();
            return;
        }

        public var inventoryID:int;

        public var iconFile:String=null;

        public var rankIconFile:String=null;

        public var nativeVehicle:NativeVehicle;

        public var firstname:String=null;

        public var lastname:String=null;

        public var rank:String=null;

        public var nationID:int;

        public var currentVehicle:net.wg.gui.lobby.tankman.PersonalCaseCurrentVehicle=null;

        public var specializationLevel:String;

        public var inTank:Boolean=false;

        public var role:String=null;

        public var roleType:String=null;

        public var skills:Array;

        public var wg_freeXpToTankman:Boolean=false;

        public var skillsCountForLearn:int=0;

        public var lastNewSkillExp:int=0;

        public var lastSkillLevel:int=99;
    }
}


class NativeVehicle extends Object
{
    public function NativeVehicle()
    {
        super();
        return;
    }

    public var userName:String=null;

    public var contourIconFile:String=null;

    public var icon:String=null;

    public var innationID:int;

    public var type:String=null;
}