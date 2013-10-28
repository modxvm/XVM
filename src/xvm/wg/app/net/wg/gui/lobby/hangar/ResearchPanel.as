package net.wg.gui.lobby.hangar
{
   import net.wg.infrastructure.base.meta.impl.ResearchPanelMeta;
   import net.wg.infrastructure.base.meta.IResearchPanelMeta;
   import net.wg.infrastructure.interfaces.IHelpLayoutComponent;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.IconTextButton;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.constants.InvalidationType;


   public class ResearchPanel extends ResearchPanelMeta implements IResearchPanelMeta, IHelpLayoutComponent
   {
          
      public function ResearchPanel() {
         super();
      }

      private var _earnedXP:Number = 0;

      private var _isElite:Boolean = false;

      public var xpText:IconText;

      public var button:IconTextButton;

      override protected function onPopulate() : void {
         super.onPopulate();
         this.xpText.focusable = false;
         this.xpText.mouseChildren = false;
         if(this.button != null)
         {
            this.button.addEventListener(ButtonEvent.CLICK,this.handleButtonClick,false,0,true);
         }
      }

      override protected function onDispose() : void {
         super.onDispose();
         if(this.button != null)
         {
            this.button.removeEventListener(ButtonEvent.CLICK,this.handleButtonClick);
         }
         this.xpText.dispose();
         this.xpText = null;
         this.button.dispose();
         this.button = null;
      }

      public function as_setEarnedXP(param1:Number) : void {
         if(this._earnedXP == param1)
         {
            return;
         }
         this._earnedXP = param1;
         invalidateData();
      }

      public function as_setElite(param1:Boolean) : void {
         if(this._isElite == param1)
         {
            return;
         }
         this._isElite = param1;
         invalidateData();
      }

      public function showHelpLayout() : void {
         this.button.showHelpLayout();
      }

      public function closeHelpLayout() : void {
         this.button.closeHelpLayout();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && !(this.xpText == null))
         {
            this.xpText.text = App.utils != null?App.utils.locale.integer(this._earnedXP):this._earnedXP.toString();
            this.xpText.icon = this._isElite?IconText.ELITE_XP:IconText.XP;
         }
      }

      private function handleButtonClick(param1:ButtonEvent) : void {
         goToResearchS();
      }
   }

}