package net.wg.gui.lobby.hangar
{
   import net.wg.infrastructure.base.meta.impl.TmenXpPanelMeta;
   import net.wg.infrastructure.base.meta.ITmenXpPanelMeta;
   import flash.events.MouseEvent;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.CheckBox;
   import scaleform.clik.events.ButtonEvent;


   public class TmenXpPanel extends TmenXpPanelMeta implements ITmenXpPanelMeta
   {
          
      public function TmenXpPanel() {
         super();
      }

      private static const INVALIDATE_XP_PANEL:String = "invXpPanel";

      private static function showXpTankmenTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.showComplex(TOOLTIPS.HANGAR_XPTOTMENCHECKBOX);
      }

      private static function hideXpTankmenTooltip(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      public var checkboxTankersBg:MovieClip;

      public var xpToTmenCheckbox:CheckBox;

      private var _panelVisible:Boolean = false;

      private var _panelSelected:Boolean = false;

      public function as_setTankmenXpPanel(param1:Boolean, param2:Boolean) : void {
         this._panelVisible = param1;
         this._panelSelected = param2;
         invalidate(INVALIDATE_XP_PANEL);
      }

      override protected function configUI() : void {
         super.configUI();
         this.checkboxTankersBg.visible = this.xpToTmenCheckbox.visible = false;
         this.xpToTmenCheckbox.label = DIALOGS.XPTOTMENCHECKBOX_TITLE;
         this.xpToTmenCheckbox.addEventListener(MouseEvent.ROLL_OVER,showXpTankmenTooltip);
         this.xpToTmenCheckbox.addEventListener(MouseEvent.ROLL_OUT,hideXpTankmenTooltip);
         this.xpToTmenCheckbox.addEventListener(ButtonEvent.CLICK,this.onXpToTmenCheckboxClick);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(INVALIDATE_XP_PANEL))
         {
            this.checkboxTankersBg.visible = this.xpToTmenCheckbox.visible = this._panelVisible;
            this.xpToTmenCheckbox.selected = this._panelSelected;
         }
      }

      override protected function onDispose() : void {
         App.toolTipMgr.hide();
         super.onDispose();
         this.xpToTmenCheckbox.removeEventListener(MouseEvent.ROLL_OVER,showXpTankmenTooltip);
         this.xpToTmenCheckbox.removeEventListener(MouseEvent.ROLL_OUT,hideXpTankmenTooltip);
         this.xpToTmenCheckbox.removeEventListener(ButtonEvent.CLICK,this.onXpToTmenCheckboxClick);
         this.checkboxTankersBg = null;
         this.xpToTmenCheckbox.dispose();
         this.xpToTmenCheckbox = null;
      }

      private function onXpToTmenCheckboxClick(param1:ButtonEvent) : void {
         App.toolTipMgr.hide();
         DebugUtils.LOG_DEBUG(this.xpToTmenCheckbox.selected);
         accelerateTmenXpS(this.xpToTmenCheckbox.selected);
      }
   }

}