package net.wg.gui.lobby.questsWindow
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import scaleform.clik.constants.InvalidationType;


   public class DescriptionBlock extends UIComponent
   {
          
      public function DescriptionBlock() {
         super();
      }

      private static const BOTTOM_PADDING:int = 20;

      public var lableTF:TextField;

      public var descrTF:TextField;

      public var lineMC:MovieClip;

      private var _title:String = "";

      private var _descr:String = "";

      public function setLabels(param1:String, param2:String) : void {
         this._title = param1;
         this._descr = param2;
         invalidateData();
      }

      override protected function draw() : void {
         var _loc1_:* = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.lableTF.text = this._title;
            this.descrTF.text = this._descr;
            this.descrTF.y = this._title?Math.round(this.lableTF.y + this.lableTF.textHeight + 3):this.lableTF.y;
            this.lineMC.y = Math.round(this._descr?this.descrTF.y + this.descrTF.textHeight:this.lableTF.y + this.lableTF.textHeight) + BOTTOM_PADDING;
            _loc1_ = Math.round(this.lineMC.y);
            setSize(this.width,_loc1_);
         }
      }

      override public function dispose() : void {
         this.lableTF = null;
         this.descrTF = null;
         this.lineMC = null;
         super.dispose();
      }
   }

}