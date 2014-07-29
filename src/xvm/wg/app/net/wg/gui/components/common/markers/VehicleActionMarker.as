package net.wg.gui.components.common.markers
{
    import scaleform.clik.core.UIComponent;
    import flash.display.MovieClip;
    import scaleform.clik.motion.Tween;
    
    public class VehicleActionMarker extends UIComponent
    {
        
        public function VehicleActionMarker()
        {
            super();
        }
        
        private static var HIDE_DURATION:Number = 1000;
        
        private var _actionRendererMap:Object;
        
        private var currentRenderer:MovieClip;
        
        private var hideTween:Tween;
        
        public function showAction(param1:String) : void
        {
            var _loc2_:String = this._actionRendererMap[param1];
            if(_loc2_)
            {
                this.currentRenderer = this.createActionRenderer(_loc2_);
            }
        }
        
        public function stopAction() : void
        {
            if(this.currentRenderer)
            {
                this.hideTween = new Tween(HIDE_DURATION,this.currentRenderer,{"alpha":0.0});
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
        }
        
        private function removeActionRenderer() : void
        {
            if(!this.currentRenderer)
            {
                return;
            }
            removeChild(this.currentRenderer);
            this.currentRenderer = null;
        }
        
        private function createActionRenderer(param1:String) : MovieClip
        {
            var _loc2_:MovieClip = null;
            this.removeActionRenderer();
            _loc2_ = App.utils.classFactory.getObject(param1) as MovieClip;
            if(_loc2_)
            {
                addChild(_loc2_);
            }
            return _loc2_;
        }
        
        public function get actionRenderers() : Object
        {
            return this._actionRendererMap;
        }
        
        public function set actionRenderers(param1:Object) : void
        {
            this._actionRendererMap = param1;
        }
        
        override protected function onDispose() : void
        {
            this.removeActionRenderer();
            this._actionRendererMap = null;
            this.hideTween = null;
            super.onDispose();
        }
    }
}
