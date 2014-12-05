package net.wg.data.VO
{
    import net.wg.gui.lobby.questsWindow.data.SubtaskVO;
    import net.wg.gui.lobby.questsWindow.data.PersonalInfoVO;
    import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
    
    public class BattleResultsQuestVO extends SubtaskVO
    {
        
        public function BattleResultsQuestVO(param1:Object)
        {
            this._awards = [];
            this._progressList = [];
            super(param1);
        }
        
        public var questType:int = -1;
        
        public var personalInfo:Vector.<PersonalInfoVO> = null;
        
        private var _awards:Array;
        
        private var _progressList:Array;
        
        private var _alertMsg:String = "";
        
        public function get progressList() : Array
        {
            return this._progressList;
        }
        
        public function set progressList(param1:Array) : void
        {
            this._progressList = param1;
        }
        
        public function get alertMsg() : String
        {
            return this._alertMsg;
        }
        
        public function set alertMsg(param1:String) : void
        {
            this._alertMsg = param1;
        }
        
        public function get awards() : Array
        {
            return this._awards;
        }
        
        public function set awards(param1:Array) : void
        {
            this._awards = param1;
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:PersonalInfoVO = null;
            if(this.personalInfo)
            {
                for each(_loc1_ in this.personalInfo)
                {
                    _loc1_.dispose();
                }
                this.personalInfo.splice(0,this.personalInfo.length);
                this.personalInfo = null;
            }
            super.onDispose();
        }
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            switch(param1)
            {
                case "questInfo":
                    questInfo = new QuestRendererVO(param2?param2:{});
                    return false;
                case "personalInfo":
                    this.personalInfo = this.preparePersonalQuests(param2);
                    return false;
                default:
                    return true;
            }
        }
        
        private function preparePersonalQuests(param1:Object = null) : Vector.<PersonalInfoVO>
        {
            var _loc4_:Object = null;
            if(!param1)
            {
                return null;
            }
            var _loc2_:Vector.<PersonalInfoVO> = new Vector.<PersonalInfoVO>(0);
            var _loc3_:Array = param1 as Array;
            for each(_loc4_ in _loc3_)
            {
                _loc2_.push(new PersonalInfoVO(_loc4_));
            }
            return _loc2_;
        }
    }
}
