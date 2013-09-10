package net.wg.gui.lobby.profile.pages.technique 
{
    import net.wg.data.daapi.base.*;
    
    public class TechniqueStatisticVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function TechniqueStatisticVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function set totalDead(arg1:String):void
        {
            this._totalDead = arg1;
            return;
        }

        public function get killRatio():String
        {
            return this._killRatio;
        }

        public function set killRatio(arg1:String):void
        {
            this._killRatio = arg1;
            return;
        }

        public function get dealtDmg():String
        {
            return this._dealtDmg;
        }

        public function set dealtDmg(arg1:String):void
        {
            this._dealtDmg = arg1;
            return;
        }

        public function get receivedDmg():String
        {
            return this._receivedDmg;
        }

        public function set receivedDmg(arg1:String):void
        {
            this._receivedDmg = arg1;
            return;
        }

        public function get survive():String
        {
            return this._survive;
        }

        public function get dmgRatio():String
        {
            return this._dmgRatio;
        }

        public function set dmgRatio(arg1:String):void
        {
            this._dmgRatio = arg1;
            return;
        }

        public function get avgExp():String
        {
            return this._avgExp;
        }

        public function set avgExp(arg1:String):void
        {
            this._avgExp = arg1;
            return;
        }

        public function get avgKills():String
        {
            return this._avgKills;
        }

        public function get avgDetected():String
        {
            return this._avgDetected;
        }

        public function set avgDetected(arg1:String):void
        {
            this._avgDetected = arg1;
            return;
        }

        public function get avgDmgDealt():String
        {
            return this._avgDmgDealt;
        }

        public function set avgDmgDealt(arg1:String):void
        {
            this._avgDmgDealt = arg1;
            return;
        }

        public function get avgDmgReceived():String
        {
            return this._avgDmgReceived;
        }

        public function set avgDmgReceived(arg1:String):void
        {
            this._avgDmgReceived = arg1;
            return;
        }

        public function get avgBonusDmg():String
        {
            return this._avgBonusDmg;
        }

        public function set avgBonusDmg(arg1:String):void
        {
            this._avgBonusDmg = arg1;
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            this._type = arg1;
            return;
        }

        public function get vName():String
        {
            return this._vName;
        }

        public function set vName(arg1:String):void
        {
            this._vName = arg1;
            return;
        }

        public function get battles():String
        {
            return this._battles;
        }

        public function set battles(arg1:String):void
        {
            this._battles = arg1;
            return;
        }

        public function get wins():String
        {
            return this._wins;
        }

        public function set wins(arg1:String):void
        {
            this._wins = arg1;
            return;
        }

        public function get defeats():String
        {
            return this._defeats;
        }

        public function set defeats(arg1:String):void
        {
            this._defeats = arg1;
            return;
        }

        public function set avgKills(arg1:String):void
        {
            this._avgKills = arg1;
            return;
        }

        public function set survive(arg1:String):void
        {
            this._survive = arg1;
            return;
        }

        public function get accuracy():String
        {
            return this._accuracy;
        }

        public function set accuracy(arg1:String):void
        {
            this._accuracy = arg1;
            return;
        }

        public function get maxExp():String
        {
            return this._maxExp;
        }

        public function set maxExp(arg1:String):void
        {
            this._maxExp = arg1;
            return;
        }

        public function get maxKill():String
        {
            return this._maxKill;
        }

        public function set maxKill(arg1:String):void
        {
            this._maxKill = arg1;
            return;
        }

        public function get totalKill():String
        {
            return this._totalKill;
        }

        public function set totalKill(arg1:String):void
        {
            this._totalKill = arg1;
            return;
        }

        public function get totalDead():String
        {
            return this._totalDead;
        }

        internal var _type:String="";

        internal var _vName:String="";

        internal var _battles:String="";

        internal var _wins:String="";

        internal var _defeats:String="";

        internal var _survive:String="";

        internal var _accuracy:String="";

        internal var _maxKill:String="";

        internal var _totalKill:String="";

        internal var _totalDead:String="";

        internal var _killRatio:String="";

        internal var _dealtDmg:String="";

        internal var _receivedDmg:String="";

        internal var _dmgRatio:String="";

        internal var _avgExp:String="";

        internal var _avgKills:String="";

        internal var _avgDetected:String="";

        internal var _avgDmgDealt:String="";

        internal var _avgDmgReceived:String="";

        internal var _avgBonusDmg:String="";

        internal var _maxExp:String="";
    }
}
