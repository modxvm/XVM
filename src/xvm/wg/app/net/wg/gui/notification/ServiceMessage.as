package net.wg.gui.notification
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.text.TextField;
   import flash.text.StyleSheet;
   import flash.text.TextFieldAutoSize;
   import scaleform.clik.events.ButtonEvent;
   import flash.events.TextEvent;
   import flash.events.MouseEvent;
   import net.wg.gui.events.UILoaderEvent;
   import flash.events.Event;


   public class ServiceMessage extends UIComponent
   {
          
      public function ServiceMessage() {
         super();
      }

      public static const RESIZED:String = "resized";

      private static const DATA_INVALID:String = "dataInv";

      private static const LAYOUT_INVALID:String = "layoutInv";

      private static const LINK_COLOR_NORMAL:String = "#E2D2A2";

      private static const LINK_COLOR_HOVER:String = "#FF0000";

      private static var allowBgFill:Array;

      public var background:MovieClip;

      public var icon:UILoaderAlt;

      public var bmpFill:BitmapFill;

      public var markerMc:MovieClip;

      public var btnMoreInfo:SoundButtonEx;

      public var textField:TextField;

      private var _messageTopOffset:int = 3;

      private var _messageBottomOffset:int = 4;

      private var _buttonPadding:int = 10;

      private var _isTFClickedByMBR:Boolean = false;

      private var _data:NotificationInfoVO;

      override protected function configUI() : void {
         super.configUI();
         var _loc1_:StyleSheet = new StyleSheet();
         _loc1_.setStyle("a:link",
            {
               "color":LINK_COLOR_NORMAL,
               "textDecoration":"underline"
            }
         );
         _loc1_.setStyle("a:hover",
            {
               "color":LINK_COLOR_HOVER,
               "textDecoration":"underline"
            }
         );
         this.textField.styleSheet = _loc1_;
         this.textField.htmlText = "A long time ago, in a galaxy far, far away..." + "It is a period of civil war. Rebel spaceships, striking from a hidden base, " + "have won their first victory against the evil Galactic Empire.";
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.textField.multiline = true;
         this.textField.wordWrap = true;
         this.textField.selectable = true;
         this.background.tabEnabled = false;
         this.markerMc.tabEnabled = false;
         this.btnMoreInfo.tabEnabled = false;
         this.btnMoreInfo.addEventListener(ButtonEvent.CLICK,this.btnClickHandler,false,0,true);
         this.btnMoreInfo.label = App.utils?App.utils.locale.makeString(MESSENGER.SERVICECHANNELMESSAGES_BATTLERESULTS_BUTTON):"more info...";
         this.btnMoreInfo.validateNow();
         this.textField.addEventListener(TextEvent.LINK,this.onMessageLinkClick,false,0,true);
         this.textField.addEventListener(MouseEvent.CLICK,this.onMessageMouseClick,false,0,true);
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.iconLoadingCompleteHandler,false,0,true);
         this.icon.addEventListener(UILoaderEvent.IOERROR,this.iconLoadingErrorHandler,false,0,true);
         addEventListener(MouseEvent.CLICK,this.componentClickHandler,false,0,true);
      }

      private function onMessageLinkClick(param1:TextEvent) : void {
         if(!this._isTFClickedByMBR)
         {
            dispatchEvent(new ServiceMessageEvent(ServiceMessageEvent.MESSAGE_LINK_CLICKED,true,false,param1.text));
         }
      }

      private function onMessageMouseClick(param1:MouseEvent) : void {
         this._isTFClickedByMBR = App.utils.commons.isRightButton(param1);
      }

      private function iconLoadingErrorHandler(param1:UILoaderEvent) : void {
         this.icon.visible = false;
      }

      private function iconLoadingCompleteHandler(param1:UILoaderEvent) : void {
         invalidate(LAYOUT_INVALID);
      }

      public function set data(param1:Object) : void {
         this._data = param1 as NotificationInfoVO;
         invalidate(DATA_INVALID);
      }

      public function get data() : Object {
         return this._data;
      }

      override protected function draw() : void {
         var _loc1_:MessageInfoVO = null;
         var _loc2_:String = null;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = 0;
         super.draw();
         if(isInvalid(DATA_INVALID))
         {
            if(this._data)
            {
               _loc1_ = this._data.messageVO;
               this.textField.htmlText = _loc1_.message;
               _loc2_ = _loc1_.type;
               if(_loc2_)
               {
                  this.markerMc.gotoAndStop(_loc2_);
               }
               if(_loc1_.icon)
               {
                  this.icon.source = _loc1_.icon;
               }
               if(_loc1_.defaultIcon)
               {
                  this.icon.sourceAlt = _loc1_.defaultIcon;
               }
               if(!(_loc2_ == null) && allowBgFill.join().indexOf(_loc2_,0) > -1)
               {
                  this.bmpFill.visible = true;
                  this.bmpFill.repeat = "all";
                  this.bmpFill.startPos = "TL";
                  this.bmpFill.source = _loc2_ + "BgFill";
                  this.bmpFill.setSize(100,50);
               }
               else
               {
                  this.bmpFill.visible = false;
               }
               this.btnMoreInfo.visible = _loc1_.showMoreVO.enabled;
            }
            invalidate(LAYOUT_INVALID);
         }
         if(isInvalid(LAYOUT_INVALID))
         {
            this.textField.y = this._messageTopOffset;
            _loc3_ = 0;
            if(this.btnMoreInfo.visible)
            {
               _loc3_ = this.btnMoreInfo.height + this._buttonPadding + 8;
            }
            _loc4_ = this.textField.height;
            _loc5_ = Math.round(_loc4_ + this._messageTopOffset + this._messageBottomOffset + _loc3_);
            _loc6_ = 3;
            this.icon.x = _loc6_ + Math.round((this.textField.x - _loc6_ - this.icon.width) / 2);
            if(this.textField.textHeight < this.icon.height)
            {
               this.icon.y = Math.round(this.textField.y + (-this.icon.height + this.textField.textHeight) / 2 + 2);
            }
            this.markerMc.height = _loc5_ - 2 * this.markerMc.y;
            this.background.height = _loc5_;
            if(this.btnMoreInfo.visible)
            {
               this.btnMoreInfo.y = _loc4_ + this.textField.y + this._buttonPadding;
            }
            if(this.bmpFill.visible)
            {
               this.bmpFill.setSize(this.markerMc.width,_loc5_ - 2 * this.bmpFill.y);
            }
            dispatchEvent(new Event(RESIZED));
         }
      }

      protected function componentClickHandler(param1:MouseEvent) : void {
         dispatchEvent(new ServiceMessageEvent(ServiceMessageEvent.MESSAGE_AREA_CLICKED,true));
      }

      protected function btnClickHandler(param1:ButtonEvent) : void {
         dispatchEvent(new ServiceMessageEvent(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED,true));
      }

      protected function updateAfterStateChange() : void {
         isInvalid(LAYOUT_INVALID);
      }

      public function get messageTopOffset() : Number {
         return this._messageTopOffset;
      }

      public function set messageTopOffset(param1:Number) : void {
         this._messageTopOffset = param1;
         invalidate(LAYOUT_INVALID);
      }

      public function get messageBottomOffset() : Number {
         return this._messageBottomOffset;
      }

      public function set messageBottomOffset(param1:Number) : void {
         this._messageBottomOffset = param1;
         invalidate(LAYOUT_INVALID);
      }

      public function get buttonPadding() : int {
         return this._buttonPadding;
      }

      public function set buttonPadding(param1:int) : void {
         this._buttonPadding = param1;
         invalidate(LAYOUT_INVALID);
      }

      override public function get width() : Number {
         return actualWidth;
      }

      override public function get height() : Number {
         return actualHeight;
      }

      override public function dispose() : void {
         this.textField.removeEventListener(TextEvent.LINK,this.onMessageLinkClick);
         this.textField.removeEventListener(MouseEvent.CLICK,this.onMessageMouseClick);
         this.btnMoreInfo.removeEventListener(ButtonEvent.CLICK,this.btnClickHandler);
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.iconLoadingCompleteHandler);
         this.icon.removeEventListener(UILoaderEvent.IOERROR,this.iconLoadingErrorHandler);
         removeEventListener(MouseEvent.CLICK,this.componentClickHandler);
         this.background = null;
         this.icon.dispose();
         this.bmpFill.dispose();
         this.markerMc = null;
         this.btnMoreInfo.dispose();
         this.btnMoreInfo = null;
         this.textField = null;
         super.dispose();
      }
   }

}