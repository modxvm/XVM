package net.wg.gui.lobby.window
{
   import net.wg.infrastructure.base.meta.impl.ProfileWindowMeta;
   import net.wg.infrastructure.base.meta.IProfileWindowMeta;
   import net.wg.gui.lobby.profile.ProfileTabNavigator;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.display.Sprite;
   import net.wg.utils.ILocale;
   import net.wg.data.Aliases;
   import net.wg.gui.lobby.profile.ProfileConstants;
   import flash.events.MouseEvent;
   import net.wg.data.gui_items.dossier.AccountDossier;
   import net.wg.infrastructure.interfaces.IWindow;
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

      public var tabNavigator:ProfileTabNavigator;

      public var maskObj:MovieClip;

      private var initData:ProfileWindowInitVO;

      private var isAddFriendAvailable:Boolean;

      private var isSetIgnoreAvailable:Boolean;

      public var btnAddToFriends:SoundButtonEx;

      public var btnAddToIgnore:SoundButtonEx;

      public var btnCreatePrivateChannel:SoundButtonEx;

      public var background:Sprite;

      override protected function configUI() : void {
         super.configUI();
         try
         {
            registerComponent(this.tabNavigator,Aliases.PROFILE_TAB_NAVIGATOR);
         }
         catch(e:Error)
         {
            trace(e);
         }
         this.tabNavigator.centerOffset = ProfileConstants.WINDOW_CENTER_OFFSET;
         var locale:ILocale = App.utils.locale;
         this.btnAddToFriends.label = locale.makeString(MESSENGER.DIALOGS_CONTACTS_CONTACT_ADDTOFRIENDS);
         this.btnAddToIgnore.label = locale.makeString(MESSENGER.DIALOGS_CONTACTS_CONTACT_ADDTOIGNORED);
         this.btnCreatePrivateChannel.label = locale.makeString(MESSENGER.DIALOGS_CONTACTS_CONTACT_CREATEPRIVATECHANNEL);
         this.btnAddToFriends.addEventListener(MouseEvent.CLICK,this.addToFriendBtnHandler,false,0,true);
         this.btnAddToIgnore.addEventListener(MouseEvent.CLICK,this.addToIgnoreBtnHandler,false,0,true);
         this.btnCreatePrivateChannel.addEventListener(MouseEvent.CLICK,this.createPrivateChannelBtnHandler,false,0,true);
      }

      private function createPrivateChannelBtnHandler(param1:MouseEvent) : void {
         this.userCreatePrivateChannelS();
      }

      private function addToIgnoreBtnHandler(param1:MouseEvent) : void {
         this.userSetIgnoredS();
      }

      private function addToFriendBtnHandler(param1:MouseEvent) : void {
         this.userAddFriendS();
      }

      public function as_setInitData(param1:Object) : void {
         this.initData = new ProfileWindowInitVO(param1);
         invalidate(INIT_DATA_INV);
      }

      public function as_update(param1:Object) : void {
         var _loc2_:String = param1?param1.toString():null;
         var _loc3_:AccountDossier = new AccountDossier(_loc2_);
         this.tabNavigator.viewStack.updateData(_loc3_);
      }

      override public function set window(param1:IWindow) : void {
         super.window = param1;
         if(param1)
         {
            invalidate(INIT_DATA_INV);
         }
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
      }

      override protected function onDispose() : void {
         this.btnAddToFriends.removeEventListener(MouseEvent.CLICK,this.addToFriendBtnHandler);
         this.btnAddToIgnore.removeEventListener(MouseEvent.CLICK,this.addToIgnoreBtnHandler);
         this.btnCreatePrivateChannel.removeEventListener(MouseEvent.CLICK,this.createPrivateChannelBtnHandler);
         super.onDispose();
      }

      public function as_addFriendAvailable(param1:Boolean) : void {
         this.isAddFriendAvailable = param1;
         invalidate(ADDFRIENDAVAILABLE);
      }

      public function as_setIgnoredAvailable(param1:Boolean) : void {
         this.isSetIgnoreAvailable = param1;
         invalidate(SETIGNOREDAVAILABLE);
      }
   }

}