package net.wg.gui.login.impl
{
    import net.wg.infrastructure.base.meta.impl.LoginPageMeta;
    import net.wg.infrastructure.base.meta.ILoginPageMeta;
    import flash.geom.Rectangle;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.MovieClip;
    import net.wg.gui.login.ILoginForm;
    import flash.text.TextField;
    import net.wg.gui.components.common.BaseLogoView;
    import net.wg.gui.login.impl.components.Copyright;
    import net.wg.gui.login.impl.components.RssNewsFeed;
    import net.wg.gui.login.ISparksManager;
    import org.idmedia.as3commons.util.Map;
    import flash.display.InteractiveObject;
    import net.wg.gui.login.impl.components.RssItemEvent;
    import net.wg.gui.events.UILoaderEvent;
    import net.wg.gui.login.impl.components.CopyrightEvent;
    import net.wg.data.Aliases;
    import flash.ui.Keyboard;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.Event;
    import flash.events.TextEvent;
    import flash.events.MouseEvent;
    import net.wg.data.constants.LobbyMetrics;
    import scaleform.clik.events.InputEvent;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.constants.InputValue;
    
    public class LoginPage extends LoginPageMeta implements ILoginPageMeta
    {
        
        public function LoginPage() {
            super();
        }
        
        private static var FREE_SPACE_FACTOR:Number = 0.6;
        
        private static var FREE_SPACE_BORDER_FACTOR:Number = 0.18;
        
        private static var SPARK_ZONE:Rectangle;
        
        private static var SPARK_QUANTITY:uint = 150;
        
        private static var MIN_PWD_LEN:int = 6;
        
        private static var SPECIAL_SYMBOLS:String = "~`!@#$%^&*()|\\/,.;:\"\'";
        
        public var bg_image:UILoaderAlt = null;
        
        public var sparksMc:MovieClip = null;
        
        public var form:ILoginForm = null;
        
        public var version:TextField = null;
        
        public var wotLogo:BaseLogoView = null;
        
        public var shadow:MovieClip = null;
        
        public var copyright:Copyright = null;
        
        public var bottomLogos:BaseLogoView = null;
        
        public var rssNewsFeed:RssNewsFeed = null;
        
        private var useWallpaper:Boolean = true;
        
        private var _sparksManager:ISparksManager = null;
        
        private var keyMappings:Map = null;
        
        private var isTFClickedByMBR:Boolean = false;
        
        private var focusInited:Boolean = false;
        
        override public function updateStage(param1:Number, param2:Number) : void {
            this.updateContent();
            if(this._sparksManager)
            {
                this._sparksManager.resetZone(this.getSparkZone());
            }
        }
        
        override protected function onSetModalFocus(param1:InteractiveObject) : void {
            super.onSetModalFocus(param1);
        }
        
        override protected function onInitModalFocus(param1:InteractiveObject) : void {
            super.onInitModalFocus(param1);
            this.initFocus();
        }
        
        public function as_setDefaultValues(param1:String, param2:String, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean) : void {
            this.form.setDefaultValues(param1,param2,param3,param4,param5,param6);
        }
        
        public function as_setErrorMessage(param1:String, param2:int) : void {
            this.setErrorMessage(param1,param2);
        }
        
        public function as_setServersList(param1:Array, param2:int) : void {
            assertNotNull(param1);
            assert(param2 >= -1,"selectedIdx must be greater then -2");
            this.form.setServersList(param1,param2);
        }
        
        public function as_setVersion(param1:String) : void {
            assertNotNull(param1);
            this.version.text = param1;
        }
        
        public function as_showWallpaper(param1:Boolean, param2:String) : void {
            visible = false;
            this.bg_image.source = param2;
            this.useWallpaper = param1;
            if(this.useWallpaper)
            {
                invalidate();
            }
            else
            {
                this.bg_image.autoSize = true;
                invalidate();
                this.sparksMc.visible = false;
            }
        }
        
        public function as_setCopyright(param1:String, param2:String) : void {
            this.copyright.updateLabel(param1,param2);
            this.updateContent();
        }
        
        public function as_setCapsLockState(param1:Boolean) : void {
            this.form.setCapsLockState(param1);
        }
        
        public function as_setKeyboardLang(param1:String) : void {
            this.form.setKeyboardLang(param1);
        }
        
        public function as_cancelLoginQueue() : void {
            DebugUtils.LOG_DEBUG("as_cancelLoginQueue");
        }
        
        public function as_doAutoLogin() : void {
            DebugUtils.LOG_DEBUG("as_doAutoLogin");
            this.submit();
        }
        
        public function as_enable(param1:Boolean) : void {
            this.enableInputs(param1);
        }
        
        override protected function allowHandleInput() : Boolean {
            return false;
        }
        
        override protected function configUI() : void {
            super.configUI();
            this.bottomLogos = this.copyright.logos as BaseLogoView;
            this.rssNewsFeed.addEventListener(RssItemEvent.ITEM_SIZE_INVALID,this.rssSizeInvalid);
            if(this.bg_image != null)
            {
                this.bg_image.addEventListener(UILoaderEvent.COMPLETE,this.onLoadingImageCompleteHandler,false,0,true);
            }
            var _loc1_:String = App.globalVarsMgr.getLocaleOverrideS();
            if(_loc1_)
            {
                this.wotLogo.setLocale(_loc1_);
                this.bottomLogos.setLocale(_loc1_);
            }
            this.copyright.addEventListener(CopyrightEvent.TO_LEGAL,this.toLegalOpen);
            this.updateContent();
            this.createSparks();
        }
        
        private function toLegalOpen(param1:CopyrightEvent) : void {
            showLegalS();
        }
        
        private function rssSizeInvalid(param1:RssItemEvent) : void {
            this.updateRssPositions();
        }
        
        override protected function draw() : void {
            super.draw();
        }
        
        override protected function onPopulate() : void {
            super.onPopulate();
            registerComponent(this.rssNewsFeed,Aliases.RSS_NEWS_FEED);
            this.initLoginForm();
            alpha = 1;
            this.keyMappings = App.utils.commons.createMap([Keyboard.ESCAPE,this.onEscapeKeyPress,Keyboard.ENTER,this.onEnterKeyPress]);
        }
        
        override protected function onDispose() : void {
            this.bg_image.removeEventListener(UILoaderEvent.COMPLETE,this.onLoadingImageCompleteHandler);
            this.bg_image.dispose();
            this.bg_image = null;
            this.wotLogo.dispose();
            this.wotLogo = null;
            this.bottomLogos.dispose();
            this.bottomLogos = null;
            this.version = null;
            this.sparksMc = null;
            this.shadow = null;
            this.copyright.removeEventListener(CopyrightEvent.TO_LEGAL,this.toLegalOpen);
            this.copyright.dispose();
            this.copyright = null;
            this.rssNewsFeed.removeEventListener(RssItemEvent.ITEM_SIZE_INVALID,this.rssSizeInvalid);
            this.rssNewsFeed = null;
            this.disposeLoginForm();
            this.enableInputs(false);
            this.keyMappings.clear();
            this.keyMappings = null;
            App.utils.scheduler.cancelTask(onEscapeS);
            App.utils.scheduler.cancelTask(this.enableInputs);
            if(this._sparksManager)
            {
                this._sparksManager.dispose();
                this._sparksManager = null;
            }
            super.onDispose();
        }
        
        private function setErrorMessage(param1:String, param2:int) : void {
            this.form.setErrorMessage(param1,param2);
            this.initFocus();
        }
        
        private function disposeLoginForm() : void {
            this.form.submit.removeEventListener(ButtonEvent.CLICK,this.onSubmitButtonClick);
            this.form.removeChangeHandler(this.onChange);
            this.form.removeEventListener(LoginEvent.TOKEN_RESET,this.onNeedTokenReset);
            this.form.rememberPwdCheckbox.removeEventListener(Event.SELECT,this.onRememberPwdCheckboxToggle);
            this.form.registerLink.removeEventListener(ButtonEvent.CLICK,this.onRegisterLinkClick);
            this.form.recoveryLink.removeEventListener(ButtonEvent.CLICK,this.onRecoveryLinkClick);
            this.form.message.removeEventListener(TextEvent.LINK,this.onMessageLinkClick);
            this.form.message.removeEventListener(MouseEvent.CLICK,this.onMessageTextClick);
            this.form.dispose();
            App.utils.commons.releaseReferences(this.form);
            this.form = null;
        }
        
        private function initLoginForm() : void {
            this.form.submit.addEventListener(ButtonEvent.CLICK,this.onSubmitButtonClick);
            this.form.addChangeHandler(this.onChange);
            this.form.addEventListener(LoginEvent.TOKEN_RESET,this.onNeedTokenReset);
            this.form.rememberPwdCheckbox.addEventListener(Event.SELECT,this.onRememberPwdCheckboxToggle);
            this.form.registerLink.addEventListener(ButtonEvent.CLICK,this.onRegisterLinkClick);
            this.form.recoveryLink.addEventListener(ButtonEvent.CLICK,this.onRecoveryLinkClick);
            this.form.message.addEventListener(TextEvent.LINK,this.onMessageLinkClick);
            this.form.message.addEventListener(MouseEvent.CLICK,this.onMessageTextClick);
        }
        
        private function onEscapeKeyPress() : void {
            this.enableInputs(false);
            App.utils.scheduler.scheduleTask(onEscapeS,50);
            App.utils.scheduler.scheduleTask(this.enableInputs,200,true);
        }
        
        private function onEnterKeyPress() : void {
            this.submit();
        }
        
        private function updateContent() : void {
            this.set_position_wallpaper();
            this.form.x = App.appWidth >> 1;
            this.form.y = Math.round(App.appHeight * FREE_SPACE_FACTOR + (App.appHeight - LobbyMetrics.MIN_STAGE_HEIGHT) * FREE_SPACE_BORDER_FACTOR);
            this.wotLogo.x = this.form.x - 3;
            this.wotLogo.y = this.form.y - 123;
            this.shadow.x = this.form.x - 288;
            this.shadow.y = this.form.y - 331;
            this.copyright.x = this.form.x - 2;
            this.copyright.y = App.appHeight - 29;
            this.updateRssPositions();
            invalidateSize();
        }
        
        private function updateRssPositions() : void {
            this.rssNewsFeed.x = App.appWidth - this.rssNewsFeed.actualWidth;
            this.rssNewsFeed.y = App.appHeight;
        }
        
        private function set_position_wallpaper() : void {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            var _loc3_:* = NaN;
            if(this.useWallpaper)
            {
                if(this.bg_image)
                {
                    _loc1_ = App.appWidth / 1920;
                    _loc2_ = App.appHeight / 1200;
                    _loc3_ = 1;
                    if(_loc1_ > _loc2_)
                    {
                        _loc3_ = _loc2_;
                    }
                    else
                    {
                        _loc3_ = _loc1_;
                    }
                    this.bg_image.scaleX = this.bg_image.scaleY = _loc3_;
                    this.bg_image.x = App.appWidth - this.bg_image.width >> 1;
                    this.bg_image.y = App.appHeight - this.bg_image.height >> 1;
                }
            }
            else
            {
                this.bg_image.scaleX = this.bg_image.scaleY = 1;
                this.bg_image.x = App.appWidth - this.bg_image.width >> 1;
                this.bg_image.y = App.appHeight - this.bg_image.height >> 1;
            }
        }
        
        private function submit() : void {
            var _loc1_:String = this.getLogin();
            var _loc2_:String = this.getPass();
            var _loc3_:String = this.getSelectedServerName();
            if(_loc1_ == "")
            {
                this.setErrorMessage(MENU.LOGIN_STATUS_EMPTY_LOGIN,ErrorStates.LOGIN_INVALID);
            }
            else if(isPwdInvalidS(_loc2_))
            {
                this.setErrorMessage(MENU.LOGIN_STATUS_INVALID_PASSWORD,ErrorStates.PASSWORD_INVALID);
            }
            else if(_loc3_ == "")
            {
                this.setErrorMessage(MENU.LOGIN_STATUS_EMPTY_SERVER,ErrorStates.NONE);
            }
            else
            {
                this.setErrorMessage(MENU.LOGIN_STATUS_CONNECTING,ErrorStates.NONE);
                onLoginS(_loc1_,_loc2_,_loc3_);
            }
            
            
        }
        
        private function enableInputs(param1:Boolean) : void {
            if(param1)
            {
                addEventListener(InputEvent.INPUT,this.handleInput);
                this.initFocus();
            }
            else
            {
                removeEventListener(InputEvent.INPUT,this.handleInput);
            }
        }
        
        private function createSparks() : void {
            var _loc1_:Object = null;
            if(this._sparksManager == null)
            {
                _loc1_ = {
                    "scope":this.sparksMc,
                    "sparkQuantity":SPARK_QUANTITY,
                    "zone":this.getSparkZone()
                };
            this._sparksManager = ISparksManager(App.utils.classFactory.getObject(Linkages.SPARKS_MGR,_loc1_));
            this._sparksManager.createSparks();
            this.sparksMc.visible = true;
        }
    }
    
    private function getSparkZone() : Rectangle {
        return new Rectangle(SPARK_ZONE.x,SPARK_ZONE.y,stage.width + SPARK_ZONE.right,stage.height + SPARK_ZONE.bottom);
    }
    
    private function getLogin() : String {
        return this.form.login.text;
    }
    
    private function getPass() : String {
        return this.form.pass.text;
    }
    
    private function getSelectedServerName() : String {
        return this.form.getSelectedServerName();
    }
    
    private function initFocus() : void {
        assertLifeCycle();
        if(!this.focusInited)
        {
            if(this.form.login.text.length == 0 || (this.form.login.highlight))
            {
                setFocus(this.form.login);
            }
            else
            {
                setFocus(this.form.pass);
            }
            this.focusInited = true;
        }
    }
    
    private function onSubmitButtonClick(param1:ButtonEvent) : void {
        this.submit();
    }
    
    private function onChange(param1:Event) : void {
        var event:Event = param1;
        var isToken:Boolean = isTokenS();
        try
        {
            onExitFromAutoLoginS();
            this.form.update(event.target,isToken);
        }
        catch(e:Error)
        {
            DebugUtils.LOG_ERROR(e.message);
        }
    }
    
    private function onRememberPwdCheckboxToggle(param1:Event) : void {
        onSetRememberPasswordS(this.form.rememberPwdCheckbox.selected);
    }
    
    private function onRegisterLinkClick(param1:ButtonEvent) : void {
        onRegisterS();
    }
    
    private function onRecoveryLinkClick(param1:ButtonEvent) : void {
        onRecoveryS();
    }
    
    private function onMessageLinkClick(param1:TextEvent) : void {
        if(this.isTFClickedByMBR)
        {
            return;
        }
        switch(param1.text)
        {
            case "passwordRecovery":
                onRecoveryS();
                break;
        }
    }
    
    private function onMessageTextClick(param1:MouseEvent) : void {
        this.isTFClickedByMBR = App.utils.commons.isRightButton(param1);
    }
    
    private function onQueueDialogQuitClose(param1:MouseEvent) : void {
        this.form.setErrorMessage("",ErrorStates.NONE);
        onExitFromAutoLogin();
    }
    
    private function onNeedTokenReset(param1:LoginEvent) : void {
        resetTokenS();
    }
    
    private function onLoadingImageCompleteHandler(param1:UILoaderEvent) : void {
        this.set_position_wallpaper();
        visible = true;
        invalidate();
    }
    
    override public function handleInput(param1:InputEvent) : void {
        var _loc2_:Function = null;
        super.handleInput(param1);
        if((param1.handled) || (App.waiting.isOnStage))
        {
            return;
        }
        if(param1.details.value == InputValue.KEY_DOWN)
        {
            _loc2_ = this.keyMappings.get(param1.details.code);
            if(_loc2_ != null)
            {
                _loc2_();
                param1.handled = true;
            }
        }
    }
}
}
