package net.wg.gui.lobby.quests.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class ChainProgressVO extends DAAPIDataClass
    {
        
        public function ChainProgressVO(param1:Object)
        {
            this.progressItems = [];
            super(param1);
        }
        
        private static var PROGRESS_ITEMS:String = "progressItems";
        
        public var headerText:String = "";
        
        public var mainAwardText:String = "";
        
        public var progressText:String = "";
        
        public var awardNameText:String = "";
        
        public var chainsProgressText:String = "";
        
        public var awardIconSource:String = "";
        
        public var aboutTankBtnLabel:String = "";
        
        public var showInHangarBtnLabel:String = "";
        
        public var progressTFToolTip:String = "";
        
        public var aboutVehicleToolTip:String = "";
        
        public var showVehicleToolTip:String = "";
        
        public var isAlreadyCompleted:Boolean = false;
        
        public var progressItems:Array;
        
        public var awardVehicleID:Number = -1;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == PROGRESS_ITEMS)
            {
                _loc3_ = param2 as Array;
                for each(_loc4_ in _loc3_)
                {
                    (this[param1] as Array).push(new ChainProgressItemVO(_loc4_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            this.headerText = null;
            this.mainAwardText = null;
            this.progressText = null;
            this.awardNameText = null;
            this.chainsProgressText = null;
            this.awardIconSource = null;
            this.aboutTankBtnLabel = null;
            this.showInHangarBtnLabel = null;
            while((this.progressItems) && this.progressItems.length > 0)
            {
                this.progressItems.pop().dispose();
            }
            this.progressItems = null;
            super.onDispose();
        }
    }
}
