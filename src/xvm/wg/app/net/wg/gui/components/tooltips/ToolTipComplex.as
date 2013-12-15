package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import __AS3__.vec.Vector;
   import net.wg.data.managers.ITooltipProps;


   public class ToolTipComplex extends ToolTipBase
   {
          
      public function ToolTipComplex() {
         super();
         this.contentList = new Vector.<TextField>();
      }

      private static const COLOR_HEADER:String = "#fdf4ce";

      private static function setTextProp(param1:TextField, param2:String, param3:TextFormat, param4:String) : void {
         param3.align = param4;
         param3.leading = 2;
         param1.wordWrap = true;
         param1.multiline = true;
         param1.autoSize = param4;
         param1.embedFonts = true;
         var _loc5_:Number = App.utils.toUpperOrLowerCase(param2,false).indexOf("face=\"",0);
         if(_loc5_ > 0)
         {
            param3.font = param2.slice(_loc5_ + 6,param2.indexOf("\"",_loc5_ + 6));
         }
         else
         {
            param3.font = "$TextFont";
         }
         if(param2.slice(0,1) == "#")
         {
            param1.htmlText = param2;
            param1.textColor = Utils.instance.convertStringColorToNumber(COLOR_HEADER);
         }
         else
         {
            param1.htmlText = "<font color=\"" + COLOR_HEADER + "\" size=\"12\">" + param2 + "</font>";
         }
         param1.setTextFormat(param3);
      }

      private var _minWidth:Number;

      private var _maxWidth:Number;

      private var _leftMargin:Number = 10;

      private var _rightMargin:Number = 10;

      private var _topMargin:Number = 6;

      private var _bottomMargin:Number = 11;

      private var contTopMargin:Number = 10;

      private var contLeftMargin:Number = 13;

      private var contentList:Vector.<TextField>;

      override public function build(param1:Object, param2:ITooltipProps) : void {
         this.setProp(param2);
         this.setContent(param1);
         redraw();
      }

      private function setProp(param1:ITooltipProps) : void {
         _props = param1;
         this._minWidth = param1.minWidth;
         this._maxWidth = param1.maxWidth;
      }

      override protected function updateSize() : void {
         var _loc1_:Object = this.calcDimension();
         background.x = background.y = 0;
         background.width = Math.round(_loc1_.w) + this._leftMargin + this._rightMargin;
         background.height = Math.round(_loc1_.h) + this._topMargin + this._bottomMargin;
      }

      private function calcDimension() : Object {
         var _loc7_:TextField = null;
         var _loc8_:* = NaN;
         var _loc1_:Number = this._maxWidth;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:int = this.contentList.length;
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = this.contentList[_loc5_];
            if(this._maxWidth)
            {
               _loc7_.y = _loc7_.y + _loc3_;
               if(_loc1_ < _loc7_.width)
               {
                  _loc8_ = _loc7_.textHeight;
                  _loc7_.width = _loc1_;
                  _loc7_.height = _loc7_.textHeight + 4;
                  _loc3_ = _loc3_ + (_loc7_.textHeight - _loc8_);
               }
            }
            else
            {
               if(_loc1_ < _loc7_.width)
               {
                  _loc1_ = this.contentList[_loc5_].width;
               }
            }
            if(_loc2_ < _loc7_.y + _loc7_.textHeight)
            {
               _loc2_ = _loc7_.y + _loc7_.textHeight;
            }
            _loc5_++;
         }
         _loc1_ = _loc1_ + 5;
         var _loc6_:Object =
            {
               "w":_loc1_,
               "h":_loc2_
            }
         ;
         return _loc6_;
      }

      private function setContent(param1:Object) : void {
         var _loc7_:TextField = null;
         this._leftMargin = 10;
         this._rightMargin = 10;
         this._topMargin = 6;
         this._bottomMargin = 11;
         var _loc2_:Number = this.contTopMargin;
         var _loc3_:Number = 0;
         var _loc4_:TextFormat = new TextFormat();
         var _loc5_:Number = 10;
         var _loc6_:Number = this._minWidth == 0?500:this._minWidth;
         switch(typeof param1)
         {
            case "string":
               _loc7_ = new TextField();
               _loc7_.x = this.contLeftMargin;
               _loc7_.y = _loc2_;
               _loc7_.width = _loc6_;
               _loc7_.height = _loc5_;
               setTextProp(_loc7_,String(param1),_loc4_,"left");
               _loc7_.width = _loc7_.textWidth + 4;
               _loc3_ = _loc7_.textHeight;
               this.contentList.push(_loc7_);
               addChild(_loc7_);
               break;
         }
      }
   }

}