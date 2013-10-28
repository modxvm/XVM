package net.wg.gui.components.icons
{
   import scaleform.clik.core.UIComponent;
   import flash.display.FrameLabel;


   public class BattleTypeIcon extends UIComponent
   {
          
      public function BattleTypeIcon() {
         super();
         stop();
         this._allTypes = this.currentLabels;
      }

      private var _type:String = "neutral";

      private var _allTypes:Array;

      private var _typeByNumber:uint = 1;

      override protected function draw() : void {
         super.draw();
         if(currentLabel != this._type)
         {
            gotoAndStop(this._type);
            this._typeByNumber = currentFrame;
         }
      }

      public function get type() : String {
         return this._type;
      }

      public function set type(param1:String) : void {
         this._type = param1;
         invalidate();
      }

      public function set typeByNumber(param1:uint) : void {
         if(this._typeByNumber == param1)
         {
            return;
         }
         this._typeByNumber = param1;
         this.type = FrameLabel(this.currentLabels[this._typeByNumber-1]).name;
         invalidate();
      }

      public function get typeByNumber() : uint {
         return this._typeByNumber;
      }

      override public function toString() : String {
         return "[WG BattleTypeIcon " + name + "]";
      }

      override public function dispose() : void {
         if(this._allTypes)
         {
            this._allTypes.splice(0,this._allTypes.length);
         }
         this._allTypes = null;
         super.dispose();
      }
   }

}