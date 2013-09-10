package net.wg.data.gui_items.dossier 
{
    import net.wg.data.gui_items.*;
    import net.wg.gui.lobby.profile.data.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    
    public class Dossier extends net.wg.data.gui_items.GUIItem
    {
        public function Dossier(arg1:uint, arg2:*)
        {
            super(arg1, arg2);
            return;
        }

        public function getAchievements(arg1:Boolean=true):Array
        {
            return this.getAchievement2DimVector(_callMethod("getAchievements", arg1) as Array);
        }

        public function getAllAchievements():Array
        {
            return this.getAchievement2DimVector(_callMethod("getAchievements", null) as Array);
        }

        internal function getAchievement2DimVector(arg1:Array):Array
        {
            var loc1:*=[];
            var loc2:*=arg1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1.push(getAchievementVector(arg1[loc3]));
                ++loc3;
            }
            return loc1;
        }

        public function getSignificantAchievements():Array
        {
            return getAchievementVector(_callMethod("getSignificantAchievements") as Array);
        }

        public function getNearestAchievements():Array
        {
            return getAchievementVector(_callMethod("getNearestAchievements") as Array);
        }

        public function getGlobalRating():int
        {
            return int(_callMethod("getGlobalRating"));
        }

        public function getGlobalRatingStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getGlobalRating());
        }

        public function getMarksOfMastery():Array
        {
            return _callMethod("getMarksOfMastery") as Array;
        }

        public function getSpecifiedMarksOfMastery(arg1:uint):uint
        {
            var loc1:*=this.getMarksOfMastery();
            return loc1[(arg1 - 1)];
        }

        public function getSpecifiedMarksOfMasteryStr(arg1:uint):String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getSpecifiedMarksOfMastery(arg1));
        }

        public function getBattlesStats():Array
        {
            return _callMethod("getBattlesStats") as Array;
        }

        public function getBattlesCount():uint
        {
            return uint(_callMethod("getBattlesCount"));
        }

        public function getWinsCount():uint
        {
            return uint(_callMethod("getWinsCount"));
        }

        public function getSurvivedBattlesCount():uint
        {
            return uint(_callMethod("getSurvivedBattlesCount"));
        }

        public function getXP():uint
        {
            return uint(_callMethod("getXP"));
        }

        public function getDamageDealt():uint
        {
            return uint(_callMethod("getDamageDealt"));
        }

        public function getDamageReceived():uint
        {
            return uint(_callMethod("getDamageReceived"));
        }

        public function getShotsCount():uint
        {
            return uint(_callMethod("getShotsCount"));
        }

        public function getHitsCount():uint
        {
            return uint(_callMethod("getHitsCount"));
        }

        public function getFragsCount():uint
        {
            return uint(_callMethod("getFragsCount"));
        }

        public function getDeathsCount():uint
        {
            return uint(_callMethod("getDeathsCount"));
        }

        public function getMaxFrags():Array
        {
            return _callMethod("getMaxFrags") as Array;
        }

        public function getMaxFragsStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getMaxFrags()[0]);
        }

        public function getMaxFragsVehicleDescr():*
        {
            return this.getMaxFrags()[1];
        }

        public function getMaxXP():Array
        {
            return _callMethod("getMaxXP") as Array;
        }

        public function getMaxXPVehicleDescr():*
        {
            return this.getMaxXP()[1];
        }

        public function getMaxXPStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getMaxXP()[0]);
        }

        public function getMaxVehicleFrags():Number
        {
            return Number(_callMethod("getMaxVehicleFrags"));
        }

        public function getMaxVehicleXP():Number
        {
            return Number(_callMethod("getMaxVehicleXP"));
        }

        public function getSpottedEnemiesCount():uint
        {
            return uint(_callMethod("getSpottedEnemiesCount"));
        }

        public function getAvgDamage():Number
        {
            return Number(_callMethod("getAvgDamage"));
        }

        public function getAvgDamageStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getAvgDamage());
        }

        public function getAvgXP():Number
        {
            return Number(_callMethod("getAvgXP"));
        }

        public function getAvgXPStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getAvgXP());
        }

        public function getAvgFrags():Number
        {
            return Number(_callMethod("getAvgFrags"));
        }

        public function getAvgFragsStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatFloatStr(this.getAvgFrags());
        }

        public function getAvgDamageDealt():Number
        {
            return Number(_callMethod("getAvgDamageDealt"));
        }

        public function getAvgDamageDealtStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getAvgDamageDealt());
        }

        public function getAvgDamageReceived():Number
        {
            return Number(_callMethod("getAvgDamageReceived"));
        }

        public function getAvgEnemiesSpotted():Number
        {
            return Number(_callMethod("getAvgEnemiesSpotted"));
        }

        public function getAvgEnemiesSpottedStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatFloatStr(this.getAvgEnemiesSpotted());
        }

        public function getHitsEfficiency():Number
        {
            return Number(_callMethod("getHitsEfficiency"));
        }

        public function getHitsEfficiencyStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.floatToPercent(this.getHitsEfficiency());
        }

        public function getSurvivalEfficiency():Number
        {
            return Number(_callMethod("getSurvivalEfficiency"));
        }

        public function getWinsEfficiency():Number
        {
            return Number(_callMethod("getWinsEfficiency"));
        }

        public function getSurvivalEfficiencyStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.floatToPercent(this.getSurvivalEfficiency());
        }

        public function getLossesEfficiency():Number
        {
            return Number(_callMethod("getLossesEfficiency"));
        }

        public function getFragsEfficiency():Number
        {
            return Number(_callMethod("getFragsEfficiency"));
        }

        public function getFragsEfficiencyStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatFloatStr(this.getFragsEfficiency());
        }

        public function getDamageEfficiency():Number
        {
            return Number(_callMethod("getDamageEfficiency"));
        }

        public function getDamageEfficiencyStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatFloatStr(this.getDamageEfficiency());
        }

        public function getAvgDamageReceivedStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getAvgDamageReceived());
        }

        public function getDeathsCountStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getDeathsCount());
        }

        public function getMaxVehicleFragsStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getMaxVehicleFrags());
        }

        public function getMaxVehicleXPStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getMaxVehicleXP());
        }

        public function getBattlesCountStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getBattlesCount());
        }

        public function getDamageDealtStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getDamageDealt());
        }

        public function getDamageReceivedStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getDamageReceived());
        }

        public function getWinsCountStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getWinsCount());
        }

        public function getFragsCountStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getFragsCount());
        }

        public function getWinsEfficiencyStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.floatToPercent(this.getWinsEfficiency());
        }

        public function getVehicles():Object
        {
            return _callMethod("getVehicles");
        }

        public function getVehiclesCount():uint
        {
            var loc3:*=null;
            var loc1:*=this.getVehicles();
            var loc2:*=0;
            var loc4:*=0;
            var loc5:*=loc1;
            for each (loc3 in loc5) 
            {
                ++loc2;
            }
            return loc2;
        }

        public function getVehiclesCountStr():String
        {
            return net.wg.data.gui_items.ItemsUtils.formatIntegerStr(this.getVehiclesCount());
        }

        internal function getTechniqueListVehicles():Array
        {
            return _callMethod("getTechniqueListVehicles") as Array;
        }

        public function getHangarVehiclesList():Array
        {
            return generateVehiclesList(this.getTechniqueListVehicles(), true);
        }

        public function getAllVehiclesList():Array
        {
            return generateVehiclesList(this.getTechniqueListVehicles());
        }

        internal static function getAchievementVector(arg1:Array):Array
        {
            var loc2:*=null;
            var loc1:*=[];
            var loc3:*=0;
            var loc4:*=arg1;
            for each (loc2 in loc4) 
            {
                loc1.push(new net.wg.gui.lobby.profile.data.ProfileAchievementVO(loc2));
            }
            return loc1;
        }

        internal static function generateVehiclesList(arg1:Array, arg2:Boolean=false):Array
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=[];
            var loc5:*=0;
            var loc6:*=arg1;
            for each (loc4 in loc6) 
            {
                loc2 = new net.wg.gui.lobby.profile.pages.technique.TechniqueListVehicleVO(loc4);
                if (arg2) 
                {
                    if (!loc2.isInHangar) 
                    {
                        continue;
                    }
                }
                loc1.push(loc2);
            }
            return loc1;
        }
    }
}
