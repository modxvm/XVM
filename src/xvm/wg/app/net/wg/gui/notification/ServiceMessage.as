package net.wg.gui.notification
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.BitmapFill;
   import flash.text.TextField;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import net.wg.gui.components.common.containers.Group;
   import flash.text.StyleSheet;
   import flash.text.TextFieldAutoSize;
   import flash.events.TextEvent;
   import flash.events.MouseEvent;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.notification.events.ServiceMessageEvent;
   import net.wg.gui.notification.vo.MessageInfoVO;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.notification.constants.MessageMetrics;
   import flash.events.Event;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.notification.vo.ButtonVO;
   import __AS3__.vec.Vector;
   import net.wg.gui.components.common.containers.HorizontalGroupLayout;
   import net.wg.gui.notification.constants.ButtonType;


   public class ServiceMessage extends UIComponent
   {
          
      public function ServiceMessage() {
         super();
      }

      public static const RESIZED:String = "resized";

      private static const DATA_INVALID:String = "dataInv";

      private static const LAYOUT_INVALID:String = "layoutInv";

      private static const TIMESTAMP_INVALID:String = "tsInv";

      private static const LINK_COLOR_NORMAL:String = "#8C8C7E";

      private static const LINK_COLOR_HOVER:String = "#FF0000";

      private static var allowBgFill:Array;

      public var background:MovieClip;

      public var icon:UILoaderAlt;

      public var bgIcon:UILoaderAlt;

      public var bmpFill:BitmapFill;

      public var textField:TextField;

      private var _messageTopOffset:int = 17;

      private var _messageBottomOffset:int = 18;

      private var _buttonPadding:int = 10;

      private var _isTFClickedByMBR:Boolean = false;

      private var _data:NotificationInfoVO;

      private var timeComponent:NotificationTimeComponent;

      private var _btnsGroup:Group;

      private var _timeStamp:String = "";

      override protected function configUI() : void {
         super.configUI();
         _focusable = tabEnabled = false;
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
         this.textField.addEventListener(TextEvent.LINK,this.onMessageLinkClick,false,0,true);
         this.textField.addEventListener(MouseEvent.CLICK,this.onMessageMouseClick,false,0,true);
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.iconLoadingCompleteHandler,false,0,true);
         this.icon.addEventListener(UILoaderEvent.IOERROR,this.iconLoadingErrorHandler,false,0,true);
         addEventListener(MouseEvent.CLICK,this.componentClickHandler,false,0,true);
      }

      private function onMessageLinkClick(param1:TextEvent) : void {
         if(!this._isTFClickedByMBR)
         {
            dispatchEvent(new ServiceMessageEvent(ServiceMessageEvent.MESSAGE_LINK_CLICKED,this._data.typeID,this._data.entityID,true,false,param1.text));
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
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = NaN;
         var _loc8_:* = 0;
         var _loc9_:* = NaN;
         super.draw();
         if(isInvalid(DATA_INVALID))
         {
            if(this._data)
            {
               _loc1_ = this._data.messageVO;
               this.textField.htmlText = _loc1_.message;
               _loc2_ = _loc1_.type;
               if(_loc1_.icon)
               {
                  this.icon.source = _loc1_.icon;
               }
               if(_loc1_.bgIcon != Values.EMPTY_STR)
               {
                  this.bgIcon.source = _loc1_.bgIcon;
               }
               else
               {
                  this.bgIcon.visible = false;
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
               this.timeStamp = _loc1_.timestampStr;
               if(!this._btnsGroup)
               {
                  this.createButtonsGroup(_loc1_);
               }
               else
               {
                  this.updateButtonsGroup(_loc1_);
               }
            }
            invalidate(LAYOUT_INVALID);
         }
         if((isInvalid(TIMESTAMP_INVALID)) && !(this._timeStamp == Values.EMPTY_STR))
         {
            if(!this.timeComponent)
            {
               this.timeComponent = NotificationTimeComponent(App.utils.classFactory.getObject(Linkages.NOTIFICATION_TIME_COMPONENT));
               addChildAt(this.timeComponent,getChildIndex(this.textField) + 1);
            }
            this.timeComponent.textField.text = this._timeStamp;
            invalidate(LAYOUT_INVALID);
         }
         if(isInvalid(LAYOUT_INVALID))
         {
            if(this.timeComponent)
            {
               this.timeComponent.y = MessageMetrics.TIME_PADDING_Y;
               this.timeComponent.x = this.width - (this.timeComponent.width + MessageMetrics.TIME_PADDING_X);
            }
            _loc3_ = 0;
            if(this._btnsGroup)
            {
               _loc3_ = this._btnsGroup.height + this._buttonPadding;
            }
            _loc4_ = this.textField.height;
            _loc5_ = Math.round(_loc4_ + this._messageBottomOffset + this._messageTopOffset + _loc3_);
            _loc6_ = -1;
            if(this.bgIcon.visible)
            {
               _loc6_ = this.bgIcon.originalHeight;
            }
            _loc7_ = Math.max(_loc5_,_loc6_);
            this.background.height = _loc7_;
            if(this._btnsGroup)
            {
               this._btnsGroup.y = Math.round(_loc4_ + this.textField.y + this._buttonPadding);
            }
            if(this.bmpFill.visible)
            {
               _loc9_ = 2 * this.bmpFill.y;
               this.bmpFill.setSize(this.background.width - _loc9_,_loc7_ - _loc9_);
            }
            _loc8_ = MessageMetrics.ICON_DEFAULT_PADDING_X;
            this.icon.x = _loc8_ + Math.round((this.textField.x - _loc8_ - this.icon.width) / 2);
            if(this.textField.textHeight < this.icon.height)
            {
               this.icon.y = Math.round(this.textField.y + (-this.icon.height + this.textField.textHeight) / 2 + MessageMetrics.ICON_DEFAULT_PADDING_Y);
            }
            dispatchEvent(new Event(RESIZED));
         }
      }

      override public function get height() : Number {
         return this.background.height;
      }

      protected function componentClickHandler(param1:MouseEvent) : void {
         dispatchEvent(new ServiceMessageEvent(ServiceMessageEvent.MESSAGE_AREA_CLICKED,this._data.typeID,this._data.entityID,true));
      }

      protected function btnClickHandler(param1:ButtonEvent) : void {
         var _loc2_:ServiceMessageEvent = new ServiceMessageEvent(ServiceMessageEvent.MESSAGE_BUTTON_CLICKED,this._data.typeID,this._data.entityID,true);
         _loc2_.action = param1.target.data;
         dispatchEvent(_loc2_);
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
         return Math.ceil(actualWidth);
      }

      override protected function onDispose() : void {
         if(this.timeComponent)
         {
            this.timeComponent.dispose();
         }
         this.textField.removeEventListener(TextEvent.LINK,this.onMessageLinkClick);
         this.textField.removeEventListener(MouseEvent.CLICK,this.onMessageMouseClick);
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.iconLoadingCompleteHandler);
         this.icon.removeEventListener(UILoaderEvent.IOERROR,this.iconLoadingErrorHandler);
         removeEventListener(MouseEvent.CLICK,this.componentClickHandler);
         this.background = null;
         this.icon.dispose();
         this.bgIcon.dispose();
         this.bmpFill.dispose();
         this.removeButtonsGroup();
         this.textField = null;
         super.onDispose();
      }

      public function get btnsGroup() : Group {
         return this._btnsGroup;
      }

      public function get timeStamp() : String {
         return this._timeStamp;
      }

      public function set timeStamp(param1:String) : void {
         if(this._timeStamp != param1)
         {
            this._timeStamp = param1;
            invalidate(TIMESTAMP_INVALID);
         }
      }

      private function createButtonsGroup(param1:MessageInfoVO) : void {
         var _loc4_:SoundButtonEx = null;
         var _loc6_:ButtonVO = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc10_:String = null;
         if(!param1.areButtonsVisible())
         {
            return;
         }
         var _loc2_:Vector.<ButtonVO> = param1.buttonsLayout;
         var _loc3_:uint = _loc2_.length;
         if(_loc3_ == 0)
         {
            return;
         }
         this._btnsGroup = new Group();
         var _loc5_:HorizontalGroupLayout = new HorizontalGroupLayout();
         _loc5_.gap = MessageMetrics.BUTTONS_PADDING;
         this._btnsGroup.layout = _loc5_;
         this._btnsGroup.x = this.textField.x;
         addChild(this._btnsGroup);
         var _loc9_:* = 0;
         while(_loc9_ < _loc3_)
         {
            _loc6_ = _loc2_[_loc9_];
            _loc8_ = _loc6_.type;
            _loc10_ = ButtonType.getLinkageByType(_loc8_);
            if(_loc10_ != null)
            {
               _loc7_ = App.utils.classFactory.getObject(_loc10_);
               if(!_loc7_)
               {
                  DebugUtils.LOG_ERROR("Can not create button",_loc10_);
               }
               else
               {
                  _loc4_ = SoundButtonEx(_loc7_);
                  _loc4_.name = _loc8_;
                  _loc4_.width = _loc6_.width;
                  _loc4_.label = _loc6_.label;
                  _loc4_.data = _loc6_.action;
                  _loc4_.enabled = param1.isButtonEnabled(_loc8_);
                  _loc4_.visible = param1.isButtonVisible(_loc8_);
                  this._btnsGroup.addChild(_loc4_);
                  _loc4_.focusable = false;
                  _loc4_.validateNow();
                  _loc4_.addEventListener(ButtonEvent.CLICK,this.btnClickHandler,false,0,true);
               }
            }
            _loc9_++;
         }
         this._btnsGroup.validateNow();
      }

      private function updateButtonsGroup(param1:MessageInfoVO) : void {
         var _loc4_:ButtonVO = null;
         var _loc5_:String = null;
         var _loc6_:SoundButtonEx = null;
         if(!param1.areButtonsVisible())
         {
            this.removeButtonsGroup();
            return;
         }
         var _loc2_:Vector.<ButtonVO> = param1.buttonsLayout;
         var _loc3_:uint = _loc2_.length;
         if(_loc3_ == 0)
         {
            return;
         }
         var _loc7_:* = 0;
         while(_loc7_ < _loc3_)
         {
            _loc4_ = _loc2_[_loc7_];
            _loc5_ = _loc4_.type;
            _loc6_ = this._btnsGroup.getChildByName(_loc5_) as SoundButtonEx;
            if(_loc6_)
            {
               _loc6_.enabled = param1.isButtonEnabled(_loc5_);
               _loc6_.visible = param1.isButtonVisible(_loc5_);
            }
            _loc7_++;
         }
      }

      private function removeButtonsGroup() : void {
         var _loc1_:Object = null;
         var _loc2_:* = 0;
         if(this._btnsGroup)
         {
            _loc2_ = 0;
            while(_loc2_ < this._btnsGroup.numChildren)
            {
               _loc1_ = this._btnsGroup.getChildAt(_loc2_);
               _loc1_.removeEventListener(ButtonEvent.CLICK,this.btnClickHandler);
               _loc2_++;
            }
            this._btnsGroup.dispose();
            this._btnsGroup = null;
         }
      }
   }

}