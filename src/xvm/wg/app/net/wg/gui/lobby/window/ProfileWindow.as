package net.wg.gui.lobby.window
{
   import net.wg.infrastructure.base.meta.impl.ProfileWindowMeta;
   import net.wg.infrastructure.base.meta.IProfileWindowMeta;
   import net.wg.gui.lobby.profile.ProfileTabNavigator;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.advanced.TabButton;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.utils.ILocale;
   import net.wg.data.Aliases;
   import net.wg.gui.lobby.profile.ProfileConstants;
   import scaleform.clik.events.ButtonEvent;
   import flash.display.Graphics;
   import net.wg.gui.components.windows.Window;
   import scaleform.clik.constants.InvalidationType;
   
   public class ProfileWindow extends ProfileWindowMeta implements IProfileWindowMeta
   {
      
      public function ProfileWindow() {
         this.maskObj = new MovieClip();
         super();
         isModal = false;
         canResize = false;
         canMinimize = false;
         isCentered = true;
         showWindowBg = false;
         addChild(this.maskObj);
      }
      
      public static const INIT_DATA_INV:String = "initDataInv";
      
      public static const ADDFRIENDAVAILABLE:String = "addAvailableChanged";
      
      public static const SETIGNOREDAVAILABLE:String = "setIgnoreChanged";
      
      public static const CREATEPRIVATECHANNELAVAILABLE:String = "createChannelChanged";
      
      public var tabNavigator:ProfileTabNavigator;
      
      public var maskObj:MovieClip;
      
      public var btnAddToFriends:SoundButtonEx;
      
      public var btnAddToIgnore:SoundButtonEx;
      
      public var btnCreatePrivateChannel:SoundButtonEx;
      
      public var btnTemplate:TabButton;
      
      public var background:Sprite;
      
      private var initData:ProfileWindowInitVO;
      
      private var isAddFriendAvailable:Boolean;
      
      private var isSetIgnoreAvailable:Boolean;
      
      private var isCreateChannelAvailable:Boolean;
      
      override public function setWindow(param1:IWindow) : void {
         super.setWindow(param1);
         if(param1)
         {
            invalidate(INIT_DATA_INV);
         }
      }
      
      public function as_setInitData(param1:Object) : void {
         this.initData = new ProfileWindowInitVO(param1);
         invalidate(INIT_DATA_INV);
      }
      
      public function as_update(param1:Object) : void {
      }
      
      public function as_addFriendAvailable(param1:Boolean) : void {
         this.isAddFriendAvailable = param1;
         invalidate(ADDFRIENDAVAILABLE);
      }
      
      public function as_setIgnoredAvailable(param1:Boolean) : void {
         this.isSetIgnoreAvailable = param1;
         invalidate(SETIGNOREDAVAILABLE);
      }
      
      public function as_setCreateChannelAvailable(param1:Boolean) : void {
         this.isCreateChannelAvailable = param1;
         invalidate(CREATEPRIVATECHANNELAVAILABLE);
      }
      
      override protected function configUI() : void {
         super.configUI();
         this.removeTemplateButton();
         try
         {
            registerComponent(this.tabNavigator,Aliases.PROFILE_TAB_NAVIGATOR);
         }
         catch(e:Error)
         {
         }
         this.tabNavigator.centerOffset = ProfileConstants.WINDOW_CENTER_OFFSET;
         var locale:ILocale = App.utils.locale;
         this.btnAddToFriends.label = locale.makeString(MESSENGER.DIALOGS_CONTACTS_CONTACT_ADDTOFRIENDS);
         this.btnAddToIgnore.label = locale.makeString(MESSENGER.DIALOGS_CONTACTS_CONTACT_ADDTOIGNORED);
         this.btnCreatePrivateChannel.label = locale.makeString(MESSENGER.DIALOGS_CONTACTS_CONTACT_CREATEPRIVATECHANNEL);
         this.btnAddToFriends.addEventListener(ButtonEvent.CLICK,this.addToFriendBtnHandler,false,0,true);
         this.btnAddToIgnore.addEventListener(ButtonEvent.CLICK,this.addToIgnoreBtnHandler,false,0,true);
         this.btnCreatePrivateChannel.addEventListener(ButtonEvent.CLICK,this.createPrivateChannelBtnHandler,false,0,true);
      }
      
      override protected function draw() : void {
         var _loc1_:Graphics = null;
         var _loc2_:* = NaN;
         super.draw();
         if((isInvalid(INIT_DATA_INV)) && (window) && (this.initData))
         {
            Window(window).title = this.initData.fullName;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this.maskObj.graphics;
            _loc1_.clear();
            _loc1_.beginFill(0);
            _loc2_ = this.background.y + this.background.height;
            _loc1_.drawRect(0,0,this.background.width,_loc2_);
            _loc1_.endFill();
            if(!this.mask)
            {
               this.tabNavigator.mask = this.maskObj;
            }
            this.tabNavigator.setAvailableSize(this.background.width,_loc2_);
         }
         if(isInvalid(ADDFRIENDAVAILABLE))
         {
            this.btnAddToFriends.enabled = this.isAddFriendAvailable;
         }
         if(isInvalid(SETIGNOREDAVAILABLE))
         {
            this.btnAddToIgnore.enabled = this.isSetIgnoreAvailable;
         }
         if(isInvalid(CREATEPRIVATECHANNELAVAILABLE))
         {
            this.btnCreatePrivateChannel.enabled = this.isCreateChannelAvailable;
         }
      }
      
      override protected function onDispose() : void {
         this.tabNavigator.mask = null;
         if(this.maskObj)
         {
            this.maskObj.parent.removeChild(this.maskObj);
            this.maskObj = null;
         }
         if(this.background)
         {
            this.background.parent.removeChild(this.background);
            this.background = null;
         }
         this.removeTemplateButton();
         if(this.initData)
         {
            this.initData.dispose();
            this.initData = null;
         }
         this.tabNavigator = null;
         this.btnAddToFriends.removeEventListener(ButtonEvent.CLICK,this.addToFriendBtnHandler);
         this.btnAddToIgnore.removeEventListener(ButtonEvent.CLICK,this.addToIgnoreBtnHandler);
         this.btnCreatePrivateChannel.removeEventListener(ButtonEvent.CLICK,this.createPrivateChannelBtnHandler);
         this.btnAddToFriends.dispose();
         this.btnAddToIgnore.dispose();
         this.btnCreatePrivateChannel.dispose();
         super.onDispose();
      }
      
      private function removeTemplateButton() : void {
         if(this.btnTemplate)
         {
            this.btnTemplate.parent.removeChild(this.btnTemplate);
            this.btnTemplate.dispose();
            this.btnTemplate = null;
         }
      }
      
      private function createPrivateChannelBtnHandler(param1:ButtonEvent) : void {
         this.userCreatePrivateChannelS();
      }
      
      private function addToIgnoreBtnHandler(param1:ButtonEvent) : void {
         this.userSetIgnoredS();
      }
      
      private function addToFriendBtnHandler(param1:ButtonEvent) : void {
         this.userAddFriendS();
      }
   }
}
