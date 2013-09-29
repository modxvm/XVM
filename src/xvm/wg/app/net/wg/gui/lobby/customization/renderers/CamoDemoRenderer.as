package net.wg.gui.lobby.customization.renderers 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.constants.*;
    
    public class CamoDemoRenderer extends net.wg.gui.lobby.customization.renderers.CamouflageItemRenderer
    {
        public function CamoDemoRenderer()
        {
            super();
            soundId = net.wg.data.constants.SoundTypes.CAMOUFLAGE_DEMO_RENDERER;
            useHandCursorForse = true;
            return;
        }

        public override function setData(arg1:Object):void
        {
            super.setData(arg1);
            this.showKind(!data || !data.id);
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
            return;
        }

        protected override function draw():void
        {
            var loc1:*=NaN;
            super.draw();
            if (this._kindDirty) 
            {
                if (this.kind != OFF) 
                {
                    this.showKind(!data || !data.id);
                    loc1 = 0;
                    loc1 = 0;
                    while (loc1 < KINDS.length) 
                    {
                        if (KINDS[loc1] == this.kind) 
                        {
                            this.kindMc.gotoAndStop(loc1 + 1);
                        }
                        ++loc1;
                    }
                }
                else 
                {
                    this.showKind(false);
                }
                this._kindDirty = false;
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                if (this.timeLeftFld) 
                {
                    if (data && data.timeLeft && data.timeLeft.length > 0) 
                    {
                        this.timeLeftFld.visible = true;
                        this.timeLeftFld.text = data.timeLeft;
                    }
                    else 
                    {
                        this.timeLeftFld.visible = false;
                    }
                }
                else 
                {
                    invalidateData();
                }
                costField.text = "";
            }
            return;
        }

        protected override function setState(arg1:String):void
        {
            super.setState(arg1);
            if (!current && !selected) 
            {
                border.state = "up";
            }
            return;
        }

        internal function showKind(arg1:Boolean):void
        {
            this.kindMc.visible = !(this.kind == OFF) && arg1;
            return;
        }

        
        {
            KINDS = [WINTER, SUMMER, DESERT];
        }

        public static const WINTER:String="winter";

        public static const SUMMER:String="summer";

        public static const DESERT:String="desert";

        public static const OFF:String="off";

        public static const KIND_DIRTY:String="kindDirty";

        public var kindMc:flash.display.MovieClip;

        public var timeLeftFld:flash.text.TextField;

        public var costFieldNew:net.wg.gui.components.controls.IconText;

        internal var _kind:String;

        internal var _kindDirty:Boolean=false;

        public static var KINDS:Array;
    }
}
