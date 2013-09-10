package net.wg.gui.lobby.dialogs 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.components.windows.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class SimpleDialog extends net.wg.infrastructure.base.meta.impl.SimpleDialogMeta implements net.wg.infrastructure.base.meta.ISimpleDialogMeta
    {
        public function SimpleDialog()
        {
            super();
            isModal = true;
            return;
        }

        internal function processButtons(arg1:Function):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.getButtonsOrder();
            for each (loc1 in loc3) 
                arg1(loc1);
            return;
        }

        internal function addListenerButtonProcessor(arg1:scaleform.clik.controls.Button):void
        {
            arg1.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onButtonClickHdlr);
            return;
        }

        internal function removeListenerButtonProcessor(arg1:scaleform.clik.controls.Button):void
        {
            arg1.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onButtonClickHdlr);
            return;
        }

        public function get minWidth():Number
        {
            return this._minWidth;
        }

        public function set minWidth(arg1:Number):void
        {
            if (arg1 == this._minWidth) 
                return;
            this._minWidth = arg1;
            return;
        }

        public function as_setTitle(arg1:String):void
        {
            window.title = arg1;
            return;
        }

        public function get minHeight():Number
        {
            return this._minHeight;
        }

        public function set minHeight(arg1:Number):void
        {
            if (arg1 == this._minHeight) 
                return;
            this._minHeight = arg1;
            this.updateActualSize();
            return;
        }

        protected function updateActualSize():void
        {
            this.textField.height = Math.max(this.textField.textHeight, this._minHeight - this.thirdBtn.height - this.BTN_MARGIN);
            var loc1:*=this.getBackgroundActualHeight();
            window.setMinHeight(loc1);
            window.setSize(actualWidth, loc1);
            return;
        }

        internal function onButtonClickHdlr(arg1:scaleform.clik.events.ButtonEvent):void
        {
            var loc1:*=null;
            if (arg1.eventPhase == flash.events.EventPhase.AT_TARGET) 
            {
                loc1 = scaleform.clik.controls.Button(arg1.target).data.id;
                assertNotNull(loc1, "Button has not unique name");
                onButtonClickS(loc1);
            }
            return;
        }

        public function as_setButtonEnabling(arg1:String, arg2:Boolean):void
        {
            if (!this._btnEnableCandidate) 
                this._btnEnableCandidate = new net.wg.gui.lobby.dialogs.ItemStatusData();
            this._btnEnableCandidate.id = arg1;
            this._btnEnableCandidate.status = arg2;
            invalidate(BUTTON_ENABLE_INVALID);
            return;
        }

        public function as_setButtonFocus(arg1:String):void
        {
            this._btnFocusCandidateId = arg1;
            invalidate(BUTTON_FOCUS_INVALID);
            return;
        }

        protected override function onPopulate():void
        {
            window.useBottomBtns = true;
            canDrag = false;
            this.reflowDialogToCtrl();
            updateStage(App.appWidth, App.appHeight);
            this.processButtons(this.addListenerButtonProcessor);
            super.onPopulate();
            return;
        }

        protected override function onDispose():void
        {
            this.processButtons(this.removeListenerButtonProcessor);
            this.dynamicWhiteButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onButtonClickHdlr);
            if (this.textField) 
            {
                this.textField.text = "";
                if (this.textField.parent) 
                    this.textField.parent.removeChild(this.textField);
                this.textField = null;
            }
            super.onDispose();
            return;
        }

        public function as_setText(arg1:String):void
        {
            this.textField.htmlText = arg1;
            this.textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.invalidateLayout();
            return;
        }

        protected function invalidateLayout():void
        {
            invalidate(LAYOUT_INVALID);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=false;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=null;
            super.draw();
            if (isInvalid(LAYOUT_INVALID)) 
                this.applyLayout();
            if (isInvalid(BUTTON_ENABLE_INVALID) && this._btnEnableCandidate) 
            {
                loc1 = this._btnEnableCandidate.id;
                loc2 = this._btnEnableCandidate.status;
                loc3 = this.getAllButtons();
                loc5 = loc3.length;
                loc6 = 0;
                while (loc6 < loc5) 
                {
                    if ((loc4 = loc3[loc6]).data && loc4.data.hasOwnProperty("id")) 
                        if (loc1 == loc4.data.id) 
                            loc4.enabled = loc2;
                    ++loc6;
                }
            }
            if (isInvalid(BUTTON_FOCUS_INVALID) && this._btnFocusCandidateId) 
            {
                loc7 = this.getAllButtons();
                var loc9:*=0;
                var loc10:*=loc7;
                for each (loc8 in loc10) 
                {
                    if (!(loc8.data && loc8.data.hasOwnProperty("id") && this._btnFocusCandidateId == loc8.data.id)) 
                        continue;
                    if (loc8.enabled) 
                        App.utils.focusHandler.setFocus(loc8);
                    break;
                }
            }
            return;
        }

        protected function applyLayout():void
        {
            this.layoutButtons(this.getBackgroundActualHeight());
            scaleform.clik.core.UIComponent(window).invalidate(net.wg.gui.components.windows.Window.INVALID_SRC_VIEW);
            return;
        }

        public override function get height():Number
        {
            var loc1:*=this.thirdBtn.height;
            return this.getBackgroundActualHeight() + TEXT_HEIGHT_PADDING + loc1;
        }

        protected function getBackgroundActualHeight():Number
        {
            return Math.max(this.getTextAreaCurrentHeight(), this.getTextAreaMinHeight());
        }

        protected function getTextAreaMinHeight():Number
        {
            var loc1:*=this.thirdBtn.height;
            return Math.ceil(this._minHeight - loc1 - TEXT_HEIGHT_PADDING);
        }

        protected function getTextAreaCurrentHeight():Number
        {
            return Math.ceil(this.textField.y + this.textField.textHeight + ADDITIONAL_MULTI_LINE_PADDING);
        }

        public override function set window(arg1:net.wg.infrastructure.interfaces.IWindow):void
        {
            var loc1:*=null;
            super.window = arg1;
            if (window) 
            {
                loc1 = window.contentPadding as scaleform.clik.utils.Padding;
                loc1.right = WINDOW_PADDING.right;
                loc1.bottom = WINDOW_PADDING.bottom;
            }
            return;
        }

        protected function layoutButtons(arg1:Number):void
        {
            var loc1:*=this.getAllButtons();
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1[loc3].y = arg1;
                ++loc3;
            }
            return;
        }

        internal static function hideBtnProcessor(arg1:scaleform.clik.controls.Button):void
        {
            arg1.visible = false;
            return;
        }

        public function as_setButtons(arg1:Array):void
        {
            var loc5:*=null;
            var loc6:*=null;
            var loc1:*=this.getButtonsOrder();
            var loc2:*=loc1.length - arg1.length;
            assert(loc2 >= 0, "buttonNames too much");
            var loc3:*=App.utils.focusHandler;
            var loc4:*=(arg1.length - 1);
            while (loc4 >= 0) 
            {
                loc5 = loc1[loc4 + loc2] as net.wg.gui.components.controls.SoundButtonEx;
                if ((loc6 = arg1[loc4].id) != CLOSE_BUTTON) 
                {
                    loc5.data = arg1[loc4];
                    loc5.label = arg1[loc4].label;
                    if (arg1[loc4].focused) 
                        loc3.setFocus(loc5);
                    loc5.visible = true;
                    if (loc6 != SUBMIT_BUTTON) 
                        loc5.soundType = net.wg.data.constants.SoundTypes.NORMAL_BTN;
                    else 
                        loc5.soundType = net.wg.data.constants.SoundTypes.OK_BTN;
                }
                else 
                {
                    this.dynamicWhiteButton.x = loc5.x;
                    this.dynamicWhiteButton.y = loc5.y;
                    this.dynamicWhiteButton.data = arg1[loc4];
                    this.dynamicWhiteButton.label = arg1[loc4].label;
                    if (arg1[loc4].focused) 
                        loc3.setFocus(this.dynamicWhiteButton);
                    this.dynamicWhiteButton.visible = true;
                    this.dynamicWhiteButton.soundType = net.wg.data.constants.SoundTypes.CANCEL_BTN;
                    this.addListenerButtonProcessor(this.dynamicWhiteButton);
                    loc5.visible = false;
                }
                --loc4;
            }
            return;
        }

        internal function reflowDialogToCtrl():void
        {
            this.processButtons(hideBtnProcessor);
            return;
        }

        protected function getButtonsOrder():__AS3__.vec.Vector.<scaleform.clik.controls.Button>
        {
            return Vector.<scaleform.clik.controls.Button>([this.firstBtn, this.secondBtn, this.thirdBtn]);
        }

        protected function getAllButtons():__AS3__.vec.Vector.<scaleform.clik.controls.Button>
        {
            return Vector.<scaleform.clik.controls.Button>([this.firstBtn, this.secondBtn, this.thirdBtn, this.dynamicWhiteButton]);
        }

        internal const MIN_WIDTH:Number=360;

        internal const MIN_HEIGHT:Number=115;

        public static const SUBMIT_BUTTON:String="submit";

        public static const CLOSE_BUTTON:String="close";

        protected const BTN_MARGIN:Number=9;

        internal static const TEXT_HEIGHT_PADDING:uint=3;

        internal static const WINDOW_PADDING:Object={"right":12, "bottom":15};

        internal static const LAYOUT_INVALID:String="layoutInv";

        internal static const BUTTON_ENABLE_INVALID:String="btnEnInv";

        internal static const BUTTON_FOCUS_INVALID:String="btnFocusInv";

        protected static const ADDITIONAL_MULTI_LINE_PADDING:uint=5;

        public var textField:flash.text.TextField=null;

        public var firstBtn:net.wg.gui.components.controls.SoundButtonEx=null;

        public var secondBtn:net.wg.gui.components.controls.SoundButtonEx=null;

        public var thirdBtn:net.wg.gui.components.controls.SoundButtonEx=null;

        public var dynamicWhiteButton:net.wg.gui.components.controls.SoundButtonEx=null;

        internal var _minWidth:Number=360;

        internal var _minHeight:Number=115;

        internal var _btnEnableCandidate:net.wg.gui.lobby.dialogs.ItemStatusData;

        internal var _btnFocusCandidateId:String;
    }
}
