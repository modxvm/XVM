package net.wg.gui.lobby.fortifications.utils.impl
{
   import net.wg.gui.lobby.fortifications.utils.IFortModeSwitcher;
   import net.wg.gui.lobby.fortifications.utils.IFortCommonUtils;
   import net.wg.utils.ITweenAnimator;
   import net.wg.gui.lobby.fortifications.cmp.IFortMainView;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.fortifications.data.FortModeStateVO;
   import flash.display.DisplayObject;
   import net.wg.gui.lobby.fortifications.data.FortModeElementProperty;


   public class FortModeSwitcher extends Object implements IFortModeSwitcher
   {
          
      public function FortModeSwitcher() {
         super();
      }

      private static const DONT_MOVE:uint = 0;

      private static const MOVE_DOWN:uint = 2;

      private static function getFortCommonUtils() : IFortCommonUtils {
         return FortCommonUtils.instance;
      }

      private static function getTweenAnimator() : ITweenAnimator {
         return TweenAnimator.instance;
      }

      private var _mainView:IFortMainView = null;

      private var _animsAdded:Boolean = false;

      private var _startDescrTextY:Number = 0;

      public function init(param1:IFortMainView) : void {
         App.utils.asserter.assertNotNull(param1,param1.name + Errors.CANT_NULL);
         this._mainView = param1;
         if((this._mainView.header) && (this._mainView.header.vignetteYellow) && (this._mainView.header.vignetteYellow.descrText))
         {
            this._startDescrTextY = this._mainView.header.vignetteYellow.descrText.y;
         }
      }

      public function applyMode(param1:FortModeStateVO) : void {
         this.removeAllAnims();
         this._mainView.gotoAndPlay(param1.mode);
         this._mainView.header.gotoAndPlay(param1.mode);
         this._mainView.header.updateControls();
         this._mainView.footer.updateControls();
         this.applyStepEffects(param1);
         this._animsAdded = true;
      }

      public function dispose() : void {
         this.removeAllAnims();
         this._mainView = null;
      }

      private function applyStepEffects(param1:FortModeStateVO) : void {
         this.fadeSomeElementSimply(param1.getYellowVignette(),this._mainView.header.vignetteYellow);
         this.moveElementSimply(param1.descrTextMove,this._startDescrTextY,this._mainView.header.vignetteYellow.descrText);
         this.fadeSomeElementSimply(param1.getClanInfo(),DisplayObject(this._mainView.header.clanInfo));
         this.fadeSomeElementSimply(param1.getClanListBtn(),DisplayObject(this._mainView.header.clanListBtn));
         this.fadeSomeElementSimply(param1.getTransportToggle(),DisplayObject(this._mainView.header.transportBtn));
         this.fadeSomeElementSimply(param1.getStatsBtn(),DisplayObject(this._mainView.header.statsBtn));
         this._mainView.header.title.htmlText = param1.stateTexts.headerTitle;
         this.fadeSomeElementSimply(param1.getTotalDepotQuantity(),this._mainView.header.totalDepotQuantityText);
         if((param1.getTutorialArrow().isVisible) && (param1.getTutorialArrow().isAnimated))
         {
            this.startArrowBlinking();
         }
         else
         {
            this.stopArrowBlinking();
         }
         if(!param1.getYellowVignette().isAnimated || (param1.getYellowVignette().isVisible))
         {
            this._mainView.header.vignetteYellow.descrText.htmlText = param1.stateTexts.descrText;
         }
         this.fadeSomeElementSimply(param1.getFooterBitmapFill(),this._mainView.footer.footerBitmapFill);
         this.fadeSomeElementSimply(param1.getOrdersPanel(),DisplayObject(this._mainView.footer.ordersPanel));
         this.fadeSomeElementSimply(param1.getSortieBtn(),this._mainView.footer.sortieBtn);
         this.fadeSomeElementSimply(param1.getIntelligenceButton(),this._mainView.footer.intelligenceButton);
         this.fadeSomeElementSimply(param1.getLeaveModeBtn(),this._mainView.footer.leaveModeBtn);
      }

      private function startArrowBlinking() : void {
         this._mainView.header.tutorialArrow.visible = true;
         getTweenAnimator().blinkInfinity(DisplayObject(this._mainView.header.tutorialArrow));
      }

      private function stopArrowBlinking() : void {
         this._mainView.header.tutorialArrow.visible = false;
         getTweenAnimator().removeAnims(DisplayObject(this._mainView.header.tutorialArrow));
      }

      private function fadeSomeElementSimply(param1:FortModeElementProperty, param2:DisplayObject) : void {
         getFortCommonUtils().fadeSomeElementSimply(param1.isVisible,param1.isAnimated,param2);
      }

      private function moveElementSimply(param1:uint, param2:Number, param3:DisplayObject) : void {
         if(param1 != DONT_MOVE)
         {
            getFortCommonUtils().moveElementSimply(param1 == MOVE_DOWN,param2,param3);
         }
      }

      private function removeAllAnims() : void {
         this.stopArrowBlinking();
         var _loc1_:ITweenAnimator = getTweenAnimator();
         _loc1_.removeAnims(DisplayObject(this._mainView.header.vignetteYellow));
         _loc1_.removeAnims(DisplayObject(this._mainView.header.vignetteYellow.descrText));
         _loc1_.removeAnims(DisplayObject(this._mainView.header.clanListBtn));
         _loc1_.removeAnims(DisplayObject(this._mainView.header.transportBtn));
         _loc1_.removeAnims(DisplayObject(this._mainView.header.statsBtn));
         _loc1_.removeAnims(DisplayObject(this._mainView.header.clanInfo));
         _loc1_.removeAnims(this._mainView.header.totalDepotQuantityText);
         _loc1_.removeAnims(this._mainView.footer.footerBitmapFill);
         _loc1_.removeAnims(DisplayObject(this._mainView.footer.ordersPanel));
         _loc1_.removeAnims(this._mainView.footer.sortieBtn);
         _loc1_.removeAnims(this._mainView.footer.intelligenceButton);
         _loc1_.removeAnims(this._mainView.footer.leaveModeBtn);
         this._animsAdded = false;
      }
   }

}