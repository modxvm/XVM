package net.wg.gui.lobby.hangar.crew
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class RecruitRendererVO extends DAAPIDataClass
    {
        
        public function RecruitRendererVO(param1:Object) {
            this._skills = [];
            this._roles = [];
            this._recruitList = [];
            super(param1);
        }
        
        private var _skills:Array;
        
        private var _roles:Array;
        
        private var _recruitList:Array;
        
        private var _lastSkillLevel:Number;
        
        private var _tankmanID:Number;
        
        private var _parentTankmanID:Number;
        
        private var _recruit:Boolean;
        
        private var _personalCase:Boolean;
        
        private var _iconFile:String = "";
        
        private var _rankIconFile:String = "";
        
        private var _roleIconFile:String = "";
        
        private var _availableSkillsCount:Number;
        
        private var _firstname:String = "";
        
        private var _lastname:String = "";
        
        private var _rank:String = "";
        
        private var _role:String = "";
        
        private var _specializationLevel:Number;
        
        private var _bonus:Number;
        
        private var _slot:Number;
        
        private var _typeID:Number;
        
        private var _nationID:Number;
        
        private var _tankType:String = "";
        
        private var _vehicleType:String = "";
        
        private var _curVehicleType:String = "";
        
        private var _curVehicleName:String = "";
        
        private var _vehicleElite:Boolean;
        
        private var _selected:Boolean;
        
        private var _roleType:String = "";
        
        private var _isLessMastered:Boolean;
        
        private var _compact:String = "";
        
        private var _inTank:Boolean;
        
        private var _contourIconFile:String = "";
        
        private var _efficiencyLevel:Number;
        
        override protected function onDispose() : void {
            this._roles.splice(0,this._roles.length);
            this._roles = null;
            this._skills.splice(0,this._skills.length);
            this._roles = null;
            this._recruitList.splice(0,this._recruitList.length);
            this._recruitList = null;
            super.onDispose();
        }
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean {
            var _loc3_:Object = null;
            var _loc4_:Object = null;
            switch(param1)
            {
                case "roles":
                    if(App.instance)
                    {
                        App.utils.asserter.assert(param2 is Array,"value must extends an Array class.");
                    }
                    if(this._roles)
                    {
                        this._roles.splice(0,this._roles.length);
                    }
                    else
                    {
                        this._roles = [];
                    }
                    for each(_loc3_ in param2)
                    {
                        this._roles.push(_loc3_);
                    }
                    return false;
                case "skills":
                    if(App.instance)
                    {
                        App.utils.asserter.assert(param2 is Array,"value must extends an Array class.");
                    }
                    if(this._skills)
                    {
                        this._skills.splice(0,this._skills.length);
                    }
                    else
                    {
                        this._skills = [];
                    }
                    for each(_loc4_ in param2)
                    {
                        this._skills.push(new SkillsVO(_loc4_));
                    }
                    return false;
                default:
                    return true;
            }
        }
        
        public function get skills() : Array {
            return this._skills;
        }
        
        public function set skills(param1:Array) : void {
            this._skills = param1;
        }
        
        public function get lastSkillLevel() : Number {
            return this._lastSkillLevel;
        }
        
        public function set lastSkillLevel(param1:Number) : void {
            this._lastSkillLevel = param1;
        }
        
        public function get tankmanID() : Number {
            return this._tankmanID;
        }
        
        public function set tankmanID(param1:Number) : void {
            this._tankmanID = param1;
        }
        
        public function get parentTankmanID() : Number {
            return this._parentTankmanID;
        }
        
        public function set parentTankmanID(param1:Number) : void {
            this._parentTankmanID = param1;
        }
        
        public function get recruit() : Boolean {
            return this._recruit;
        }
        
        public function set recruit(param1:Boolean) : void {
            this._recruit = param1;
        }
        
        public function get personalCase() : Boolean {
            return this._personalCase;
        }
        
        public function set personalCase(param1:Boolean) : void {
            this._personalCase = param1;
        }
        
        public function get iconFile() : String {
            return this._iconFile;
        }
        
        public function set iconFile(param1:String) : void {
            this._iconFile = param1;
        }
        
        public function get rankIconFile() : String {
            return this._rankIconFile;
        }
        
        public function set rankIconFile(param1:String) : void {
            this._rankIconFile = param1;
        }
        
        public function get roleIconFile() : String {
            return this._roleIconFile;
        }
        
        public function set roleIconFile(param1:String) : void {
            this._roleIconFile = param1;
        }
        
        public function get availableSkillsCount() : Number {
            return this._availableSkillsCount;
        }
        
        public function set availableSkillsCount(param1:Number) : void {
            this._availableSkillsCount = param1;
        }
        
        public function get firstname() : String {
            return this._firstname;
        }
        
        public function set firstname(param1:String) : void {
            this._firstname = param1;
        }
        
        public function get lastname() : String {
            return this._lastname;
        }
        
        public function set lastname(param1:String) : void {
            this._lastname = param1;
        }
        
        public function get rank() : String {
            return this._rank;
        }
        
        public function set rank(param1:String) : void {
            this._rank = param1;
        }
        
        public function get role() : String {
            return this._role;
        }
        
        public function set role(param1:String) : void {
            this._role = param1;
        }
        
        public function get specializationLevel() : Number {
            return this._specializationLevel;
        }
        
        public function set specializationLevel(param1:Number) : void {
            this._specializationLevel = param1;
        }
        
        public function get tankType() : String {
            return this._tankType;
        }
        
        public function set tankType(param1:String) : void {
            this._tankType = param1;
        }
        
        public function get vehicleType() : String {
            return this._vehicleType;
        }
        
        public function set vehicleType(param1:String) : void {
            this._vehicleType = param1;
        }
        
        public function get curVehicleType() : String {
            return this._curVehicleType;
        }
        
        public function set curVehicleType(param1:String) : void {
            this._curVehicleType = param1;
        }
        
        public function get curVehicleName() : String {
            return this._curVehicleName;
        }
        
        public function set curVehicleName(param1:String) : void {
            this._curVehicleName = param1;
        }
        
        public function get vehicleElite() : Boolean {
            return this._vehicleElite;
        }
        
        public function set vehicleElite(param1:Boolean) : void {
            this._vehicleElite = param1;
        }
        
        public function get selected() : Boolean {
            return this._selected;
        }
        
        public function set selected(param1:Boolean) : void {
            this._selected = param1;
        }
        
        public function get roleType() : String {
            return this._roleType;
        }
        
        public function set roleType(param1:String) : void {
            this._roleType = param1;
        }
        
        public function get typeID() : Number {
            return this._typeID;
        }
        
        public function set typeID(param1:Number) : void {
            this._typeID = param1;
        }
        
        public function get nationID() : Number {
            return this._nationID;
        }
        
        public function set nationID(param1:Number) : void {
            this._nationID = param1;
        }
        
        public function get bonus() : Number {
            return this._bonus;
        }
        
        public function set bonus(param1:Number) : void {
            this._bonus = param1;
        }
        
        public function get slot() : Number {
            return this._slot;
        }
        
        public function set slot(param1:Number) : void {
            this._slot = param1;
        }
        
        public function get roles() : Array {
            return this._roles;
        }
        
        public function set roles(param1:Array) : void {
            this._roles = param1;
        }
        
        public function get isLessMastered() : Boolean {
            return this._isLessMastered;
        }
        
        public function set isLessMastered(param1:Boolean) : void {
            this._isLessMastered = param1;
        }
        
        public function get compact() : String {
            return this._compact;
        }
        
        public function set compact(param1:String) : void {
            this._compact = param1;
        }
        
        public function get inTank() : Boolean {
            return this._inTank;
        }
        
        public function set inTank(param1:Boolean) : void {
            this._inTank = param1;
        }
        
        public function get contourIconFile() : String {
            return this._contourIconFile;
        }
        
        public function set contourIconFile(param1:String) : void {
            this._contourIconFile = param1;
        }
        
        public function get efficiencyLevel() : Number {
            return this._efficiencyLevel;
        }
        
        public function set efficiencyLevel(param1:Number) : void {
            this._efficiencyLevel = param1;
        }
        
        public function get recruitList() : Array {
            return this._recruitList;
        }
        
        public function set recruitList(param1:Array) : void {
            this._recruitList = param1;
        }
    }
}
