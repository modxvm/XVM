package net.wg.gui.lobby.quests.data.questsTileChains
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class QuestTaskDetailsVO extends DAAPIDataClass
    {
        
        public function QuestTaskDetailsVO(param1:Object)
        {
            this.awards = [];
            super(param1);
        }
        
        public var taskID:Number = -1;
        
        public var headerText:String = "";
        
        public var conditionsText:String = "";
        
        public var isApplyBtnVisible:Boolean = false;
        
        public var isApplyBtnEnabled:Boolean = false;
        
        public var isCancelBtnVisible:Boolean = false;
        
        public var btnLabel:String = "";
        
        public var btnToolTip:String = "";
        
        public var taskDescriptionText:String = "";
        
        public var awards:Array;
        
        override protected function onDispose() : void
        {
            if(this.awards)
            {
                this.awards.splice(0,this.awards.length);
                this.awards = null;
            }
            super.onDispose();
        }
    }
}
