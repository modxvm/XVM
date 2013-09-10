package net.wg.data.gui_items 
{
    import net.wg.data.constants.*;
    
    public class VehicleProfile extends net.wg.data.gui_items.Vehicle
    {
        public function VehicleProfile(arg1:int)
        {
            super(arg1);
            return;
        }

        public function get battlesCount():int
        {
            return this._battlesCount;
        }

        public function get wins():int
        {
            return this._wins;
        }

        public function get markOfMastery():int
        {
            return this._markOfMastery;
        }

        public function set markOfMastery(arg1:int):void
        {
            this._markOfMastery = arg1;
            return;
        }

        public function set battlesCount(arg1:int):void
        {
            this._battlesCount = arg1;
            return;
        }

        public function set wins(arg1:int):void
        {
            this._wins = arg1;
            return;
        }

        public function get smallIconPath():String
        {
            return "../maps/icons/vehicle/small/" + name.replace(":", "-") + ".png";
        }

        public function get typeIconPath():String
        {
            return "../maps/icons/filters/tanks/" + type + ".png";
        }

        public function get masteryIconPath():String
        {
            if (this._markOfMastery > 0) 
            {
                return "../maps/icons/achievement/markOfMastery" + this._markOfMastery + ".png";
            }
            return null;
        }

        public function get nationIconPath():String
        {
            var loc1:*=[net.wg.data.constants.Nations.USSR, net.wg.data.constants.Nations.GERMANY, net.wg.data.constants.Nations.USA, net.wg.data.constants.Nations.CHINA, net.wg.data.constants.Nations.FRANCE, net.wg.data.constants.Nations.UK];
            return "../maps/icons/filters/nations/" + loc1[nationID] + ".png";
        }

        public function get avgExperience():int
        {
            return this._avgExperience;
        }

        public function set avgExperience(arg1:int):void
        {
            this._avgExperience = arg1;
            return;
        }

        public function get winsEfficiency():Number
        {
            return this._winsEfficiency;
        }

        public function set winsEfficiency(arg1:Number):void
        {
            this._winsEfficiency = arg1;
            this.winsEfficiencyStr = net.wg.data.gui_items.ItemsUtils.formatIntegerStr(arg1) + "%";
            return;
        }

        public function get winsEfficiencyStr():String
        {
            return this._winsEfficiencyStr;
        }

        public function set winsEfficiencyStr(arg1:String):void
        {
            this._winsEfficiencyStr = arg1;
            return;
        }

        internal var _markOfMastery:int;

        internal var _battlesCount:int;

        internal var _wins:int;

        internal var _winsEfficiency:Number;

        internal var _winsEfficiencyStr:String;

        internal var _avgExperience:int=0;
    }
}
