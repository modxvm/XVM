package net.wg.gui.lobby.fortifications.battleRoom
{
   import net.wg.infrastructure.base.meta.impl.FortIntroMeta;
   import net.wg.infrastructure.base.meta.IFortIntroMeta;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   import flash.events.MouseEvent;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
   import net.wg.gui.rally.events.RallyViewsEvent;
   
   public class FortIntroView extends FortIntroMeta implements IFortIntroMeta
   {
      
      public function FortIntroView() {
         super();
         listRoomBtn.UIID = 30;
      }
      
      public var fortBattleTitleLbl:TextField;
      
      public var fortBattleDescrLbl:TextField;
      
      public var fortBattleBtnTitle:TextField;
      
      override protected function configUI() : void {
         super.configUI();
         titleLbl.text = FORTIFICATIONS.SORTIE_INTROVIEW_TITLE;
         descrLbl.text = FORTIFICATIONS.SORTIE_INTROVIEW_DESCR;
         listRoomTitleLbl.text = FORTIFICATIONS.SORTIE_INTROVIEW_SORTIE_TITLE;
         listRoomDescrLbl.text = FORTIFICATIONS.SORTIE_INTROVIEW_SORTIE_DESCR;
         listRoomBtn.label = FORTIFICATIONS.SORTIE_INTROVIEW_SORTIE_BTNTITLE;
         this.fortBattleTitleLbl.text = FORTIFICATIONS.SORTIE_INTROVIEW_FORTBATTLES_TITLE;
         this.fortBattleDescrLbl.text = FORTIFICATIONS.SORTIE_INTROVIEW_FORTBATTLES_DESCR;
         this.fortBattleBtnTitle.text = FORTIFICATIONS.SORTIE_INTROVIEW_FORTBATTLES_BTNTITLE;
         TextFieldEx.setVerticalAlign(this.fortBattleBtnTitle,TextFieldEx.VALIGN_CENTER);
         this.fortBattleBtnTitle.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.fortBattleBtnTitle.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
      }
      
      override protected function onDispose() : void {
         this.fortBattleBtnTitle.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
         this.fortBattleBtnTitle.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
         super.onDispose();
      }
      
      override protected function onListRoomBtnClick(param1:ButtonEvent) : void {
         App.eventLogManager.logUIEvent(param1,0);
         var _loc2_:Object = 
            {
               "alias":FORTIFICATION_ALIASES.FORT_BATTLE_ROOM_LIST_VIEW_UI,
               "itemId":Number.NaN,
               "peripheryID":0,
               "slotIndex":-1
            };
         dispatchEvent(new RallyViewsEvent(RallyViewsEvent.LOAD_VIEW_REQUEST,_loc2_));
      }
      
      private function onFortBattleBtnClick(param1:ButtonEvent) : void {
      }
      
      override protected function onControlRollOver(param1:MouseEvent) : void {
         switch(param1.target)
         {
            case this.fortBattleBtnTitle:
               App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_INTROVIEW_FORTBATTLES_BTNTOOLTIP);
               break;
            case listRoomBtn:
               App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_INTROVIEW_SORTIE_BTNTOOLTIP);
               break;
         }
      }
   }
}
