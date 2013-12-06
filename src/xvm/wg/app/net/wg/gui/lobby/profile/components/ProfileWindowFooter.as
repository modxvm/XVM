package net.wg.gui.lobby.profile.components
{
   import flash.text.TextField;
   import flash.display.MovieClip;
   import flash.text.TextFieldAutoSize;
   import flash.events.MouseEvent;
   import scaleform.clik.constants.InvalidationType;
   import net.wg.gui.lobby.profile.data.ProfileUserVO;
   import net.wg.data.constants.Values;


   public class ProfileWindowFooter extends UserDateFooter
   {
          
      public function ProfileWindowFooter() {
         super();
      }

      private static const LAYOUT_INVALID:String = "layInv";

      private static function cutText(param1:TextField, param2:String) : String {
         var _loc4_:* = 0;
         param1.htmlText = param2;
         var _loc3_:* = -1;
         try
         {
            _loc3_ = param1.getLineLength(1);
         }
         catch(e:Error)
         {
         }
         if(_loc3_ != -1)
         {
            _loc4_ = param1.getLineLength(0) + param1.getLineLength(1) / 2;
            param2 = param2.substr(0,_loc4_);
            processCutText(param1,param2);
         }
         return param1.htmlText;
      }

      private static function processCutText(param1:TextField, param2:String) : void {
         var _loc3_:String = null;
         if(param1.getLineLength(1) != -1)
         {
            _loc3_ = param2.substr(0,param2.length-1);
            _loc3_ = _loc3_ + "...";
            param1.htmlText = _loc3_;
            if(param1.getLineLength(1) != -1)
            {
               processCutText(param1,_loc3_.substr(0,_loc3_.length - 3));
            }
         }
      }

      private var _sidesGap:uint = 10;

      public var textUserInfo:TextField;

      public var leftTextHitMC:MovieClip;

      public var background:MovieClip;

      private var _textLeft:String = " ";

      override protected function configUI() : void {
         super.configUI();
         textDates.autoSize = TextFieldAutoSize.LEFT;
         this.textUserInfo.selectable = textDates.selectable = false;
         this.textUserInfo.mouseEnabled = false;
         this.leftTextHitMC.addEventListener(MouseEvent.MOUSE_OVER,this.leftTextMouseOverHandler,false,0,true);
         this.leftTextHitMC.addEventListener(MouseEvent.MOUSE_OUT,this.leftTextMouseOutHandler,false,0,true);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.textUserInfo.htmlText = cutText(this.textUserInfo,this._textLeft);
            invalidate(LAYOUT_INVALID);
         }
         if(isInvalid(LAYOUT_INVALID))
         {
            this.textUserInfo.x = this._sidesGap;
            textDates.x = this.width - this._sidesGap - textDates.width;
            this.background.width = this.width;
         }
      }

      override public function setUserData(param1:ProfileUserVO) : void {
         var _loc2_:String = param1.clanName != Values.EMPTY_STR?"[" + param1.clanName + "] ":param1.clanName;
         this._textLeft = param1.clanName != Values.EMPTY_STR?param1.clanPosition + " " + param1.clanLabel + " " + "<b>" + _loc2_ + "</b>" + param1.clanNameDescr + ". ":"";
         super.setUserData(param1);
      }

      public function get sidesGap() : uint {
         return this._sidesGap;
      }

      public function set sidesGap(param1:uint) : void {
         this._sidesGap = param1;
         invalidate(LAYOUT_INVALID);
      }

      private function leftTextMouseOverHandler(param1:MouseEvent) : void {
         App.toolTipMgr.show(this._textLeft);
      }

      private function leftTextMouseOutHandler(param1:MouseEvent) : void {
         App.toolTipMgr.hide();
      }

      override public function dispose() : void {
         this.leftTextHitMC.removeEventListener(MouseEvent.MOUSE_OVER,this.leftTextMouseOverHandler);
         this.leftTextHitMC.removeEventListener(MouseEvent.MOUSE_OUT,this.leftTextMouseOutHandler);
         super.dispose();
      }
   }

}