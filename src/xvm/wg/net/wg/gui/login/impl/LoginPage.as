package net.wg.gui.login.impl
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.ui.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.common.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.login.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import org.idmedia.as3commons.util.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;

    public class LoginPage extends net.wg.infrastructure.base.meta.impl.LoginPageMeta implements net.wg.infrastructure.base.meta.ILoginPageMeta
    {
        public function LoginPage()
        {
            super();
            return;
        }

        internal function initFocus():void
        {
            if (this.form.login.text.length > 0)
                App.utils.focusHandler.setFocus(this.form.pass);
            else
                App.utils.focusHandler.setFocus(this.form.login);
            return;
        }

        internal function onSubmitButtonClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.submit();
            return;
        }

        internal function onChange(arg1:flash.events.Event):void
        {
            var event:flash.events.Event;
            var isToken:Boolean;

            var loc1:*;
            event = arg1;
            isToken = isTokenS();
            try
            {
                onExitFromAutoLoginS();
                this.form.update(event.target, isToken);
            }
            catch (e:Error)
            {
                DebugUtils.LOG_ERROR(e.message);
            }
            return;
        }

        internal function onRememberPwdCheckboxToggle(arg1:flash.events.Event):void
        {
            onSetRememberPasswordS(this.form.rememberPwdCheckbox.selected);
            return;
        }

        internal function onRegisterLinkClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onRegisterS();
            return;
        }

        internal function onRecoveryLinkClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onRecoveryS();
            return;
        }

        public function as_setDefaultValues(arg1:String, arg2:String, arg3:Boolean, arg4:Boolean, arg5:Boolean):void
        {
            this.form.setDefaultValues(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        internal function onMessageLinkClick(arg1:flash.events.TextEvent):void
        {
            if (this.isTFClickedByMBR)
                return;
            var loc1:*=arg1.text;
            switch (loc1)
            {
                case "passwordRecovery":
                    onRecoveryS();
                    break;
                default:
                    break;
            }
            return;
        }

        internal function onMessageTextClick(arg1:flash.events.MouseEvent):void
        {
            this.isTFClickedByMBR = App.utils.commons.isRightButton(arg1);
            return;
        }

        internal function onQueueDialogQuitClose(arg1:flash.events.MouseEvent):void
        {
            this.form.setErrorMessage("", ErrorStates.NONE);
            onExitFromAutoLogin();
            return;
        }

        internal function onNeedTokenReset(arg1:net.wg.gui.login.impl.LoginEvent):void
        {
            resetTokenS();
            return;
        }

        internal function onLoadingImageCompleteHandler(arg1:net.wg.gui.events.UILoaderEvent):void
        {
            this.set_position_wallpaper();
            visible = true;
            invalidate();
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            this.updateContent();
            if (this._sparksManager)
                this._sparksManager.resetZone(this.getSparkZone());
            return;
        }

        public override function handleInput(arg1:scaleform.clik.events.InputEvent):void
        {
            var loc1:*=null;
            super.handleInput(arg1);
            if (arg1.handled)
                return;
            if (arg1.details.value == scaleform.clik.constants.InputValue.KEY_DOWN)
            {
                loc1 = this.keyMappings.get(arg1.details.code);
                if (loc1 != null)
                {
                    loc1();
                    arg1.handled = true;
                }
            }
            return;
        }

        public function as_setErrorMessage(arg1:String, arg2:int):void
        {
            this.form.setErrorMessage(arg1, arg2);
            return;
        }

        public function as_setServersList(arg1:Array, arg2:int):void
        {
            assertNotNull(arg1);
            assert(arg2 >= -1, "selectedIdx must be greater then -2");
            this.form.setServersList(arg1, arg2);
            return;
        }

        public function as_setVersion(arg1:String):void
        {
            assertNotNull(arg1);
            this.version.text = arg1;
            return;
        }

        public function as_showWallpaper(arg1:Boolean, arg2:String):void
        {
            visible = false;
            this.bg_image.source = arg2;
            this.useWallpaper = arg1;
            if (this.useWallpaper)
                invalidate();
            else
            {
                this.bg_image.autoSize = true;
                invalidate();
                this.sparksMc.visible = false;
            }
            return;
        }

        public function as_setCapsLockState(arg1:Boolean):void
        {
            this.form.setCapsLockState(arg1);
            return;
        }

        public function as_cancelLoginQueue():void
        {
            DebugUtils.LOG_DEBUG("as_cancelLoginQueue");
            return;
        }

        public function as_doAutoLogin():void
        {
            DebugUtils.LOG_DEBUG("as_doAutoLogin");
            this.submit();
            return;
        }

        public function as_enable(arg1:Boolean):void
        {
            this.enableInputs(arg1);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.bottomLogos = this.copyright.logos;
            if (this.bg_image != null)
                this.bg_image.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onLoadingImageCompleteHandler, false, 0, true);
            var loc1:*=App.globalVarsMgr.getLocaleOverrideS();
            if (loc1)
            {
                this.wotLogo.setLocale(loc1);
                this.bottomLogos.setLocale(loc1);
            }
            this.updateContent();
            this.createSparks();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            this.initLoginForm();
            this.enableInputs(true);
            App.utils.scheduler.envokeInNextFrame(this.initFocus);
            alpha = 1;
            this.keyMappings = App.utils.commons.createMap([flash.ui.Keyboard.ESCAPE, this.onEscapeKeyPress, flash.ui.Keyboard.ENTER, this.onEnterKeyPress]);
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this.bg_image.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.onLoadingImageCompleteHandler);
            this.bg_image.dispose();
            this.bg_image = null;
            this.wotLogo.dispose();
            this.wotLogo = null;
            this.bottomLogos.dispose();
            this.bottomLogos = null;
            this.version = null;
            this.sparksMc = null;
            this.shadow = null;
            this.copyright = null;
            this.disposeLoginForm();
            this.enableInputs(false);
            this.keyMappings.clear();
            this.keyMappings = null;
            if (this._sparksManager)
            {
                this._sparksManager.dispose();
                this._sparksManager = null;
            }
            return;
        }

        internal function disposeLoginForm():void
        {
            this.form.submit.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSubmitButtonClick);
            this.form.removeChangeHandler(this.onChange);
            this.form.removeEventListener(net.wg.gui.login.impl.LoginEvent.TOKEN_RESET, this.onNeedTokenReset);
            this.form.rememberPwdCheckbox.removeEventListener(flash.events.Event.SELECT, this.onRememberPwdCheckboxToggle);
            this.form.registerLink.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onRegisterLinkClick);
            this.form.recoveryLink.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onRecoveryLinkClick);
            this.form.message.removeEventListener(flash.events.TextEvent.LINK, this.onMessageLinkClick);
            this.form.message.removeEventListener(flash.events.MouseEvent.CLICK, this.onMessageTextClick);
            this.form.dispose();
            App.utils.commons.releaseReferences(this.form);
            this.form = null;
            return;
        }

        internal function initLoginForm():void
        {
            this.form.submit.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onSubmitButtonClick);
            this.form.addChangeHandler(this.onChange);
            this.form.addEventListener(net.wg.gui.login.impl.LoginEvent.TOKEN_RESET, this.onNeedTokenReset);
            this.form.rememberPwdCheckbox.addEventListener(flash.events.Event.SELECT, this.onRememberPwdCheckboxToggle);
            this.form.registerLink.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onRegisterLinkClick);
            this.form.recoveryLink.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onRecoveryLinkClick);
            this.form.message.addEventListener(flash.events.TextEvent.LINK, this.onMessageLinkClick);
            this.form.message.addEventListener(flash.events.MouseEvent.CLICK, this.onMessageTextClick);
            return;
        }

        internal function onEscapeKeyPress():void
        {
            onEscapeS();
            return;
        }

        internal function onEnterKeyPress():void
        {
            this.submit();
            return;
        }

        internal function updateContent():void
        {
            this.set_position_wallpaper();
            this.form.x = App.appWidth >> 1;
            this.form.y = Math.round(App.appHeight * FREE_SPACE_FACTOR + (App.appHeight - net.wg.data.constants.LobbyMetrics.MIN_STAGE_HEIGHT) * FREE_SPACE_BORDER_FACTOR);
            this.wotLogo.x = this.form.x - 3;
            this.wotLogo.y = this.form.y - 123;
            this.shadow.x = this.form.x - 288;
            this.shadow.y = this.form.y - 331;
            this.copyright.x = this.form.x - 2;
            this.copyright.y = App.appHeight - 29;
            invalidateSize();
            return;
        }

        internal function set_position_wallpaper():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (this.useWallpaper)
                if (this.bg_image)
                {
                    loc1 = App.appWidth / 1920;
                    loc2 = App.appHeight / 1200;
                    loc3 = 1;
                    if (loc1 > loc2)
                        loc3 = loc2;
                    else
                        loc3 = loc1;
                    var loc4:*;
                    this.bg_image.scaleY = loc4 = loc3;
                    this.bg_image.scaleX = loc4;
                    this.bg_image.x = App.appWidth - this.bg_image.width >> 1;
                    this.bg_image.y = App.appHeight - this.bg_image.height >> 1;
                }
            else
            {
                this.bg_image.scaleY = loc4 = 1;
                this.bg_image.scaleX = loc4;
                this.bg_image.x = App.appWidth - this.bg_image.width >> 1;
                this.bg_image.y = App.appHeight - this.bg_image.height >> 1;
            }
            return;
        }

        internal function submit():void
        {
            var loc1:*=this.getLogin();
            var loc2:*=this.getPass();
            var loc3:*=this.getSelectedServerName();
            trace(isPwdInvalidS(loc2));
            if (loc1 != "")
                if (isPwdInvalidS(loc2))
                    this.form.setErrorMessage(MENU.LOGIN_STATUS_INVALID_PASSWORD, ErrorStates.PASSWORD_INVALID);
                else if (loc3 != "")
                {
                    this.form.setErrorMessage(MENU.LOGIN_STATUS_CONNECTING, ErrorStates.NONE);
                    onLoginS(loc1, loc2, loc3);
                }
                else
                    this.form.setErrorMessage(MENU.LOGIN_STATUS_EMPTY_SERVER, ErrorStates.NONE);
            else
                this.form.setErrorMessage(MENU.LOGIN_STATUS_EMPTY_LOGIN, ErrorStates.LOGIN_INVALID);
            return;
        }

        internal function enableInputs(arg1:Boolean):void
        {
            if (arg1)
                addEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput);
            else
                removeEventListener(scaleform.clik.events.InputEvent.INPUT, this.handleInput);
            return;
        }

        internal function createSparks():void
        {
            var loc1:*=null;
            if (this._sparksManager == null)
            {
                loc1 = {"scope":this.sparksMc, "sparkQuantity":SPARK_QUANTITY, "zone":this.getSparkZone()};
                this._sparksManager = net.wg.gui.login.ISparksManager(App.utils.classFactory.getObject(net.wg.data.constants.Linkages.SPARKS_MGR, loc1));
                this._sparksManager.createSparks();
                this.sparksMc.visible = true;
            }
            return;
        }

        internal function getSparkZone():flash.geom.Rectangle
        {
            return new flash.geom.Rectangle(SPARK_ZONE.x, SPARK_ZONE.y, stage.width + SPARK_ZONE.right, stage.height + SPARK_ZONE.bottom);
        }

        internal function getLogin():String
        {
            return this.form.login.text;
        }

        internal function getPass():String
        {
            return this.form.pass.text;
        }

        internal function getSelectedServerName():String
        {
            return this.form.getSelectedServerName();
        }

        internal static const FREE_SPACE_FACTOR:Number=0.6;

        internal static const FREE_SPACE_BORDER_FACTOR:Number=0.18;

        internal static const SPARK_ZONE:flash.geom.Rectangle=new flash.geom.Rectangle(100, 0, -200, -100);

        internal static const SPARK_QUANTITY:uint=150;

        internal static const MIN_PWD_LEN:int=6;

        internal static const SPECIAL_SYMBOLS:String="~`!@#$%^&*()|\\/,.;:\"\'";

        public var bg_image:net.wg.gui.components.controls.UILoaderAlt=null;

        public var sparksMc:flash.display.MovieClip=null;

        public var form:net.wg.gui.login.ILoginForm=null;

        public var version:flash.text.TextField=null;

        public var wotLogo:net.wg.gui.components.common.BaseLogoView=null;

        public var shadow:flash.display.MovieClip=null;

        public var bottomLogos:net.wg.gui.components.common.BaseLogoView=null;

        internal var useWallpaper:Boolean=true;

        internal var _sparksManager:net.wg.gui.login.ISparksManager=null;

        internal var keyMappings:org.idmedia.as3commons.util.Map=null;

        internal var isTFClickedByMBR:Boolean=false;

        public var copyright:flash.display.MovieClip=null;
    }
}
