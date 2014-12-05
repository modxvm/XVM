package net.wg.data.VO
{
    import net.wg.gui.lobby.profile.data.ProgressSimpleInfo;
    
    public class AchievementProgressVO extends AchievementCounterVO
    {
        
        public function AchievementProgressVO(param1:Object)
        {
            super(param1);
        }
        
        public var progress:Array;
        
        private var _progressInfo:ProgressSimpleInfo;
        
        public function get progressInfo() : ProgressSimpleInfo
        {
            return this._progressInfo;
        }
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == "progress" && (param2))
            {
                this.progress = param2 as Array;
                this._progressInfo = new ProgressSimpleInfo(this.progress[0],this.progress[1],this.progress[2]);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
    }
}
