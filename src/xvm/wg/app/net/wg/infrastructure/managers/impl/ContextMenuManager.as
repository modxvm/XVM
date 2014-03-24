package net.wg.infrastructure.managers.impl
{
   import net.wg.infrastructure.base.meta.impl.ContextMenuManagerMeta;
   import net.wg.infrastructure.managers.IContextMenuManager;
   import net.wg.infrastructure.interfaces.IContextMenu;
   import __AS3__.vec.Vector;
   import net.wg.infrastructure.interfaces.IContextItem;
   import flash.display.DisplayObject;
   import net.wg.utils.IClassFactory;
   import net.wg.data.constants.Linkages;
   import flash.geom.Point;
   import net.wg.gui.events.ContextMenuEvent;
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.IUserContextMenuGenerator;
   import net.wg.data.daapi.PlayerInfo;
   import net.wg.infrastructure.interfaces.entity.IDisposable;


   public class ContextMenuManager extends ContextMenuManagerMeta implements IContextMenuManager
   {
          
      public function ContextMenuManager() {
         super();
      }

      private var _currentMenu:IContextMenu = null;

      private var _handler:Function = null;

      private var _extraHandler:Function = null;

      private var _data:Object = null;

      public function show(param1:Vector.<IContextItem>, param2:DisplayObject, param3:Function=null, param4:Object=null) : IContextMenu {
         this.hide();
         this._handler = param3;
         var _loc5_:IClassFactory = App.utils.classFactory;
         this._currentMenu = _loc5_.getComponent(Linkages.CONTEXT_MENU,IContextMenu);
         App.utils.popupMgr.show(DisplayObject(this._currentMenu),param2.mouseX,param2.mouseY);
         var _loc6_:Point = param2.localToGlobal(new Point(param2.mouseX,param2.mouseY));
         this._currentMenu.build(param1,_loc6_.x,_loc6_.y);
         if(param4)
         {
            this._currentMenu.setMemberItemData(param4);
         }
         if(this._handler != null)
         {
            DisplayObject(this._currentMenu).addEventListener(ContextMenuEvent.ON_ITEM_SELECT,this.onContextMenuAction);
         }
         DisplayObject(this._currentMenu).addEventListener(ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE,this.destroy);
         DisplayObject(this._currentMenu).stage.addEventListener(Event.RESIZE,this.destroy);
         return this._currentMenu;
      }

      public function showUserContextMenu(param1:DisplayObject, param2:Object, param3:IUserContextMenuGenerator, param4:Function=null) : IContextMenu {
         var _loc5_:PlayerInfo = null;
         var _loc6_:* = NaN;
         var _loc7_:Vector.<IContextItem> = null;
         if(param2.uid > -1 && !param2.himself)
         {
            _loc5_ = new PlayerInfo(_getUserInfoS(param2.uid,param2.userName));
            _loc6_ = _getDenunciationsS();
            _loc7_ = param3.generateData(_loc5_,_loc6_);
            this._extraHandler = param4;
            return this.show(_loc7_,param1,this.handleUserContextMenu,param2);
         }
         return null;
      }

      public function showFortificationCtxMenu(param1:DisplayObject, param2:Vector.<IContextItem>) : IContextMenu {
         return this.show(param2,param1,this.handleUserContextMenu);
      }

      private function handleUserContextMenu(param1:ContextMenuEvent) : void {
         var _loc2_:Object = param1.memberItemData;
         switch(param1.id)
         {
            case "userInfo":
               showUserInfoS(_loc2_.uid,_loc2_.userName);
               break;
            case "offend":
            case "flood":
            case "openingOfAllyPos":
            case "allyEjection":
            case "notFairPlay":
            case "teamKill":
            case "bot":
               appealS(_loc2_.uid,_loc2_.userName,param1.id);
               break;
            case "createPrivateChannel":
               createPrivateChannelS(_loc2_.uid,_loc2_.userName);
               break;
            case "addToFriends":
               addFriendS(_loc2_.uid,_loc2_.userName);
               break;
            case "removeFromFriends":
               removeFriendS(_loc2_.uid);
               break;
            case "addToIgnored":
               setIgnoredS(_loc2_.uid,_loc2_.userName);
               break;
            case "removeFromIgnored":
               unsetIgnoredS(_loc2_.uid);
               break;
            case "copyToClipBoard":
               copyToClipboardS(_loc2_.userName);
               break;
            case "setMuted":
               setMutedS(_loc2_.uid,_loc2_.userName);
               break;
            case "unsetMuted":
               unsetMutedS(_loc2_.uid);
               break;
            case "kickPlayer":
               kickPlayerS(_loc2_.kickId);
               break;
            case "fortDirectionControl":
               fortDirectionS();
               break;
            case "fortAssignPlayers":
               fortAssignPlayersS();
               break;
            case "fortModernization":
               fortModernizationS();
               break;
            case "fortDestroy":
               fortDestroyS();
               break;
            case "fortPrepareOrder":
               fortPrepareOrderS();
               break;
         }
         if(this._extraHandler != null)
         {
            this._extraHandler(param1);
         }
         this.hide();
      }

      public function vehicleWasInBattle(param1:Number) : Boolean {
         return isVehicleWasInBattleS(param1);
      }

      private function destroy(param1:Event) : void {
         this.hide();
      }

      private function onContextMenuAction(param1:ContextMenuEvent) : void {
         if(this._handler != null)
         {
            this._handler(param1);
            this.hide();
         }
      }

      public function hide() : void {
         if(this._currentMenu != null)
         {
            if(!(this._handler == null) && (DisplayObject(this._currentMenu).hasEventListener(ContextMenuEvent.ON_ITEM_SELECT)))
            {
               DisplayObject(this._currentMenu).removeEventListener(ContextMenuEvent.ON_ITEM_SELECT,this.onContextMenuAction);
               this._handler = null;
            }
            if(DisplayObject(this._currentMenu).hasEventListener(ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE))
            {
               DisplayObject(this._currentMenu).removeEventListener(ContextMenuEvent.ON_MENU_RELEASE_OUTSIDE,this.destroy);
            }
            if(DisplayObject(this._currentMenu).stage.hasEventListener(Event.RESIZE))
            {
               DisplayObject(this._currentMenu).stage.removeEventListener(Event.RESIZE,this.destroy);
            }
            if(this._currentMenu  is  IDisposable)
            {
               IDisposable(this._currentMenu).dispose();
            }
            App.utils.popupMgr.popupCanvas.removeChild(DisplayObject(this._currentMenu));
            this._currentMenu = null;
            this._extraHandler = null;
         }
      }

      public function dispose() : void {
         this.hide();
      }
   }

}