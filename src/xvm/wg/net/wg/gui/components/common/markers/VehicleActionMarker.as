package net.wg.gui.components.common.markers 
{
    import flash.display.*;
    import scaleform.clik.core.*;
    import scaleform.clik.motion.*;
    
    public class VehicleActionMarker extends scaleform.clik.core.UIComponent
    {
        public function VehicleActionMarker()
        {
            super();
            return;
        }

        public function showAction(arg1:String):void
        {
            var loc1:*=this._actionRendererMap[arg1];
            if (loc1) 
                this.currentRenderer = this.createActionRenderer(loc1);
            return;
        }

        public function stopAction():void
        {
            if (this.currentRenderer) 
                this.hideTween = new scaleform.clik.motion.Tween(HIDE_DURATION, this.currentRenderer, {"alpha":0});
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        internal function removeActionRenderer():void
        {
            if (!this.currentRenderer) 
                return;
            removeChild(this.currentRenderer);
            this.currentRenderer = null;
            return;
        }

        internal function createActionRenderer(arg1:String):flash.display.MovieClip
        {
            var loc1:*=null;
            this.removeActionRenderer();
            loc1 = App.utils.classFactory.getObject(arg1) as flash.display.MovieClip;
            if (loc1) 
                addChild(loc1);
            return loc1;
        }

        public function get actionRenderers():Object
        {
            return this._actionRendererMap;
        }

        public function set actionRenderers(arg1:Object):void
        {
            this._actionRendererMap = arg1;
            return;
        }

        public override function dispose():void
        {
            this.removeActionRenderer();
            this._actionRendererMap = null;
            this.hideTween = null;
            super.dispose();
            return;
        }

        internal static const HIDE_DURATION:Number=1000;

        internal var _actionRendererMap:Object;

        internal var currentRenderer:flash.display.MovieClip;

        internal var hideTween:scaleform.clik.motion.Tween;
    }
}
