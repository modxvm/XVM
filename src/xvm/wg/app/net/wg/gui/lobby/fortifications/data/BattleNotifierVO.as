package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class BattleNotifierVO extends DAAPIDataClass
    {
        
        public function BattleNotifierVO(param1:Object)
        {
            super(param1);
        }
        
        private var _battleType:String = "";
        
        private var _hasActiveBattles:Boolean = false;
        
        private var _tooltip:String = "";
        
        private var _direction:int = -1;
        
        public function get battleType() : String
        {
            return this._battleType;
        }
        
        public function set battleType(param1:String) : void
        {
            this._battleType = param1;
        }
        
        public function get hasActiveBattles() : Boolean
        {
            return this._hasActiveBattles;
        }
        
        public function set hasActiveBattles(param1:Boolean) : void
        {
            this._hasActiveBattles = param1;
        }
        
        public function get tooltip() : String
        {
            return this._tooltip;
        }
        
        public function set tooltip(param1:String) : void
        {
            this._tooltip = param1;
        }
        
        public function get direction() : int
        {
            return this._direction;
        }
        
        public function set direction(param1:int) : void
        {
            this._direction = param1;
        }
    }
}
