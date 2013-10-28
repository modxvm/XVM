package net.wg.gui.components.icons
{
   import flash.display.MovieClip;
   import flash.text.TextField;


   public class SquadIcon extends MovieClip
   {
          
      public function SquadIcon() {
         super();
         stop();
      }

      public var numTf:TextField;

      public function setSquad(param1:Number) : void {
         if(param1 > 10)
         {
            this.numTf.text = String(param1 - 10);
            gotoAndStop("gold");
         }
         else
         {
            if(param1 > 0)
            {
               this.numTf.text = String(param1);
               gotoAndStop("silver");
            }
            else
            {
               this.numTf.text = "";
               gotoAndStop("empty");
            }
         }
      }

      override public function toString() : String {
         return "[WG SquadIcon " + name + "]";
      }
   }

}