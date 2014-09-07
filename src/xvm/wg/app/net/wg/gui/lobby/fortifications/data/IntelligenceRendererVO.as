package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class IntelligenceRendererVO extends DAAPIDataClass
    {
        
        public function IntelligenceRendererVO(param1:Object)
        {
            super(param1);
        }
        
        private var _levelIcon:String = "";
        
        private var _clanTag:String = "";
        
        private var _defenceTime:String = "";
        
        private var _avgBuildingLvl:Number = -1;
        
        private var _availability:String = "";
        
        private var _availabilityDays:int = -1;
        
        private var _clanID:Number = -1;
        
        private var _isFavorite:Boolean = false;
        
        private var _clanLvl:int = -1;
        
        private var _defenceStartTime:int = -1;
        
        public function get levelIcon() : String
        {
            return this._levelIcon;
        }
        
        public function set levelIcon(param1:String) : void
        {
            this._levelIcon = param1;
        }
        
        public function get clanTag() : String
        {
            return this._clanTag;
        }
        
        public function set clanTag(param1:String) : void
        {
            this._clanTag = param1;
        }
        
        public function get defenceTime() : String
        {
            return this._defenceTime;
        }
        
        public function set defenceTime(param1:String) : void
        {
            this._defenceTime = param1;
        }
        
        public function get avgBuildingLvl() : Number
        {
            return this._avgBuildingLvl;
        }
        
        public function set avgBuildingLvl(param1:Number) : void
        {
            this._avgBuildingLvl = param1;
        }
        
        public function get availability() : String
        {
            return this._availability;
        }
        
        public function set availability(param1:String) : void
        {
            this._availability = param1;
        }
        
        public function get isFavorite() : Boolean
        {
            return this._isFavorite;
        }
        
        public function set isFavorite(param1:Boolean) : void
        {
            this._isFavorite = param1;
        }
        
        public function get clanID() : Number
        {
            return this._clanID;
        }
        
        public function set clanID(param1:Number) : void
        {
            this._clanID = param1;
        }
        
        public function get clanLvl() : int
        {
            return this._clanLvl;
        }
        
        public function set clanLvl(param1:int) : void
        {
            this._clanLvl = param1;
        }
        
        public function get defenceStartTime() : int
        {
            return this._defenceStartTime;
        }
        
        public function set defenceStartTime(param1:int) : void
        {
            this._defenceStartTime = param1;
        }
        
        public function get availabilityDays() : int
        {
            return this._availabilityDays;
        }
        
        public function set availabilityDays(param1:int) : void
        {
            this._availabilityDays = param1;
        }
    }
}
