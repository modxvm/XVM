package net.wg.gui.lobby.profile
{
   import net.wg.infrastructure.base.meta.impl.ProfileMeta;
   import net.wg.infrastructure.base.meta.IProfileMeta;
   import flash.display.Sprite;
   import scaleform.clik.events.InputEvent;
   import net.wg.data.Aliases;
   import flash.ui.Keyboard;
   import flash.events.KeyboardEvent;
   import net.wg.data.gui_items.dossier.AccountDossier;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.LobbyMetrics;


   public class Profile extends ProfileMeta implements IProfileMeta
   {
          
      public function Profile() {
         super();
      }

      public var background:Sprite;

      public var headerBackground:Sprite;

      public var mainBackground:Sprite;

      public var tabNavigator:ProfileTabNavigator;

      private function handleEscape(param1:InputEvent) : void {
         onCloseProfileS();
      }

      override protected function configUI() : void {
         super.configUI();
         registerComponent(this.tabNavigator,Aliases.PROFILE_TAB_NAVIGATOR);
         this.tabNavigator.centerOffset = ProfileConstants.MAIN_CENTER_OFFSET;
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
      }

      public function as_update(param1:Object) : void {
         var _loc2_:String = param1?param1.toString():null;
         var _loc3_:AccountDossier = new AccountDossier(_loc2_);
         this.tabNavigator.viewStack.updateData(_loc3_);
      }

      override public function updateStage(param1:Number, param2:Number) : void {
         setViewSize(param1,param2);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.background.width = _width;
            this.background.height = _height + LobbyMetrics.LOBBY_MESSENGER_HEIGHT;
            this.tabNavigator.setAvailableSize(_width,_height - this.tabNavigator.y);
            this.headerBackground.x = _width - this.headerBackground.width >> 1;
            this.mainBackground.x = _width - this.mainBackground.width >> 1;
         }
      }

      override protected function onDispose() : void {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN);
         super.onDispose();
      }
   }

}