package net.wg.gui.lobby.techtree.controls
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.constants.InvalidationType;


   public class LevelDelimiter extends UIComponent
   {
          
      public function LevelDelimiter() {
         super();
      }

      private var _levelNumber:int = 1;

      public var level:MovieClip;

      public var background:Sprite;

      public function get levelNumber() : int {
         return this._levelNumber;
      }

      public function set levelNumber(param1:int) : void {
         if(this._levelNumber == param1)
         {
            return;
         }
         this._levelNumber = param1;
         invalidateData();
      }

      override protected function configUI() : void {
         constraints = new Constraints(this,ConstrainMode.REFLOW);
         constraints.addElement(this.level.name,this.level,Constraints.CENTER_H);
         constraints.addElement(this.background.name,this.background,Constraints.ALL);
         super.configUI();
      }

      override protected function draw() : void {
         super.draw();
         if(!(this.level == null) && (isInvalid(InvalidationType.DATA)))
         {
            this.level.gotoAndStop(this._levelNumber);
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            constraints.update(_width,_height);
         }
      }
   }

}