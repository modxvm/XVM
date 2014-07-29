package net.wg.gui.lobby.fortifications.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    
    public class FortChoiceDivisionVO extends DAAPIDataClass
    {
        
        public function FortChoiceDivisionVO(param1:Object)
        {
            super(param1);
        }
        
        private static var SELECTORS_DATA:String = "selectorsData";
        
        public var autoSelect:int = -1;
        
        public var windowTitle:String = "";
        
        public var description:String = "";
        
        public var applyBtnLbl:String = "";
        
        public var cancelBtnLbl:String = "";
        
        public var selectorsData:Array = null;
        
        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            var _loc5_:FortChoiceDivisionSelectorVO = null;
            if(param1 == SELECTORS_DATA && !(param2 == null))
            {
                _loc3_ = param2 as Array;
                this.selectorsData = [];
                for each(_loc4_ in _loc3_)
                {
                    _loc5_ = new FortChoiceDivisionSelectorVO(_loc4_);
                    this.selectorsData.push(_loc5_);
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }
        
        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            super.onDispose();
            for each(_loc1_ in this.selectorsData)
            {
                _loc1_.dispose();
            }
            if(this.selectorsData)
            {
                this.selectorsData.splice(0,this.selectorsData.length);
                this.selectorsData = null;
            }
        }
    }
}
