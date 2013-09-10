package net.wg.gui.login.EULA 
{
    import flash.events.*;
    import flash.ui.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class EULADlg extends net.wg.infrastructure.base.meta.impl.EULAMeta implements net.wg.infrastructure.base.meta.IEULAMeta
    {
        public function EULADlg()
        {
            super();
            isModal = true;
            isCentered = true;
            canDrag = false;
            return;
        }

        public final override function setViewSize(arg1:Number, arg2:Number):void
        {
            _originalWidth = width;
            _originalHeight = height;
            setActualSize(width, height);
            setActualScale(1, 1);
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            if (this.isAutoResize()) 
            {
                this.updatePosition();
            }
            else 
            {
                super.updateStage(arg1, arg2);
            }
            return;
        }

        public function as_setEULAText(arg1:String):void
        {
            var loc4:*=NaN;
            var loc1:*="Incorrect invoking as_setEULAText!" + "Method must be call once time only!";
            var loc2:*=App.utils.asserter;
            loc2.assertNotNull(this.textArea, "content.textArea in EULADlg" + net.wg.data.constants.Errors.CANT_NULL);
            loc2.assert(!(this.textArea.htmlText == arg1), loc1);
            var loc3:*=height - this.textArea.height;
            this.textArea.htmlText = arg1;
            if (this.isAutoResize()) 
            {
                this.textArea.validateNow();
                if (this.textArea.height - this.textArea.textField.textHeight > 5) 
                {
                    this.textArea.height = this.textArea.textField.textHeight + 5;
                    this.textArea.validateNow();
                    loc4 = loc3 + this.textArea.height;
                    this.dynamicUpdateSize(width, loc4);
                }
            }
            return;
        }

        protected override function preInitialize():void
        {
            constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.REFLOW);
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            window.useBottomBtns = true;
            this.applyButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onApplyBtnClickHandler);
            this.textArea.addEventListener(flash.events.TextEvent.LINK, this.onLinkClickHandler);
            addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput);
            constraints.addElement(this.applyButton.name, this.applyButton, scaleform.clik.utils.Constraints.BOTTOM | scaleform.clik.utils.Constraints.RIGHT);
            window.title = DIALOGS.EULA_TITLE;
            this.updateStage(App.appWidth, App.appHeight);
            requestEULATextS();
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.applyButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onApplyBtnClickHandler);
            this.textArea.removeEventListener(flash.events.TextEvent.LINK, this.onLinkClickHandler);
            this.textArea.dispose();
            this.textArea = null;
            this.applyButton.dispose();
            this.applyButton = null;
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput);
            return;
        }

        protected function isAutoResize():Boolean
        {
            return true;
        }

        internal function dynamicUpdateSize(arg1:Number, arg2:Number):void
        {
            App.utils.scheduler.envokeInNextFrame(this.dynamicUpdateSizePostponed, arg1, arg2);
            visible = false;
            return;
        }

        internal function dynamicUpdateSizePostponed(arg1:Number, arg2:Number):void
        {
            this._myWidth = arg1;
            this._myHeight = arg2;
            window.updateSize(arg1, arg2, true);
            this.updatePosition();
            visible = true;
            return;
        }

        internal function updatePosition():void
        {
            window.x = App.appWidth - this._myWidth >> 1;
            window.y = App.appHeight - this._myHeight >> 1;
            return;
        }

        internal function onApplyBtnClickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onApplyS();
            return;
        }

        internal function onLinkClickHandler(arg1:flash.events.TextEvent):void
        {
            onLinkClickS(arg1.text);
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            super.handleInput(arg1);
            if (arg1.handled) 
            {
                return;
            }
            if (arg1.details.value == scaleform.clik.constants.InputValue.KEY_DOWN && arg1.details.code == flash.ui.Keyboard.ENTER) 
            {
                onApply();
            }
            return;
        }

        public var applyButton:net.wg.gui.components.controls.SoundButtonEx=null;

        public var textArea:net.wg.gui.components.advanced.TextAreaSimple=null;

        internal var _myHeight:Number=0;

        internal var _myWidth:Number=0;
    }
}
