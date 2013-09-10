package net.wg.gui.lobby.battleResults 
{
    import flash.display.*;
    import flash.filters.*;
    import scaleform.clik.core.*;
    
    public class EfficiencyIconRenderer extends scaleform.clik.core.UIComponent
    {
        public function EfficiencyIconRenderer()
        {
            super();
            buttonMode = true;
            return;
        }

        public function get kind():String
        {
            return this._kind;
        }

        public function set kind(arg1:String):void
        {
            this._kind = arg1;
            this._kindDirty = true;
            invalidate();
            return;
        }

        public function get value():Number
        {
            return this._value;
        }

        public function set value(arg1:Number):void
        {
            this._value = arg1;
            this._valueDirty = true;
            invalidate();
            return;
        }

        public override function set enabled(arg1:Boolean):void
        {
            this._disabledDirty = true;
            super.enabled = arg1;
            mouseEnabled = true;
            invalidate();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            mouseChildren = false;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            super.draw();
            if (this._disabledDirty) 
            {
                if (enabled) 
                {
                    filters = [];
                    this.iconMc.alpha = 1;
                }
                else 
                {
                    loc1 = new flash.filters.ColorMatrixFilter();
                    loc2 = [0.3, 0.59, 0.11, 0, 0];
                    loc3 = [0.3, 0.59, 0.11, 0, 0];
                    loc4 = [0.3, 0.59, 0.11, 0, 0];
                    loc5 = [0, 0, 0, 0.2, 0];
                    loc6 = (loc6 = (loc6 = (loc6 = (loc6 = new Array()).concat(loc2)).concat(loc3)).concat(loc4)).concat(loc5);
                    loc1.matrix = loc6;
                    this.filters = [loc1];
                    this.iconMc.alpha = 0.1;
                }
                this.iconLabelMc.visible = enabled;
                this._disabledDirty = false;
            }
            if (this._kindDirty) 
            {
                this.iconMc.gotoAndStop(this.kind);
                this._kindDirty = false;
            }
            if (this._valueDirty) 
            {
                this.iconLabelMc.countLabel.text = this.value;
                this._valueDirty = false;
            }
            this.iconLabelMc.visible = enabled && this.value > 1;
            return;
        }

        public static const EVIL:String="evil";

        public static const SPOTTED:String="spotted";

        public static const DAMAGE:String="damage";

        public static const CRITS:String="crits";

        public static const TEAMKILL:String="teamKill";

        public static const KILL:String="kill";

        public static const MEDAL:String="medal";

        public static const ASSIST:String="assist";

        internal var _kind:String="kill";

        internal var _kindDirty:Boolean=true;

        internal var _value:Number=0;

        internal var _valueDirty:Boolean=true;

        internal var _disabledDirty:Boolean=true;

        public var iconMc:flash.display.MovieClip;

        public var iconLabelMc:flash.display.MovieClip;
    }
}
