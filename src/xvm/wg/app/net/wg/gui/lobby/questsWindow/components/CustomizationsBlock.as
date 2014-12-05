package net.wg.gui.lobby.questsWindow.components
{
    import scaleform.clik.constants.InvalidationType;
    
    public class CustomizationsBlock extends AbstractResizableContent
    {
        
        public function CustomizationsBlock()
        {
            this._renderers = [];
            super();
        }
        
        private static var RENDERERS_GAP:int = 5;
        
        private var _data:Object;
        
        private var _renderers:Array;
        
        override public function setData(param1:Object) : void
        {
            this._data = param1;
            invalidateData();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                this.destroyRenderers();
                this.createRenderers();
            }
        }
        
        override protected function onDispose() : void
        {
            this.destroyRenderers();
            super.onDispose();
        }
        
        private function destroyRenderers() : void
        {
            var _loc1_:CustomizationItemRenderer = null;
            for each(_loc1_ in this._renderers)
            {
                removeChild(_loc1_);
                _loc1_.dispose();
            }
            this._renderers.splice();
        }
        
        private function createRenderers() : void
        {
            var _loc2_:Object = null;
            var _loc3_:CustomizationItemRenderer = null;
            var _loc1_:* = 0;
            for each(_loc2_ in this._data.list)
            {
                _loc3_ = CustomizationItemRenderer(App.utils.classFactory.getObject(_loc2_.type == 2?"InscriptionItemRenderer_UI":"CustomizationItemRenderer_UI",{"x":_loc1_,
                "y":0,
                "data":_loc2_
            }));
            _loc3_.validateNow();
            addChild(_loc3_);
            _loc1_ = _loc1_ + (RENDERERS_GAP + _loc3_.actualWidth);
        }
    }
}
}
