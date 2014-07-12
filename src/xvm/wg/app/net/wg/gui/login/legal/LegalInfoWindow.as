package net.wg.gui.login.legal
{
   import net.wg.infrastructure.base.meta.impl.LegalInfoWindowMeta;
   import net.wg.infrastructure.base.meta.ILegalInfoWindowMeta;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.display.Sprite;
   import net.wg.gui.components.controls.BorderShadowScrollPane;
   import scaleform.clik.utils.Padding;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.constants.InvalidationType;
   import flash.display.InteractiveObject;
   import net.wg.data.constants.Values;
   
   public class LegalInfoWindow extends LegalInfoWindowMeta implements ILegalInfoWindowMeta
   {
      
      public function LegalInfoWindow() {
         super();
         isCentered = true;
         showWindowBg = false;
      }
      
      public var closeBtn:SoundButtonEx;
      
      public var background:Sprite;
      
      public var scrollPane:BorderShadowScrollPane;
      
      public var legalContent:LegalContent;
      
      private var _legalInfo:String = "";
      
      override protected function onPopulate() : void {
         super.onPopulate();
         window.title = DIALOGS.LEGALINFOWINDOW_TITLE;
         var _loc1_:Padding = new Padding(window.formBgPadding.top,window.formBgPadding.right,window.formBgPadding.bottom + 1,window.formBgPadding.left);
         window.contentPadding = _loc1_;
         this.scrollPane.setSize(455,376);
         this.legalContent = this.scrollPane.target as LegalContent;
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onClose);
         getLegalInfoS();
      }
      
      override protected function configUI() : void {
         super.configUI();
      }
      
      override protected function draw() : void {
         if(isInvalid(InvalidationType.DATA))
         {
            this.legalContent.updateData(this._legalInfo);
         }
         super.draw();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void {
         super.onInitModalFocus(param1);
         setFocus(this.closeBtn);
      }
      
      public function as_setLegalInfo(param1:String) : void {
         this._legalInfo = param1;
         if(this._legalInfo == Values.EMPTY_STR)
         {
            onCancelClickS();
            return;
         }
         invalidateData();
         super.draw();
      }
      
      private function onClose(param1:ButtonEvent) : void {
         onCancelClickS();
      }
      
      override protected function onDispose() : void {
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onClose);
         this.closeBtn.dispose();
         this.closeBtn = null;
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.legalContent = null;
         super.onDispose();
      }
   }
}
