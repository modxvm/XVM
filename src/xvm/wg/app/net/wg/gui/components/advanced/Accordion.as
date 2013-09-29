package net.wg.gui.components.advanced 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    
    public class Accordion extends net.wg.gui.components.advanced.ButtonBarEx implements net.wg.infrastructure.interfaces.IDynamicContent
    {
        public function Accordion()
        {
            super();
            var loc1:*;
            focusable = loc1 = true;
            tabEnabled = loc1;
            itemRendererName = DEFAUILT_ITEM_RNDR;
            _direction = DIRECTION_VERTICAL;
            return;
        }

        public function set margin(arg1:Number):void
        {
            this._margin = arg1;
            return;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function set paddingTop(arg1:Number):void
        {
            this._paddingTop = arg1;
            return;
        }

        public function get paddingBottom():Number
        {
            return this._paddingBottom;
        }

        public override function set selectedIndex(arg1:int):void
        {
            this.view.alpha = 0;
            super.selectedIndex = arg1;
            invalidate();
            return;
        }

        public function set paddingBottom(arg1:Number):void
        {
            this._paddingBottom = arg1;
            return;
        }

        public function get paddingLeft():Number
        {
            return this._paddingLeft;
        }

        public function set paddingLeft(arg1:Number):void
        {
            this._paddingLeft = arg1;
            return;
        }

        public function get paddingRight():Number
        {
            return this._paddingRight;
        }

        public function set paddingRight(arg1:Number):void
        {
            this._paddingRight = arg1;
            return;
        }

        public function get enableHeaderConstraints():Boolean
        {
            return this._enableHeaderConstraints;
        }

        public function set enableHeaderConstraints(arg1:Boolean):void
        {
            this._enableHeaderConstraints = arg1;
            return;
        }

        public function set showBackground(arg1:Boolean):void
        {
            this._showBgForm = arg1;
            return;
        }

        public function get backgroundType():String
        {
            return this._backgroundType;
        }

        public function set backgroundType(arg1:String):void
        {
            this.border.gotoAndStop(arg1);
            this._backgroundType = arg1;
            return;
        }

        public function get actualViewWidth():Number
        {
            return this._actualViewWidth;
        }

        public function get actualViewHeight():Number
        {
            return this._actualViewHeight;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.view.groupRef = this;
            if (this.border) 
            {
                this.border.visible = this._showBgForm;
            }
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.view.dispose();
            if (dataProvider) 
            {
                dataProvider.cleanUp();
                dataProvider = null;
            }
            removeChild(container);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            if (isInvalid(scaleform.clik.constants.InvalidationType.RENDERERS) || isInvalid(scaleform.clik.constants.InvalidationType.DATA) || isInvalid(scaleform.clik.constants.InvalidationType.SETTINGS) || isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                loc1 = App.utils.events;
                loc1.disableDisposingForObj(container);
                removeChild(container);
                _originalWidth = _width;
                _originalHeight = _height;
                setActualSize(_width, _height);
                setActualScale(1, 1);
                container.scaleX = 1 / scaleX;
                container.scaleY = 1 / scaleY;
                addChild(container);
                loc1.enableDisposingForObj(container);
                updateRenderers();
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                refreshData();
            }
            if (isInvalid(INVALID_BORDER)) 
            {
                if (this.border) 
                {
                    this.border.width = width;
                    this.border.height = height;
                }
                if (this.texture) 
                {
                    this.texture.setSize(width, height);
                }
            }
            this.drawLayout(width, this.rowHeight);
            this.view.alpha = 1;
            return;
        }

        protected override function setupRenderer(arg1:scaleform.clik.controls.Button, arg2:uint):void
        {
            super.setupRenderer(arg1, arg2);
            if (arg1 is net.wg.infrastructure.interfaces.IAccordionItemRenderer) 
            {
                net.wg.infrastructure.interfaces.IAccordionItemRenderer(arg1).enableConstraints = this.enableHeaderConstraints;
            }
            arg1.tabEnabled = false;
            return;
        }

        protected override function populateRendererData(arg1:scaleform.clik.controls.Button, arg2:uint):void
        {
            super.populateRendererData(arg1, arg2);
            var loc1:*=_dataProvider.requestItemAt(arg2);
            if (loc1.hasOwnProperty("enabled")) 
            {
                arg1.enabled = loc1.enabled;
            }
            return;
        }

        public function get showBackground():Boolean
        {
            return this._showBgForm;
        }

        internal function drawLayout(arg1:Number, arg2:Number):void
        {
            var loc3:*=null;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc1:*=this.paddingLeft + this.paddingRight + this.margin * 2;
            arg1 = arg1 - loc1;
            var loc2:*=this.margin + this.paddingTop;
            var loc6:*=0;
            var loc7:*=_renderers;
            for each (loc3 in loc7) 
            {
                loc3.x = Math.round(this.margin + this.paddingLeft);
                loc3.y = Math.round(loc2);
                loc2 = loc2 + arg2;
                if (selectedRenderer == loc3) 
                {
                    this.view.y = loc2;
                    this.view.x = this.margin + this.paddingLeft;
                    loc4 = height - (this.margin >> 1) - this.paddingTop - this.paddingBottom - _renderers.length * arg2;
                    loc5 = Math.max(0, loc4);
                    this.view.setActualSize(arg1, loc5);
                    this.view.setActualScale(1, 1);
                    this._actualViewWidth = arg1;
                    this._actualViewHeight = loc5;
                    loc2 = loc2 + loc5;
                }
                loc3.setSize(arg1, arg2);
            }
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            return;
        }

        public function get rowHeight():Number
        {
            return this._rowHeight;
        }

        public function set rowHeight(arg1:Number):void
        {
            this._rowHeight = arg1;
            return;
        }

        public function get margin():Number
        {
            return this._margin;
        }

        internal static const DEFAUILT_ITEM_RNDR:String=net.wg.data.constants.Linkages.ACCORDION_RDR_UI;

        internal static const INVALID_BORDER:String="border";

        public var view:net.wg.gui.components.advanced.ViewStack=null;

        public var border:flash.display.MovieClip=null;

        public var texture:net.wg.gui.components.controls.BitmapFill=null;

        internal var _rowHeight:Number=33;

        internal var _paddingTop:Number=0;

        internal var _paddingBottom:Number=0;

        internal var _paddingLeft:Number=0;

        internal var _paddingRight:Number=0;

        internal var _enableHeaderConstraints:Boolean=false;

        internal var _showBgForm:Boolean=true;

        internal var _backgroundType:String="gray";

        internal var _backgroundAlpha:String="0.75";

        internal var _actualViewWidth:Number;

        internal var _actualViewHeight:Number;

        internal var _margin:Number=1;
    }
}
