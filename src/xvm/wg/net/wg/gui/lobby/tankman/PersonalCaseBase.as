package net.wg.gui.lobby.tankman 
{
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.gfx.*;
    
    public class PersonalCaseBase extends net.wg.infrastructure.base.meta.impl.PersonalCaseMeta implements net.wg.infrastructure.base.meta.IPersonalCaseMeta
    {
        public function PersonalCaseBase()
        {
            this.skillsModel = [];
            super();
            return;
        }

        public function as_setCommonData(arg1:Object):void
        {
            this.parsePersonalCaseModel(arg1);
            this.updateCommonElements();
            return;
        }

        public function as_setDossierData(arg1:Object):void
        {
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=null;
            var loc1:*=[];
            var loc2:*=arg1.achievements.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc5 = (loc4 = arg1.achievements[loc3]).length;
                loc6 = 0;
                while (loc6 < loc5) 
                {
                    loc7 = new net.wg.data.VO.AchievementItemVO(loc4[loc6]);
                    loc1.push(loc7);
                    ++loc6;
                }
                if (loc3 < (loc2 - 1) && loc1.length > 0) 
                    loc1[(loc1.length - 1)].showSeparator = true;
                ++loc3;
            }
            if (loc1.length > 0) 
                loc1[(loc1.length - 1)].showSeparator = false;
            this.stats = {};
            this.stats.achievements = loc1;
            this.stats.stats = arg1.stats;
            this.runtimeUpdateByModel(net.wg.gui.lobby.tankman.PersonalCaseStats, this.stats);
            return;
        }

        public function as_setRetrainingData(arg1:Object):void
        {
            var loc3:*=null;
            this.retrainingData = new net.wg.gui.lobby.tankman.PersonalCaseRetrainingModel();
            this.retrainingData.credits = arg1.money[0];
            this.retrainingData.gold = arg1.money[1];
            this.retrainingData.tankmanCost = arg1.tankmanCost;
            this.retrainingData.vehicles = arg1.vehicles;
            this.retrainingData.testData = this.data;
            this.retrainingData.testStats = this.stats;
            var loc1:*=arg1.vehicles;
            var loc2:*=0;
            while (loc2 < loc1.length) 
            {
                loc3 = loc1[loc2];
                var loc4:*=loc3.vehicleType;
                switch (loc4) 
                {
                    case net.wg.data.constants.VehicleTypes.LIGHT_TANK:
                        this.retrainingData.lightTanks.push(loc3);
                        break;
                    case net.wg.data.constants.VehicleTypes.MEDIUM_TANK:
                        this.retrainingData.mediumTanks.push(loc3);
                        break;
                    case net.wg.data.constants.VehicleTypes.HEAVY_TANK:
                        this.retrainingData.heavyTanks.push(loc3);
                        break;
                    case net.wg.data.constants.VehicleTypes.AT_SPG:
                        this.retrainingData.AT_SPG.push(loc3);
                        break;
                    case net.wg.data.constants.VehicleTypes.SPG:
                        this.retrainingData.SPG.push(loc3);
                        break;
                    default:
                        DebugUtils.LOG_DEBUG("ERROR unknown tank type");
                        break;
                }
                ++loc2;
            }
            this.retrainingData.nationID = this.data.nationID;
            this.retrainingData.tankmanID = this.data.inventoryID;
            this.retrainingData.currentVehicle = this.data.currentVehicle;
            this.retrainingData.nativeVehicle = this.data.nativeVehicle;
            this.retrainingData.specializationLevel = parseInt(this.data.specializationLevel);
            this.runtimeUpdateByModel(net.wg.gui.lobby.tankman.CrewTankmanRetraining, this.retrainingData);
            return;
        }

        public function as_setSkillsData(arg1:Array):void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=null;
            this.skillsModel = [];
            var loc1:*=false;
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                if (!(!arg1[loc2].hasOwnProperty("skills") || !arg1[loc2].skills is Array || arg1[loc2].skills.length <= 0)) 
                {
                    loc3 = new net.wg.gui.lobby.tankman.PersonalCaseSkillsModel();
                    loc4 = arg1[loc2].id;
                    loc3.rankId = loc4;
                    loc3.title = arg1[loc2].id;
                    loc3.isHeader = true;
                    loc3.selfSkill = this.data.roleType == loc4;
                    this.skillsModel.push(loc3);
                    if (arg1[loc2].hasOwnProperty("skills") && arg1[loc2].skills is Array) 
                    {
                        loc5 = 0;
                        while (loc5 < arg1[loc2].skills.length) 
                        {
                            loc3 = new net.wg.gui.lobby.tankman.PersonalCaseSkillsModel();
                            loc6 = arg1[loc2].skills[loc5];
                            loc3.title = loc6.id;
                            loc3.isHeader = false;
                            loc3.desc = loc6.desc;
                            loc3.enabled = loc6.enabled;
                            loc3.name = loc6.name;
                            loc3.tankmanID = loc6.tankmanID;
                            loc3.rankId = loc4;
                            loc3.selfSkill = this.data.roleType == loc4;
                            loc3.hasNewSkills = this.data.skillsCountForLearn > 0;
                            this.skillsModel.push(loc3);
                            loc1 = false;
                            ++loc5;
                        }
                    }
                    else 
                        DebugUtils.LOG_DEBUG("ERROR :: not found skills in the title : " + loc3.title);
                }
                ++loc2;
            }
            if (loc1) 
                this.skillsModel = [];
            this.runtimeUpdateByModel(net.wg.gui.lobby.tankman.PersonalCaseSkills, this.skillsModel);
            return;
        }

        public function as_setDocumentsData(arg1:Object):void
        {
            this.documentsData = new net.wg.gui.lobby.tankman.PersonalCaseDocsModel();
            if (!scaleform.gfx.Extensions.isScaleform) 
            {
                this.createTestNames(arg1.firstnames);
                this.createTestNames(arg1.lastnames);
            }
            this.documentsData.originalIconFile = this.data.iconFile;
            this.documentsData.firstNames = arg1.firstnames;
            this.documentsData.lastNames = arg1.lastnames;
            this.calculateMaxChars(this.documentsData.firstNames, this.documentsData, "firstNames");
            this.calculateMaxChars(this.documentsData.lastNames, this.documentsData, "lastNames");
            this.documentsData.icons = arg1.icons;
            this.documentsData.userCredits = arg1.money[0];
            this.documentsData.userGold = arg1.money[1];
            if (arg1.passportChangeCost is Array) 
            {
                this.documentsData.priceOfGold = arg1.passportChangeCost[0];
                this.documentsData.priveOfCredits = arg1.passportChangeCost[1];
            }
            else if (arg1.passportChangeCost is int) 
            {
                this.documentsData.priceOfGold = arg1.passportChangeCost;
                this.documentsData.useOnlyGold = true;
            }
            this.documentsData.currentTankmanFirstName = this.data.firstname;
            this.documentsData.currentTankmanLastName = this.data.lastname;
            this.documentsData.currentTankmanIcon = this.data.iconFile;
            if (!scaleform.gfx.Extensions.isScaleform) 
            {
                this.documentsData.currentTankmanFirstName = arg1.firstnames[0].value;
                this.documentsData.currentTankmanLastName = arg1.lastnames[0].value;
            }
            this.runtimeUpdateByModel(net.wg.gui.lobby.tankman.PersonalCaseDocs, this.documentsData);
            this.rentainingTabUpdated = true;
            return;
        }

        protected function parsePersonalCaseModel(arg1:Object):void
        {
            var loc7:*=null;
            var loc1:*=new net.wg.gui.lobby.tankman.PersonalCaseModel();
            var loc2:*=arg1.nativeVehicle;
            loc1.nativeVehicle.innationID = loc2.innationID;
            loc1.nativeVehicle.type = loc2.type;
            var loc3:*=arg1.tankman;
            loc1.inventoryID = loc3.inventoryID;
            loc1.inTank = loc3.isInTank;
            loc1.nationID = loc3.nationID;
            loc1.iconFile = loc3.icon.big;
            loc1.rankIconFile = loc3.iconRank.big;
            loc1.rank = loc3.rankUserName;
            var loc4:*=loc3.nativeVehicle;
            var loc5:*=loc3.currentVehicle;
            var loc6:*=arg1.currentVehicle;
            loc1.nativeVehicle.userName = loc4.userName;
            loc1.nativeVehicle.contourIconFile = loc4.iconContour;
            loc1.nativeVehicle.icon = loc4.icon;
            loc1.firstname = loc3.firstUserName;
            loc1.lastname = loc3.lastUserName;
            if (arg1.hasOwnProperty("currentVehicle") && !(arg1.currentVehicle == null)) 
            {
                loc7 = new net.wg.gui.lobby.tankman.PersonalCaseCurrentVehicle();
                loc1.currentVehicle = loc7;
                loc7.innationID = loc6.innationID;
                loc7.type = loc6.type;
                loc7.currentVehicleName = loc5.userName;
                loc7.inventoryID = loc5.inventoryID;
                loc7.iconContour = loc5.iconContour;
                loc7.icon = loc5.icon;
                loc7.currentVehicleBroken = loc6.isBroken;
                loc7.currentVehicleLocked = loc6.isLocked;
                loc7.currentVehicleLockMessage = arg1.lockMessage;
            }
            loc1.specializationLevel = loc3.roleLevel;
            loc1.skillsCountForLearn = loc3.newSkillsCount[0];
            loc1.lastNewSkillExp = loc3.newSkillsCount[1];
            loc1.skills = this.parseCarouselTankmanSkills(loc3.skills, loc1.skillsCountForLearn, loc1.lastNewSkillExp, loc1.inventoryID);
            loc1.roleType = loc3.roleName;
            loc1.role = loc3.roleUserName;
            this.autoSelectTab = parseInt(arg1.tabIndex);
            this.data = loc1;
            return;
        }

        protected function updateCommonElements():void
        {
            return;
        }

        protected function runtimeUpdateByModel(arg1:Class, arg2:Object):void
        {
            return;
        }

        internal function parseCarouselTankmanSkills(arg1:Array, arg2:int, arg3:int, arg4:int):Array
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc1:*=[];
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                loc3 = new net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel();
                loc4 = arg1[loc2];
                loc3.description = loc4.description;
                loc3.icon = loc4.icon.big;
                loc3.roleIcon = loc4.icon.role;
                loc3.isActive = loc4.isActive;
                loc3.isCommon = loc4.roleType == net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel.ROLE_TYPE_COMMON;
                loc3.roleType = loc4.roleType;
                loc3.isPerk = loc4.isPerk;
                loc3.level = loc4.level;
                loc3.userName = loc4.userName;
                loc3.name = loc4.name;
                loc3.tankmanID = arg4;
                loc3.enabled = loc4.isEnable;
                loc1.push(loc3);
                ++loc2;
            }
            if (arg2 > 0) 
            {
                (loc5 = new net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel()).isNewSkill = true;
                loc5.skillsCountForLearn = arg2;
                loc5.tankmanID = arg4;
                loc1.push(loc5);
            }
            return loc1;
        }

        internal function calculateMaxChars(arg1:Array, arg2:net.wg.gui.lobby.tankman.PersonalCaseDocsModel, arg3:String):void
        {
            var loc3:*=0;
            var loc1:*=arg1.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = arg1[loc2]["value"].length;
                if (arg3 == "firstNames" && loc3 > arg2.fistNameMaxChars) 
                    arg2.fistNameMaxChars = loc3;
                else if (arg3 == "lastNames" && loc3 > arg2.lastNameMaxChars) 
                    arg2.lastNameMaxChars = loc3;
                ++loc2;
            }
            return;
        }

        internal function createTestNames(arg1:Array):void
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc1:*=0;
            while (loc1 < arg1.length) 
            {
                loc2 = arg1[loc1];
                loc2.value = "";
                loc3 = Math.random() * 6 + 4;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    loc5 = Math.random() * templateS.length;
                    loc2.value = loc2.value + templateS[loc5];
                    ++loc4;
                }
                ++loc1;
            }
            return;
        }

        internal static const templateS:Array=["a", "b", "c", "d", "a", "b", "c", "d", "a1", "b2", "c3", "d4", "a5", "b6", "c7", "d8", "az", "xb", "cc", "fd", "ga", "tb", "jc", "dg"];

        protected var isFirtsRun:Boolean=true;

        protected var autoSelectTab:int=0;

        protected var data:net.wg.gui.lobby.tankman.PersonalCaseModel;

        protected var stats:Object;

        protected var retrainingData:net.wg.gui.lobby.tankman.PersonalCaseRetrainingModel;

        protected var skillsModel:Array;

        protected var documentsData:net.wg.gui.lobby.tankman.PersonalCaseDocsModel;

        protected var rentainingTabUpdated:Boolean=true;
    }
}
