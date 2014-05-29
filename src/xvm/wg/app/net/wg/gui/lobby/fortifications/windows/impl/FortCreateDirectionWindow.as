package net.wg.gui.lobby.fortifications.windows.impl
{
   import net.wg.infrastructure.base.meta.impl.FortCreateDirectionWindowMeta;
   import net.wg.infrastructure.base.meta.IFortCreateDirectionWindowMeta;
   import net.wg.gui.utils.ComplexTooltipHelper;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.fortifications.cmp.drctn.impl.DirectionListRenderer;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.MouseEvent;
   import flash.display.InteractiveObject;
   import net.wg.gui.lobby.fortifications.events.DirectionEvent;
   import net.wg.gui.lobby.fortifications.data.DirectionVO;


   public class FortCreateDirectionWindow extends FortCreateDirectionWindowMeta implements IFortCreateDirectionWindowMeta
   {
          
      public function FortCreateDirectionWindow() {
         super();
         isModal = false;
         isCentered = true;
         this.allRenderers = [this.direction0,this.direction1,this.direction2,this.direction3,this.direction4,this.direction5];
      }

      private static function showComplexTT(param1:String, param2:String="") : void {
         var _loc3_:String = new ComplexTooltipHelper().addHeader(param1).addBody(param2).make();
         if(_loc3_.length > 0)
         {
            App.toolTipMgr.showComplex(_loc3_);
         }
      }

      public var descriptionTF:TextField;

      public var titleTF:TextField;

      public var newDirectionBtn:SoundButtonEx;

      public var direction0:DirectionListRenderer;

      public var direction1:DirectionListRenderer;

      public var direction2:DirectionListRenderer;

      public var direction3:DirectionListRenderer;

      public var direction4:DirectionListRenderer;

      public var direction5:DirectionListRenderer;

      private var _buttonTTHeader:String = "";

      private var _buttonTTDescr:String = "";

      private var allRenderers:Array;

      override protected function configUI() : void {
         super.configUI();
         this.titleTF.htmlText = FORTIFICATIONS.FORTDIRECTIONSWINDOW_LABEL_OPENEDDIRECTIONS;
         this.newDirectionBtn.label = FORTIFICATIONS.FORTDIRECTIONSWINDOW_BUTTON_NEWDIRECTION;
         this.newDirectionBtn.addEventListener(ButtonEvent.CLICK,this.onOpenNewDirectionClick);
         this.newDirectionBtn.addEventListener(MouseEvent.ROLL_OVER,this.onNewDirctnOver);
         this.newDirectionBtn.addEventListener(MouseEvent.ROLL_OUT,this.onNewDirctnOut);
         this.setupRenderers();
      }

      override protected function onDispose() : void {
         this.newDirectionBtn.removeEventListener(ButtonEvent.CLICK,this.onOpenNewDirectionClick);
         this.newDirectionBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onNewDirctnOver);
         this.newDirectionBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onNewDirctnOut);
         this.newDirectionBtn.dispose();
         this.newDirectionBtn = null;
         this.disposeRenderers();
         super.onDispose();
      }

      override protected function onInitModalFocus(param1:InteractiveObject) : void {
         super.onInitModalFocus(param1);
         setFocus(this.newDirectionBtn);
      }

      override protected function draw() : void {
         super.draw();
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         window.title = FORTIFICATIONS.FORTDIRECTIONSWINDOW_TITLE;
      }

      private function onNewDirctnOver(param1:MouseEvent) : void {
         showComplexTT(this._buttonTTHeader,this._buttonTTDescr);
      }

      private function onNewDirctnOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      private function disposeRenderers() : void {
         var _loc1_:DirectionListRenderer = null;
         for each (_loc1_ in this.allRenderers)
         {
            _loc1_.removeEventListener(DirectionEvent.CLOSE_DIRECTION,this.onCloseDirectionRequest);
            _loc1_.dispose();
            _loc1_ = null;
         }
         this.allRenderers.splice(0);
         this.allRenderers = null;
      }

      private function setupRenderers() : void {
         var _loc1_:DirectionListRenderer = null;
         for each (_loc1_ in this.allRenderers)
         {
            _loc1_.addEventListener(DirectionEvent.CLOSE_DIRECTION,this.onCloseDirectionRequest);
            _loc1_ = null;
         }
      }

      private function onOpenNewDirectionClick(param1:ButtonEvent) : void {
         openNewDirectionS();
      }

      private function onCloseDirectionRequest(param1:DirectionEvent) : void {
         closeDirectionS(param1.id);
      }

      public function as_setDescription(param1:String) : void {
         this.descriptionTF.htmlText = param1;
      }

      public function as_setupButton(param1:Boolean, param2:Boolean, param3:String, param4:String) : void {
         this.newDirectionBtn.enabled = param1;
         this.newDirectionBtn.visible = param2;
         this._buttonTTHeader = param3;
         this._buttonTTDescr = param4;
      }

      public function as_setDirections(param1:Array) : void {
         var _loc2_:DirectionListRenderer = null;
         var _loc3_:DirectionVO = null;
         var _loc4_:* = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = new DirectionVO(param1[_loc4_]);
            _loc2_ = this.allRenderers[_loc4_];
            _loc2_.setData(_loc3_);
            _loc4_++;
         }
         while(_loc4_ < this.allRenderers.length)
         {
            _loc2_ = this.allRenderers[_loc4_];
            _loc2_.setData(null);
            _loc4_++;
         }
      }
   }

}