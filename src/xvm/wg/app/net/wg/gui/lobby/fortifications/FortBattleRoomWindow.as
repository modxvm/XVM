package net.wg.gui.lobby.fortifications
{
   import net.wg.infrastructure.base.meta.impl.FortBattleRoomWindowMeta;
   import net.wg.infrastructure.base.meta.IFortBattleRoomWindowMeta;
   import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
   import net.wg.gui.cyberSport.interfaces.IChannelComponentHolder;
   import net.wg.gui.lobby.fortifications.battleRoom.FortListView;
   import net.wg.gui.lobby.fortifications.battleRoom.FortIntroView;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   import flash.ui.Keyboard;
   import scaleform.clik.constants.InputValue;


   public class FortBattleRoomWindow extends FortBattleRoomWindowMeta implements IFortBattleRoomWindowMeta
   {
          
      public function FortBattleRoomWindow() {
         super();
         showWindowBg = false;
         canMinimize = true;
         UIID = 29;
      }

      override public function onWindowMinimizeS() : void {
         super.onWindowMinimizeS();
         App.eventLogManager.logUIElement(this,EVENT_LOG_CONSTANTS.EVENT_TYPE_ON_WINDOW_MINIMIZE,0);
      }

      override protected function getWindowTitle() : String {
         return FORTIFICATIONS.SORTIE_INTROVIEW_TITLE;
      }

      override protected function onViewLoadRequest(param1:RallyViewsEvent) : void {
         if(!param1.data)
         {
            return;
         }
         switch(param1.data.alias)
         {
            case FORTIFICATION_ALIASES.FORT_BATTLE_ROOM_LIST_VIEW_UI:
               onBrowseRalliesS();
               break;
            case FORTIFICATION_ALIASES.FORT_BATTLE_ROOM_VIEW_UI:
               if(param1.data.itemId)
               {
                  onJoinRallyS(param1.data.itemId,param1.data.slotIndex,param1.data.peripheryID);
               }
               else
               {
                  onCreateRallyS();
               }
               break;
         }
      }

      override protected function updateFocus() : void {
         var _loc1_:IChannelComponentHolder = getCurrentView() as IChannelComponentHolder;
         if(autoSearch.visible)
         {
            autoSearchUpdateFocus();
         }
         else
         {
            if((_loc1_) && (isChatFocusNeeded()))
            {
               setFocus(_loc1_.getChannelComponent().messageInput);
               resetChatFocusRequirement();
            }
            else
            {
               if(getCurrentView()  is  FortListView)
               {
                  setFocus(FortListView(getCurrentView()).rallyTable);
               }
               else
               {
                  if(getCurrentView()  is  FortIntroView)
                  {
                     setFocus(FortIntroView(getCurrentView()).listRoomBtn);
                  }
                  else
                  {
                     setFocus(lastFocusedElement);
                  }
               }
            }
         }
      }

      override public function handleInput(param1:InputEvent) : void {
         if(param1.handled)
         {
            return;
         }
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            if(autoSearch.visible)
            {
               autoSearch.handleInput(param1);
            }
            else
            {
               if(window.getCloseBtn().enabled)
               {
                  param1.handled = true;
                  onWindowCloseS();
               }
            }
         }
      }

      override protected function onPopulate() : void {
         super.onPopulate();
      }

      override protected function onDispose() : void {
         App.eventLogManager.logUIElement(this,EVENT_LOG_CONSTANTS.EVENT_TYPE_ON_WINDOW_CLOSE,0);
         super.onDispose();
      }
   }

}