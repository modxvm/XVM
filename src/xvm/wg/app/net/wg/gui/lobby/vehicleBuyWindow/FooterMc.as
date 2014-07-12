package net.wg.gui.lobby.vehicleBuyWindow
{
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.controls.Button;
   import net.wg.gui.components.controls.IconText;
   import flash.text.TextField;
   
   public class FooterMc extends UIComponent
   {
      
      public function FooterMc() {
         super();
      }
      
      public var submitBtn:Button;
      
      public var cancelBtn:Button;
      
      public var expandBtn:ExpandButton;
      
      public var totalCreditsPrice:IconText;
      
      public var totalGoldPrice:IconText;
      
      public var warningMsg:TextField;
      
      public function showWarning() : void {
         gotoAndStop("warning");
         this.warningMsg.text = DIALOGS.BUYVEHICLEDIALOG_WARNING;
         _originalHeight = _originalHeight + VehicleBuyWindow.WARNING_HEIGHT;
         setActualSize(width,height + VehicleBuyWindow.WARNING_HEIGHT);
         setActualScale(1,1);
      }
      
      override protected function configUI() : void {
         super.configUI();
         this.expandBtn.buttonMode = true;
      }
      
      override protected function onDispose() : void {
         super.onDispose();
         this.submitBtn.dispose();
         this.cancelBtn.dispose();
         this.expandBtn.dispose();
         this.totalCreditsPrice.dispose();
         this.totalGoldPrice.dispose();
      }
   }
}
