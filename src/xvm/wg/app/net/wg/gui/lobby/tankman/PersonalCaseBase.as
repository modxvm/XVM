package net.wg.gui.lobby.tankman
{
    import net.wg.infrastructure.base.meta.impl.PersonalCaseMeta;
    import net.wg.infrastructure.base.meta.IPersonalCaseMeta;
    import net.wg.data.VO.AchievementItemVO;
    import net.wg.data.constants.VehicleTypes;
    import scaleform.gfx.Extensions;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import net.wg.data.constants.IconsTypes;
    
    public class PersonalCaseBase extends PersonalCaseMeta implements IPersonalCaseMeta
    {
        
        public function PersonalCaseBase()
        {
            this.skillsModel = [];
            super();
        }
        
        private static var templateS:Array = ["a","b","c","d","a","b","c","d","a1","b2","c3","d4","a5","b6","c7","d8","az","xb","cc","fd","ga","tb","jc","dg"];
        
        protected var isFirtsRun:Boolean = true;
        
        protected var autoSelectTab:int = 0;
        
        protected var data:PersonalCaseModel;
        
        protected var stats:Object;
        
        protected var retrainingData:PersonalCaseRetrainingModel;
        
        protected var skillsModel:Array;
        
        protected var documentsData:PersonalCaseDocsModel;
        
        protected var rentainingTabUpdated:Boolean = true;
        
        public function as_setCommonData(param1:Object) : void
        {
            this.parsePersonalCaseModel(param1);
            this.updateCommonElements();
        }
        
        public function as_setDossierData(param1:Object) : void
        {
            var _loc5_:Array = null;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            var _loc8_:AchievementItemVO = null;
            var _loc2_:Array = [];
            var _loc3_:int = param1.achievements.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                _loc5_ = param1.achievements[_loc4_];
                _loc6_ = _loc5_.length;
                _loc7_ = 0;
                while(_loc7_ < _loc6_)
                {
                    _loc8_ = new AchievementItemVO(_loc5_[_loc7_]);
                    _loc2_.push(_loc8_);
                    _loc7_++;
                }
                if(_loc4_ < _loc3_ - 1 && _loc2_.length > 0)
                {
                    _loc2_[_loc2_.length - 1].showSeparator = true;
                }
                _loc4_++;
            }
            if(_loc2_.length > 0)
            {
                _loc2_[_loc2_.length - 1].showSeparator = false;
            }
            this.stats = {};
            this.stats.achievements = _loc2_;
            this.stats.stats = param1.stats;
            this.stats.firstMsg = param1.firstMsg;
            this.stats.secondMsg = param1.secondMsg;
            this.runtimeUpdateByModel(PersonalCaseStats,this.stats);
        }
        
        public function as_setRetrainingData(param1:Object) : void
        {
            var _loc4_:Object = null;
            this.retrainingData = new PersonalCaseRetrainingModel();
            this.retrainingData.credits = param1.money[0];
            this.retrainingData.gold = param1.money[1];
            this.retrainingData.tankmanCost = param1.tankmanCost;
            this.retrainingData.vehicles = param1.vehicles;
            this.retrainingData.testData = this.data;
            this.retrainingData.testStats = this.stats;
            this.retrainingData.action = param1.action;
            var _loc2_:Array = param1.vehicles;
            var _loc3_:* = 0;
            while(_loc3_ < _loc2_.length)
            {
                _loc4_ = _loc2_[_loc3_];
                switch(_loc4_.vehicleType)
                {
                    case VehicleTypes.LIGHT_TANK:
                        this.retrainingData.lightTanks.push(_loc4_);
                        break;
                    case VehicleTypes.MEDIUM_TANK:
                        this.retrainingData.mediumTanks.push(_loc4_);
                        break;
                    case VehicleTypes.HEAVY_TANK:
                        this.retrainingData.heavyTanks.push(_loc4_);
                        break;
                    case VehicleTypes.AT_SPG:
                        this.retrainingData.AT_SPG.push(_loc4_);
                        break;
                    case VehicleTypes.SPG:
                        this.retrainingData.SPG.push(_loc4_);
                        break;
                    default:
                        DebugUtils.LOG_DEBUG("ERROR unknown tank type");
                }
                _loc3_++;
            }
            this.retrainingData.nationID = this.data.nationID;
            this.retrainingData.tankmanID = this.data.inventoryID;
            this.retrainingData.currentVehicle = this.data.currentVehicle;
            this.retrainingData.nativeVehicle = this.data.nativeVehicle;
            this.retrainingData.specializationLevel = this.data.specializationLevel;
            this.runtimeUpdateByModel(CrewTankmanRetraining,this.retrainingData);
        }
        
        public function as_setSkillsData(param1:Array) : void
        {
            var _loc4_:PersonalCaseSkillsModel = null;
            var _loc5_:String = null;
            var _loc6_:* = 0;
            var _loc7_:Object = null;
            this.skillsModel = [];
            var _loc2_:* = false;
            var _loc3_:* = 0;
            while(_loc3_ < param1.length)
            {
                if(!(!param1[_loc3_].hasOwnProperty("skills") || !param1[_loc3_].skills is Array || param1[_loc3_].skills.length <= 0))
                {
                    _loc4_ = new PersonalCaseSkillsModel();
                    _loc5_ = param1[_loc3_].id;
                    _loc4_.rankId = _loc5_;
                    _loc4_.title = param1[_loc3_].id;
                    _loc4_.isHeader = true;
                    _loc4_.selfSkill = this.data.roleType == _loc5_;
                    this.skillsModel.push(_loc4_);
                    if((param1[_loc3_].hasOwnProperty("skills")) && param1[_loc3_].skills is Array)
                    {
                        _loc6_ = 0;
                        while(_loc6_ < param1[_loc3_].skills.length)
                        {
                            _loc4_ = new PersonalCaseSkillsModel();
                            _loc7_ = param1[_loc3_].skills[_loc6_];
                            _loc4_.title = _loc7_.id;
                            _loc4_.isHeader = false;
                            _loc4_.desc = _loc7_.desc;
                            _loc4_.enabled = _loc7_.enabled;
                            _loc4_.name = _loc7_.name;
                            _loc4_.tankmanID = _loc7_.tankmanID;
                            _loc4_.rankId = _loc5_;
                            _loc4_.selfSkill = this.data.roleType == _loc5_;
                            _loc4_.hasNewSkills = this.data.skillsCountForLearn > 0;
                            this.skillsModel.push(_loc4_);
                            _loc2_ = false;
                            _loc6_++;
                        }
                    }
                    else
                    {
                        DebugUtils.LOG_DEBUG("ERROR :: not found skills in the title : " + _loc4_.title);
                    }
                }
                _loc3_++;
            }
            if(_loc2_)
            {
                this.skillsModel = [];
            }
            this.runtimeUpdateByModel(PersonalCaseSkills,this.skillsModel);
        }
        
        public function as_setDocumentsData(param1:Object) : void
        {
            this.documentsData = new PersonalCaseDocsModel();
            if(!Extensions.isScaleform)
            {
                this.createTestNames(param1.firstnames);
                this.createTestNames(param1.lastnames);
            }
            this.documentsData.originalIconFile = this.data.iconFile;
            this.documentsData.firstNames = param1.firstnames;
            this.documentsData.lastNames = param1.lastnames;
            if(param1.action)
            {
                this.documentsData.actionPriceDataGoldVo = new ActionPriceVO(param1.action);
                this.documentsData.actionPriceDataGoldVo.ico = IconsTypes.GOLD;
                this.documentsData.actionPriceDataCreditsVo = new ActionPriceVO(param1.action);
                this.documentsData.actionPriceDataCreditsVo.ico = IconsTypes.CREDITS;
            }
            this.calculateMaxChars(this.documentsData.firstNames,this.documentsData,"firstNames");
            this.calculateMaxChars(this.documentsData.lastNames,this.documentsData,"lastNames");
            this.documentsData.icons = param1.icons;
            this.documentsData.userCredits = param1.money[0];
            this.documentsData.userGold = param1.money[1];
            if(param1.passportChangeCost is Array)
            {
                this.documentsData.priceOfGold = param1.passportChangeCost[0];
                this.documentsData.priceOfCredits = param1.passportChangeCost[1];
            }
            else if(param1.passportChangeCost is int)
            {
                this.documentsData.priceOfGold = param1.passportChangeCost;
                this.documentsData.useOnlyGold = true;
            }
            
            this.documentsData.currentTankmanFirstName = this.data.firstname;
            this.documentsData.currentTankmanLastName = this.data.lastname;
            this.documentsData.currentTankmanIcon = this.data.iconFile;
            if(!Extensions.isScaleform)
            {
                this.documentsData.currentTankmanFirstName = param1.firstnames[0].value;
                this.documentsData.currentTankmanLastName = param1.lastnames[0].value;
            }
            this.runtimeUpdateByModel(PersonalCaseDocs,this.documentsData);
            this.rentainingTabUpdated = true;
        }
        
        protected function parsePersonalCaseModel(param1:Object) : void
        {
            var _loc9_:PersonalCaseCurrentVehicle = null;
            var _loc2_:PersonalCaseModel = new PersonalCaseModel();
            var _loc3_:Object = param1.nativeVehicle;
            _loc2_.nativeVehicle.innationID = _loc3_.innationID;
            _loc2_.nativeVehicle.type = _loc3_.type;
            var _loc4_:Object = param1.tankman;
            _loc2_.inventoryID = _loc4_.inventoryID;
            _loc2_.inTank = _loc4_.isInTank;
            _loc2_.nationID = _loc4_.nationID;
            _loc2_.iconFile = _loc4_.icon.big;
            _loc2_.rankIconFile = _loc4_.iconRank.big;
            _loc2_.rank = _loc4_.rankUserName;
            var _loc5_:Object = _loc4_.nativeVehicle;
            var _loc6_:Object = _loc4_.currentVehicle;
            var _loc7_:Object = param1.currentVehicle;
            var _loc8_:Boolean = param1.isOpsLocked;
            _loc2_.nativeVehicle.userName = _loc5_.userName;
            _loc2_.nativeVehicle.contourIconFile = _loc5_.iconContour;
            _loc2_.nativeVehicle.icon = _loc5_.icon;
            _loc2_.firstname = _loc4_.firstUserName;
            _loc2_.lastname = _loc4_.lastUserName;
            if((param1.hasOwnProperty("currentVehicle")) && !(param1.currentVehicle == null))
            {
                _loc9_ = new PersonalCaseCurrentVehicle();
                _loc2_.currentVehicle = _loc9_;
                _loc9_.innationID = _loc7_.innationID;
                _loc9_.type = _loc7_.type;
                _loc9_.currentVehicleName = _loc6_.userName;
                _loc9_.inventoryID = _loc6_.inventoryID;
                _loc9_.iconContour = _loc6_.iconContour;
                _loc9_.icon = _loc6_.icon;
                _loc9_.currentVehicleBroken = _loc7_.isBroken;
                _loc9_.currentVehicleLocked = (_loc7_.isLocked) || (_loc8_);
                _loc9_.currentVehicleLockMessage = param1.lockMessage;
            }
            _loc2_.specializationLevel = _loc4_.roleLevel;
            _loc2_.skillsCountForLearn = _loc4_.newSkillsCount[0];
            _loc2_.lastNewSkillExp = _loc4_.newSkillsCount[1];
            _loc2_.skills = this.parseCarouselTankmanSkills(_loc4_.skills,_loc2_.skillsCountForLearn,_loc2_.lastNewSkillExp,_loc2_.inventoryID);
            _loc2_.roleType = _loc4_.roleName;
            _loc2_.role = _loc4_.roleUserName;
            _loc2_.modifiers = param1.modifiers;
            this.autoSelectTab = parseInt(param1.tabIndex);
            this.data = _loc2_;
        }
        
        protected function updateCommonElements() : void
        {
        }
        
        protected function runtimeUpdateByModel(param1:Class, param2:Object) : void
        {
        }
        
        private function parseCarouselTankmanSkills(param1:Array, param2:int, param3:int, param4:int) : Array
        {
            var _loc7_:CarouselTankmanSkillsModel = null;
            var _loc8_:Object = null;
            var _loc9_:CarouselTankmanSkillsModel = null;
            var _loc5_:Array = [];
            var _loc6_:* = 0;
            while(_loc6_ < param1.length)
            {
                _loc7_ = new CarouselTankmanSkillsModel();
                _loc8_ = param1[_loc6_];
                _loc7_.description = _loc8_.description;
                _loc7_.icon = _loc8_.icon.big;
                _loc7_.roleIcon = _loc8_.icon.role;
                _loc7_.isActive = _loc8_.isActive;
                _loc7_.isCommon = _loc8_.roleType == CarouselTankmanSkillsModel.ROLE_TYPE_COMMON;
                _loc7_.isPerk = _loc8_.isPerk;
                _loc7_.level = _loc8_.level;
                _loc7_.userName = _loc8_.userName;
                _loc7_.name = _loc8_.name;
                _loc7_.tankmanID = param4;
                _loc7_.enabled = _loc8_.isEnable;
                _loc5_.push(_loc7_);
                _loc6_++;
            }
            if(param2 > 0)
            {
                _loc9_ = new CarouselTankmanSkillsModel();
                _loc9_.isNewSkill = true;
                _loc9_.skillsCountForLearn = param2;
                _loc9_.tankmanID = param4;
                _loc5_.push(_loc9_);
            }
            return _loc5_;
        }
        
        private function calculateMaxChars(param1:Array, param2:PersonalCaseDocsModel, param3:String) : void
        {
            var _loc6_:uint = 0;
            var _loc4_:uint = param1.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
                _loc6_ = param1[_loc5_]["value"].length;
                if(param3 == "firstNames" && _loc6_ > param2.fistNameMaxChars)
                {
                    param2.fistNameMaxChars = _loc6_;
                }
                else if(param3 == "lastNames" && _loc6_ > param2.lastNameMaxChars)
                {
                    param2.lastNameMaxChars = _loc6_;
                }
                
                _loc5_++;
            }
        }
        
        private function createTestNames(param1:Array) : void
        {
            var _loc3_:Object = null;
            var _loc4_:* = 0;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            var _loc2_:* = 0;
            while(_loc2_ < param1.length)
            {
                _loc3_ = param1[_loc2_];
                _loc3_.value = "";
                _loc4_ = Math.random() * 6 + 4;
                _loc5_ = 0;
                while(_loc5_ < _loc4_)
                {
                    _loc6_ = Math.random() * templateS.length;
                    _loc3_.value = _loc3_.value + templateS[_loc6_];
                    _loc5_++;
                }
                _loc2_++;
            }
        }
    }
}
