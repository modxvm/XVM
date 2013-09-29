package net.wg.gui.lobby.customization.renderers 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    
    public class CustomizationItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function CustomizationItemRenderer()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.CUSTOMIZATION_ITEM_RENDERER;
            return;
        }

        public function set demoMode(arg1:String):void
        {
            if (this._demoMode == arg1) 
            {
                return;
            }
            this._demoMode = arg1;
            var loc1:*=this._useHandCursorForse || this._demoMode == DEMO_OFF;
            super.enabled = loc1;
            useHandCursor = loc1;
            setState(state);
            return;
        }

        public function get useHandCursorForse():Boolean
        {
            return this._useHandCursorForse;
        }

        public function set useHandCursorForse(arg1:Boolean):void
        {
            this._useHandCursorForse = arg1;
            return;
        }

        public override function setData(arg1:Object):void
        {
            var loc1:*=this.isNew;
            data = arg1;
            if (data) 
            {
                if (data.current != this.current) 
                {
                    this.current = data.current;
                }
                this.costVisible = this.demoMode == CustomizationItemRenderer.DEMO_NEW && data.id > 0 || this.demoMode == CustomizationItemRenderer.DEMO_OFF;
                if (data.price) 
                {
                    this.costVal = data.price.isGold ? App.utils.locale.gold(data.price.cost) : App.utils.locale.integer(data.price.cost);
                    this.isGold = data.price.isGold;
                }
                loc1 = data.isNew;
                if (this.uiLoader) 
                {
                    this.loadTexture(data.texturePath);
                }
            }
            if (loc1 != this.isNew) 
            {
                this.showIsNew(loc1);
            }
            invalidateData();
            this.hideTooltip();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, handleMouseRollOver);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, handleMouseRollOut);
            removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, handleMousePress);
            removeEventListener(flash.events.MouseEvent.CLICK, handleMouseRelease);
            removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, handleMouseRelease);
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput);
            this.uiLoader.dispose();
            this.uiLoader.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onImageLoadComplete);
            if (this.newMarker && contains(this.newMarker)) 
            {
                removeChild(this.newMarker);
            }
            data = null;
            return;
        }

        protected override function configUI():void
        {
            var loc1:*=false;
            super.configUI();
            loc1 = this._useHandCursorForse || this._demoMode == DEMO_OFF;
            super.enabled = loc1;
            useHandCursor = loc1;
            this.uiLoader.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onImageLoadComplete);
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            if (data) 
            {
                this.loadTexture(data.texturePath);
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.visible = !(this.data == null);
                this.costField.visible = this.costVisible;
                this.costFrame.visible = this.costVisible;
                this.costField.text = this.costVal;
                this.costField.icon = this.isGold ? net.wg.gui.components.controls.IconText.GOLD : net.wg.gui.components.controls.IconText.CREDITS;
            }
            return;
        }

        protected override function getStatePrefixes():__AS3__.vec.Vector.<String>
        {
            if (this.prefixesVector) 
            {
                this.prefixesVector.splice(0, this.prefixesVector.length);
            }
            else 
            {
                this.prefixesVector = new Vector.<String>();
            }
            if (enabled && this._current) 
            {
                this.prefixesVector.push("current_");
            }
            else if (enabled && _selected) 
            {
                this.prefixesVector.push("selected_");
            }
            else 
            {
                this.prefixesVector.push("");
            }
            return this.prefixesVector;
        }

        protected function showIsNew(arg1:Boolean):void
        {
            this.isNew = arg1;
            if (arg1) 
            {
                if (!this.newMarker) 
                {
                    this.newMarker = App.utils.classFactory.getObject("NewMarker") as flash.display.MovieClip;
                    var loc1:*;
                    this.newMarker.y = loc1 = 2;
                    this.newMarker.x = loc1;
                    addChild(this.newMarker);
                }
                this.newMarker.visible = arg1;
            }
            else if (this.newMarker) 
            {
                this.newMarker.visible = arg1;
            }
            return;
        }

        protected function onImageLoadComplete(arg1:flash.events.Event):void
        {
            invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            return;
        }

        internal function loadTexture(arg1:String):void
        {
            this.texturePath = arg1;
            if (!(this.texturePath == null) && !(this.texturePath.length == 0)) 
            {
                this.uiLoader.source = arg1;
            }
            else 
            {
                this.uiLoader.unload();
            }
            return;
        }

        internal function showTooltip(arg1:flash.events.MouseEvent=null):void
        {
            if (data && data.description.length > 0) 
            {
                App.toolTipMgr.showComplex(data.description);
            }
            return;
        }

        internal function hideTooltip(arg1:flash.events.MouseEvent=null):void
        {
            App.toolTipMgr.hide();
            return;
        }

        public function get current():Boolean
        {
            return this._current;
        }

        public function set current(arg1:Boolean):void
        {
            if (this._current == arg1) 
            {
                return;
            }
            this._current = arg1;
            setState(state);
            return;
        }

        public function get demoMode():String
        {
            return this._demoMode;
        }

        public static const DEMO_OFF:String="off";

        public static const DEMO_NEW:String="new";

        public static const DEMO_CURRENT:String="current";

        public var newMarker:flash.display.MovieClip;

        public var uiLoader:net.wg.gui.components.controls.UILoaderAlt;

        public var costField:net.wg.gui.components.controls.IconText;

        public var costFrame:flash.display.MovieClip;

        public var border:net.wg.gui.lobby.customization.renderers.RendererBorder;

        protected var isNew:Boolean=false;

        protected var isGold:Boolean=false;

        protected var costVal:String="";

        internal var costVisible:Boolean=false;

        internal var texturePath:String;

        internal var _current:Boolean=false;

        internal var _demoMode:String="off";

        internal var _useHandCursorForse:Boolean=false;

        protected var prefixesVector:__AS3__.vec.Vector.<String>=null;
    }
}
