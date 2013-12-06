package net.wg.gui.components.controls
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.data.VO.UserVO;
   import flash.text.TextFormat;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.data.constants.Values;


   public class UserNameField extends UIComponent
   {
          
      public function UserNameField() {
         this.shadowColorList =
            {
               "White":
                  {
                     "color":16777215,
                     "strange":0.4,
                     "quality":3,
                     "angle":90
                  }
               ,
               "Black":
                  {
                     "color":0,
                     "strange":1,
                     "quality":2,
                     "angle":270
                  }
               
            }
         ;
         super();
         this._textFormat = this.textField.getTextFormat();
      }

      public var textField:TextField;

      private var _userVO:UserVO;

      private var _textFormat:TextFormat;

      private var _textFont:String;

      private var _textSize:Number = 12;

      private var _textAlign:String;

      private var _textColor:Number = 16777215;

      private var _shadowColor:String = "Black";

      private var _showToolTip:Boolean = true;

      private var shadowColorList:Object;

      protected var _toolTip:String = "";

      private var _altToolTip:String = "";

      override protected function preInitialize() : void {
         constraints = new Constraints(this,ConstrainMode.REFLOW);
      }

      public function get showToolTip() : Boolean {
         return this._showToolTip;
      }

      public function set showToolTip(param1:Boolean) : void {
         this._showToolTip = param1;
      }

      override protected function configUI() : void {
         constraints.addElement("textField",this.textField,Constraints.ALL);
         constraints.update(width,height);
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.handleMouseRollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.handleMouseRollOut);
      }

      override public function dispose() : void {
         super.dispose();
      }

      protected function handleMouseRollOver(param1:MouseEvent) : void {
         if(this._showToolTip)
         {
            if(this._altToolTip)
            {
               App.toolTipMgr.show(this._altToolTip);
            }
            else
            {
               if(this._toolTip)
               {
                  App.toolTipMgr.show(this._toolTip);
               }
            }
         }
      }

      protected function handleMouseRollOut(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      override protected function draw() : void {
         var _loc1_:DropShadowFilter = null;
         var _loc2_:* = false;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this._textFormat.size = this._textSize;
            this._textFormat.font = this._textFont;
            this._textFormat.align = this._textAlign;
            this.textField.setTextFormat(this._textFormat);
            this.textField.textColor = this._textColor;
            _loc1_ = this.getDropShadowFilter(this._shadowColor);
            this.textField.filters = [_loc1_];
            constraints.update(_width,_height);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            if(this.userVO)
            {
               _loc2_ = App.utils.commons.formatPlayerName(this.textField,this.userVO.userName,this.userVO.clanAbbrev,this.userVO.region,this.userVO.igrType > 0);
               this._showToolTip = _loc2_;
               if(_loc2_)
               {
                  this._toolTip = this.userVO.fullName;
               }
               else
               {
                  this._toolTip = null;
               }
            }
            else
            {
               this.textField.text = Values.EMPTY_STR;
            }
            this.textField.setTextFormat(this._textFormat);
            this.textField.textColor = this._textColor;
         }
      }

      private function getDropShadowFilter(param1:String) : DropShadowFilter {
         var _loc2_:DropShadowFilter = new DropShadowFilter();
         _loc2_.color = this.shadowColorList[param1].color;
         _loc2_.angle = this.shadowColorList[param1].angle;
         _loc2_.alpha = 1;
         _loc2_.blurX = 0;
         _loc2_.blurY = 0;
         _loc2_.distance = 1;
         _loc2_.strength = this.shadowColorList[param1].strange;
         _loc2_.inner = false;
         _loc2_.knockout = false;
         _loc2_.quality = int(this.shadowColorList[param1].quality);
         return _loc2_;
      }

      public function get textFont() : String {
         return this._textFont;
      }

      public function set textFont(param1:String) : void {
         if(this._textFont == param1)
         {
            return;
         }
         this._textFont = param1;
         invalidateState();
      }

      public function get textSize() : Number {
         return this._textSize;
      }

      public function set textSize(param1:Number) : void {
         if(this._textSize == param1)
         {
            return;
         }
         this._textSize = param1;
         invalidateState();
      }

      public function get textAlign() : String {
         return this._textAlign;
      }

      public function set textAlign(param1:String) : void {
         if(this._textAlign == param1)
         {
            return;
         }
         this._textAlign = param1;
         invalidateState();
      }

      public function get textColor() : Number {
         return this._textColor;
      }

      public function set textColor(param1:Number) : void {
         if(this._textColor == param1)
         {
            return;
         }
         this._textColor = param1;
         invalidateState();
      }

      public function get shadowColor() : String {
         return this._shadowColor;
      }

      public function set shadowColor(param1:String) : void {
         if(this._shadowColor == param1)
         {
            return;
         }
         this._shadowColor = param1;
         invalidateState();
      }

      public function get toolTip() : String {
         return this._toolTip;
      }

      public function set toolTip(param1:String) : void {
         if(this._toolTip == param1)
         {
            return;
         }
         this._toolTip = App.utils.locale.makeString(param1);
      }

      public function get altToolTip() : String {
         return this._altToolTip;
      }

      public function set altToolTip(param1:String) : void {
         if(this._altToolTip == param1)
         {
            return;
         }
         this._altToolTip = App.utils.locale.makeString(param1);
      }

      public function get userVO() : UserVO {
         return this._userVO;
      }

      public function set userVO(param1:UserVO) : void {
         this._userVO = param1;
         invalidateData();
      }
   }

}