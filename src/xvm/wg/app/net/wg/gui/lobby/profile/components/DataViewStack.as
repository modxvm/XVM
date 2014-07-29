package net.wg.gui.lobby.profile.components
{
    import net.wg.gui.components.advanced.ViewStack;
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IUpdatable;
    
    public class DataViewStack extends ViewStack
    {
        
        public function DataViewStack()
        {
            super();
        }
        
        private static var DATA_INV:String = "dataForUpdInv";
        
        protected var _dataForUpdate:Object;
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(DATA_INV)) && (this._dataForUpdate))
            {
                this.applyData();
            }
        }
        
        override public function show(param1:String) : MovieClip
        {
            var _loc2_:MovieClip = super.show(param1);
            var _loc3_:IUpdatable = _loc2_ as IUpdatable;
            if(_loc3_)
            {
                this.applyDataToViewObject(_loc3_,this._dataForUpdate);
            }
            return _loc2_;
        }
        
        protected function applyData() : void
        {
            var _loc1_:IUpdatable = null;
            for each(_loc1_ in cachedViews)
            {
                this.applyDataToViewObject(_loc1_,this._dataForUpdate);
            }
        }
        
        protected function applyDataToViewObject(param1:IUpdatable, param2:Object) : void
        {
            param1.update(param2);
        }
        
        public function updateData(param1:Object) : void
        {
            this._dataForUpdate = param1;
            invalidate(DATA_INV);
        }
        
        override protected function onDispose() : void
        {
            this._dataForUpdate = null;
            super.onDispose();
        }
    }
}
