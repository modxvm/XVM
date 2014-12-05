package net.wg.data.VO
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class AwardWindowVO extends DAAPIDataClass
    {
        
        public function AwardWindowVO(param1:Object)
        {
            super(param1);
        }
        
        private static var FIELD_ACHIEVEMENTS:String = "achievements";
        
        public var backImage:String = "";
        
        public var awardImage:String = "";
        
        public var windowTitle:String = "";
        
        public var header:String = "";
        
        public var description:String = "";
        
        public var additionalText:String = "";
        
        public var buttonText:String = "";
        
        public var achievements:Array = null;
        
        public function get hasAchievements() : Boolean
        {
            return (this.achievements) && this.achievements.length > 0;
        }
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:AchievementItemVO = null;
            if(param1 == FIELD_ACHIEVEMENTS)
            {
                this.achievements = [];
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    _loc5_ = _loc4_?new AchievementItemVO(_loc4_):null;
                    this.achievements.push(_loc5_);
                }
                return false;
            }
            return true;
        }
        
        override protected function onDispose() : void
        {
            this.disposeAchievements();
            super.onDispose();
        }
        
        private function disposeAchievements() : void
        {
            var _loc1_:AchievementItemVO = null;
            if(this.achievements)
            {
                for each(_loc1_ in this.achievements)
                {
                    if(_loc1_)
                    {
                        _loc1_.dispose();
                    }
                }
                this.achievements.splice(0);
                this.achievements = null;
            }
        }
    }
}
