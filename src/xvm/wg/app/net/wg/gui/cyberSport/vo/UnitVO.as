package net.wg.gui.cyberSport.vo
{


   public class UnitVO extends UnitShortVO
   {
          
      public function UnitVO(param1:Object) {
         super(param1);
      }

      public var isCommander:Boolean;

      public var statusValue:Boolean;

      public var sumLevelsError:Boolean;

      public var sumLevels:String = "";

      public var statusLbl:String = "";
   }

}