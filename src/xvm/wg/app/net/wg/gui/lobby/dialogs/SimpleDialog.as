package net.wg.gui.lobby.dialogs
{
   import net.wg.infrastructure.base.meta.impl.SimpleDialogMeta;
   import net.wg.infrastructure.base.meta.ISimpleDialogMeta;
   import scaleform.clik.controls.Button;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   import flash.text.TextFieldAutoSize;
   import __AS3__.vec.Vector;
   import net.wg.gui.components.windows.Window;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.utils.Padding;
   import net.wg.utils.IFocusHandler;
   import net.wg.data.constants.SoundTypes;
   import flash.events.EventPhase;


   public class SimpleDialog extends SimpleDialogMeta implements ISimpleDialogMeta
   {
          
      public function SimpleDialog() {
         super();
         isModal = true;
      }

      public static const SUBMIT_BUTTON:String = "submit";

      public static const CLOSE_BUTTON:String = "close";

      protected static const ADDITIONAL_MULTI_LINE_PADDING:uint = 10;

      private static const TEXT_HEIGHT_PADDING:uint = 3;

      private static const WINDOW_PADDING:Object;

      private static const LAYOUT_INVALID:String = "layoutInv";

      private static const BUTTON_ENABLE_INVALID:String = "btnEnInv";

      private static const BUTTON_FOCUS_INVALID:String = "btnFocusInv";

      private static function hideBtnProcessor(param1:Button) : void {
         param1.visible = false;
      }

      public var textField:TextField = null;

      public var firstBtn:SoundButtonEx = null;

      public var secondBtn:SoundButtonEx = null;

      public var thirdBtn:SoundButtonEx = null;

      public var dynamicWhiteButton:SoundButtonEx = null;

      protected const BTN_MARGIN:Number = 9;

      private const MIN_WIDTH:Number = 360;

      private const MIN_HEIGHT:Number = 115;

      private var _minWidth:Number = 360;

      private var _minHeight:Number = 115;

      private var _btnEnableCandidate:ItemStatusData;

      private var _btnFocusCandidateId:String;

      private var lastFocusedObject:UIComponent;

      override public function setFocus() : void {
         super.setFocus();
         if((this.lastFocusedObject) && (!this.lastFocusedObject.focused) && (initialized))
         {
            App.utils.focusHandler.setFocus(this.lastFocusedObject);
         }
      }

      override protected function onPopulate() : void {
         window.useBottomBtns = true;
         canDrag = false;
         this.reflowDialogToCtrl();
         updateStage(App.appWidth,App.appHeight);
         this.processButtons(this.addListenerButtonProcessor);
         super.onPopulate();
      }

      override protected function onDispose() : void {
         this.processButtons(this.removeListenerButtonProcessor);
         this.dynamicWhiteButton.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHdlr);
         if(this.textField)
         {
            this.textField.text = "";
            if(this.textField.parent)
            {
               this.textField.parent.removeChild(this.textField);
            }
            this.textField = null;
         }
         if(this.lastFocusedObject)
         {
            this.lastFocusedObject.dispose();
            this.lastFocusedObject = null;
         }
         super.onDispose();
      }

      public function as_setText(param1:String) : void {
         this.textField.htmlText = param1;
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.invalidateLayout();
      }

      protected function invalidateLayout() : void {
         invalidate(LAYOUT_INVALID);
      }

      override protected function draw() : void {
         var _loc1_:String = null;
         var _loc2_:* = false;
         var _loc3_:Vector.<Button> = null;
         var _loc4_:Button = null;
         var _loc5_:uint = 0;
         var _loc6_:* = 0;
         var _loc7_:Vector.<Button> = null;
         var _loc8_:Button = null;
         super.draw();
         if(isInvalid(LAYOUT_INVALID))
         {
            this.applyLayout();
         }
         if((isInvalid(BUTTON_ENABLE_INVALID)) && (this._btnEnableCandidate))
         {
            _loc1_ = this._btnEnableCandidate.id;
            _loc2_ = this._btnEnableCandidate.status;
            _loc3_ = this.getAllButtons();
            _loc5_ = _loc3_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ = _loc3_[_loc6_];
               if((_loc4_.data) && (_loc4_.data.hasOwnProperty("id")))
               {
                  if(_loc1_ == _loc4_.data.id)
                  {
                     _loc4_.enabled = _loc2_;
                     break;
                  }
               }
               _loc6_++;
            }
         }
         if((isInvalid(BUTTON_FOCUS_INVALID)) && (this._btnFocusCandidateId))
         {
            _loc7_ = this.getAllButtons();
            for each (_loc8_ in _loc7_)
            {
               if((_loc8_.data) && (_loc8_.data.hasOwnProperty("id")) && this._btnFocusCandidateId == _loc8_.data.id)
               {
                  if(_loc8_.enabled)
                  {
                     App.utils.focusHandler.setFocus(_loc8_);
                  }
                  break;
               }
            }
         }
      }

      protected function applyLayout() : void {
         this.layoutButtons(this.getBackgroundActualHeight());
         UIComponent(window).invalidate(Window.INVALID_SRC_VIEW);
      }

      override public function get height() : Number {
         var _loc1_:Number = this.thirdBtn.height;
         return this.getBackgroundActualHeight() + TEXT_HEIGHT_PADDING + _loc1_;
      }

      protected function getBackgroundActualHeight() : Number {
         return Math.max(this.getTextAreaCurrentHeight(),this.getTextAreaMinHeight());
      }

      protected function getTextAreaMinHeight() : Number {
         var _loc1_:Number = this.thirdBtn.height;
         return Math.ceil(this._minHeight - _loc1_ - TEXT_HEIGHT_PADDING);
      }

      protected function getTextAreaCurrentHeight() : Number {
         return Math.ceil(this.textField.y + this.textField.textHeight + ADDITIONAL_MULTI_LINE_PADDING);
      }

      override public function set window(param1:IWindow) : void {
         var _loc2_:Padding = null;
         super.window = param1;
         if(window)
         {
            _loc2_ = window.contentPadding as Padding;
            _loc2_.right = WINDOW_PADDING.right;
            _loc2_.bottom = WINDOW_PADDING.bottom;
         }
      }

      protected function layoutButtons(param1:Number) : void {
         var _loc2_:Vector.<Button> = this.getAllButtons();
         var _loc3_:uint = _loc2_.length;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_[_loc4_].y = param1;
            _loc4_++;
         }
      }

      public function as_setTitle(param1:String) : void {
         window.title = param1;
      }

      public function as_setButtons(param1:Array) : void {
         var _loc6_:SoundButtonEx = null;
         var _loc7_:String = null;
         var _loc2_:Vector.<Button> = this.getButtonsOrder();
         var _loc3_:Number = _loc2_.length - param1.length;
         assert(_loc3_ >= 0,"buttonNames too much");
         var _loc4_:IFocusHandler = App.utils.focusHandler;
         var _loc5_:Number = param1.length-1;
         while(_loc5_ >= 0)
         {
            _loc6_ = _loc2_[_loc5_ + _loc3_] as SoundButtonEx;
            _loc7_ = param1[_loc5_].id;
            if(_loc7_ == CLOSE_BUTTON)
            {
               this.dynamicWhiteButton.x = _loc6_.x;
               this.dynamicWhiteButton.y = _loc6_.y;
               this.dynamicWhiteButton.data = param1[_loc5_];
               this.dynamicWhiteButton.label = param1[_loc5_].label;
               if(param1[_loc5_].focused)
               {
                  _loc4_.setFocus(this.dynamicWhiteButton);
               }
               this.dynamicWhiteButton.visible = true;
               this.dynamicWhiteButton.soundType = SoundTypes.CANCEL_BTN;
               this.addListenerButtonProcessor(this.dynamicWhiteButton);
               _loc6_.visible = false;
            }
            else
            {
               _loc6_.data = param1[_loc5_];
               _loc6_.label = param1[_loc5_].label;
               if(param1[_loc5_].focused)
               {
                  _loc4_.setFocus(_loc6_);
                  this.lastFocusedObject = _loc6_;
               }
               _loc6_.visible = true;
               if(_loc7_ == SUBMIT_BUTTON)
               {
                  _loc6_.soundType = SoundTypes.OK_BTN;
               }
               else
               {
                  _loc6_.soundType = SoundTypes.NORMAL_BTN;
               }
            }
            _loc5_--;
         }
      }

      private function reflowDialogToCtrl() : void {
         this.processButtons(hideBtnProcessor);
      }

      protected function getButtonsOrder() : Vector.<Button> {
         return Vector.<Button>([this.firstBtn,this.secondBtn,this.thirdBtn]);
      }

      protected function getAllButtons() : Vector.<Button> {
         return Vector.<Button>([this.firstBtn,this.secondBtn,this.thirdBtn,this.dynamicWhiteButton]);
      }

      private function processButtons(param1:Function) : void {
         var _loc2_:Button = null;
         for each (_loc2_ in this.getButtonsOrder())
         {
            param1(_loc2_);
         }
      }

      private function addListenerButtonProcessor(param1:Button) : void {
         param1.addEventListener(ButtonEvent.CLICK,this.onButtonClickHdlr);
      }

      private function removeListenerButtonProcessor(param1:Button) : void {
         param1.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHdlr);
      }

      public function get minWidth() : Number {
         return this._minWidth;
      }

      public function set minWidth(param1:Number) : void {
         if(param1 == this._minWidth)
         {
            return;
         }
         this._minWidth = param1;
      }

      public function get minHeight() : Number {
         return this._minHeight;
      }

      public function set minHeight(param1:Number) : void {
         if(param1 == this._minHeight)
         {
            return;
         }
         this._minHeight = param1;
         this.updateActualSize();
      }

      protected function updateActualSize() : void {
         this.textField.height = Math.max(this.textField.textHeight,this._minHeight - this.thirdBtn.height - this.BTN_MARGIN);
         var _loc1_:Number = this.getBackgroundActualHeight();
         window.setMinHeight(_loc1_);
         window.setSize(actualWidth,_loc1_);
      }

      private function onButtonClickHdlr(param1:ButtonEvent) : void {
         var _loc2_:String = null;
         if(param1.eventPhase == EventPhase.AT_TARGET)
         {
            _loc2_ = Button(param1.target).data.id;
            assertNotNull(_loc2_,"Button has not unique name");
            onButtonClickS(_loc2_);
         }
      }

      public function as_setButtonEnabling(param1:String, param2:Boolean) : void {
         if(!this._btnEnableCandidate)
         {
            this._btnEnableCandidate = new ItemStatusData();
         }
         this._btnEnableCandidate.id = param1;
         this._btnEnableCandidate.status = param2;
         invalidate(BUTTON_ENABLE_INVALID);
      }

      public function as_setButtonFocus(param1:String) : void {
         this._btnFocusCandidateId = param1;
         invalidate(BUTTON_FOCUS_INVALID);
      }
   }

}