package net.wg.data.VO
{
    public class TankmanAchievementVO extends AchievementCounterVO
    {
        
        public function TankmanAchievementVO(param1:Object)
        {
            super(param1);
        }
        
        private var _showSeparator:Boolean = false;
        
        public function get showSeparator() : Boolean
        {
            return this._showSeparator;
        }
        
        public function set showSeparator(param1:Boolean) : void
        {
            this._showSeparator = param1;
        }
    }
}
