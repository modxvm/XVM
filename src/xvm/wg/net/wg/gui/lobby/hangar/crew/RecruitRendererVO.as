package net.wg.gui.lobby.hangar.crew 
{
    import net.wg.data.daapi.base.*;
    
    public class RecruitRendererVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function RecruitRendererVO(arg1:Object)
        {
            this._skills = [];
            this._roles = [];
            this._recruitList = [];
            super(arg1);
            return;
        }

        public function set vehicleType(arg1:String):void
        {
            this._vehicleType = arg1;
            return;
        }

        public function get curVehicleType():String
        {
            return this._curVehicleType;
        }

        public function set curVehicleType(arg1:String):void
        {
            this._curVehicleType = arg1;
            return;
        }

        public function get curVehicleName():String
        {
            return this._curVehicleName;
        }

        public function set curVehicleName(arg1:String):void
        {
            this._curVehicleName = arg1;
            return;
        }

        public function get vehicleElite():Boolean
        {
            return this._vehicleElite;
        }

        public function set vehicleElite(arg1:Boolean):void
        {
            this._vehicleElite = arg1;
            return;
        }

        public function get selected():Boolean
        {
            return this._selected;
        }

        public function set selected(arg1:Boolean):void
        {
            this._selected = arg1;
            return;
        }

        public function get roleType():String
        {
            return this._roleType;
        }

        public function set roleType(arg1:String):void
        {
            this._roleType = arg1;
            return;
        }

        public function set rankIconFile(arg1:String):void
        {
            this._rankIconFile = arg1;
            return;
        }

        public function get typeID():Number
        {
            return this._typeID;
        }

        public function set typeID(arg1:Number):void
        {
            this._typeID = arg1;
            return;
        }

        public function get nationID():Number
        {
            return this._nationID;
        }

        public function set nationID(arg1:Number):void
        {
            this._nationID = arg1;
            return;
        }

        public function get bonus():Number
        {
            return this._bonus;
        }

        public function set bonus(arg1:Number):void
        {
            this._bonus = arg1;
            return;
        }

        public function get slot():Number
        {
            return this._slot;
        }

        public function set slot(arg1:Number):void
        {
            this._slot = arg1;
            return;
        }

        public function get roles():Array
        {
            return this._roles;
        }

        public function get isLessMastered():Boolean
        {
            return this._isLessMastered;
        }

        public function set isLessMastered(arg1:Boolean):void
        {
            this._isLessMastered = arg1;
            return;
        }

        public function get compact():String
        {
            return this._compact;
        }

        public function set compact(arg1:String):void
        {
            this._compact = arg1;
            return;
        }

        public function get inTank():Boolean
        {
            return this._inTank;
        }

        public function set inTank(arg1:Boolean):void
        {
            this._inTank = arg1;
            return;
        }

        public function get contourIconFile():String
        {
            return this._contourIconFile;
        }

        public function set contourIconFile(arg1:String):void
        {
            this._contourIconFile = arg1;
            return;
        }

        public function get efficiencyLevel():Number
        {
            return this._efficiencyLevel;
        }

        public function set efficiencyLevel(arg1:Number):void
        {
            this._efficiencyLevel = arg1;
            return;
        }

        public function get recruitList():Array
        {
            return this._recruitList;
        }

        public function set recruitList(arg1:Array):void
        {
            this._recruitList = arg1;
            return;
        }

        public override function dispose():void
        {
            this._roles.splice(0, this._roles.length);
            this._roles = null;
            this._skills.splice(0, this._skills.length);
            this._roles = null;
            this._recruitList.splice(0, this._recruitList.length);
            this._recruitList = null;
            super.dispose();
            return;
        }

        protected override function onDataWrite(arg1:String, arg2:Object):Boolean
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=arg1;
            switch (loc3) 
            {
                case "roles":
                    if (App.instance) 
                        App.utils.asserter.assert(arg2 is Array, "value must extends an Array class.");
                    if (this._roles) 
                        this._roles.splice(0, this._roles.length);
                    else 
                        this._roles = [];
                    loc3 = 0;
                    var loc4:*=arg2;
                    for each (loc1 in loc4) 
                        this._roles.push(loc1);
                    return false;
                case "skills":
                    if (App.instance) 
                        App.utils.asserter.assert(arg2 is Array, "value must extends an Array class.");
                    if (this._skills) 
                        this._skills.splice(0, this._skills.length);
                    else 
                        this._skills = [];
                    loc3 = 0;
                    loc4 = arg2;
                    for each (loc2 in loc4) 
                        this._skills.push(new net.wg.gui.lobby.hangar.crew.SkillsVO(loc2));
                    return false;
                default:
                    return true;
            }
        }

        public function get skills():Array
        {
            return this._skills;
        }

        public function set skills(arg1:Array):void
        {
            this._skills = arg1;
            return;
        }

        public function get lastSkillLevel():Number
        {
            return this._lastSkillLevel;
        }

        public function set lastSkillLevel(arg1:Number):void
        {
            this._lastSkillLevel = arg1;
            return;
        }

        public function get tankmanID():Number
        {
            return this._tankmanID;
        }

        public function set tankmanID(arg1:Number):void
        {
            this._tankmanID = arg1;
            return;
        }

        public function get parentTankmanID():Number
        {
            return this._parentTankmanID;
        }

        public function set parentTankmanID(arg1:Number):void
        {
            this._parentTankmanID = arg1;
            return;
        }

        public function get recruit():Boolean
        {
            return this._recruit;
        }

        public function set recruit(arg1:Boolean):void
        {
            this._recruit = arg1;
            return;
        }

        public function get personalCase():Boolean
        {
            return this._personalCase;
        }

        public function set personalCase(arg1:Boolean):void
        {
            this._personalCase = arg1;
            return;
        }

        public function get iconFile():String
        {
            return this._iconFile;
        }

        public function set iconFile(arg1:String):void
        {
            this._iconFile = arg1;
            return;
        }

        public function get rankIconFile():String
        {
            return this._rankIconFile;
        }

        public function set roles(arg1:Array):void
        {
            this._roles = arg1;
            return;
        }

        public function get roleIconFile():String
        {
            return this._roleIconFile;
        }

        public function set roleIconFile(arg1:String):void
        {
            this._roleIconFile = arg1;
            return;
        }

        public function get availableSkillsCount():Number
        {
            return this._availableSkillsCount;
        }

        public function set availableSkillsCount(arg1:Number):void
        {
            this._availableSkillsCount = arg1;
            return;
        }

        public function get firstname():String
        {
            return this._firstname;
        }

        public function set firstname(arg1:String):void
        {
            this._firstname = arg1;
            return;
        }

        public function get lastname():String
        {
            return this._lastname;
        }

        public function set lastname(arg1:String):void
        {
            this._lastname = arg1;
            return;
        }

        public function get rank():String
        {
            return this._rank;
        }

        public function set rank(arg1:String):void
        {
            this._rank = arg1;
            return;
        }

        public function get role():String
        {
            return this._role;
        }

        public function set role(arg1:String):void
        {
            this._role = arg1;
            return;
        }

        public function get specializationLevel():Number
        {
            return this._specializationLevel;
        }

        public function set specializationLevel(arg1:Number):void
        {
            this._specializationLevel = arg1;
            return;
        }

        public function get tankType():String
        {
            return this._tankType;
        }

        public function set tankType(arg1:String):void
        {
            this._tankType = arg1;
            return;
        }

        public function get vehicleType():String
        {
            return this._vehicleType;
        }

        internal var _skills:Array;

        internal var _roles:Array;

        internal var _recruitList:Array;

        internal var _lastSkillLevel:Number;

        internal var _tankmanID:Number;

        internal var _parentTankmanID:Number;

        internal var _recruit:Boolean;

        internal var _personalCase:Boolean;

        internal var _iconFile:String="";

        internal var _rankIconFile:String="";

        internal var _roleIconFile:String="";

        internal var _firstname:String="";

        internal var _lastname:String="";

        internal var _rank:String="";

        internal var _role:String="";

        internal var _specializationLevel:Number;

        internal var _bonus:Number;

        internal var _slot:Number;

        internal var _typeID:Number;

        internal var _nationID:Number;

        internal var _tankType:String="";

        internal var _vehicleType:String="";

        internal var _curVehicleType:String="";

        internal var _curVehicleName:String="";

        internal var _vehicleElite:Boolean;

        internal var _selected:Boolean;

        internal var _roleType:String="";

        internal var _isLessMastered:Boolean;

        internal var _compact:String="";

        internal var _inTank:Boolean;

        internal var _contourIconFile:String="";

        internal var _efficiencyLevel:Number;

        internal var _availableSkillsCount:Number;
    }
}
