package net.wg.gui.lobby.tankman
{


   public class PersonalCaseDocsModel extends Object
   {
          
      public function PersonalCaseDocsModel() {
         this.firstNames = [];
         this.lastNames = [];
         this.icons = [];
         super();
      }

      public var firstNames:Array;

      public var lastNames:Array;

      public var icons:Array;

      public var userGold:Number = 0;

      public var userCredits:Number = 0;

      public var priceOfGold:Number = 0;

      public var priceOfCredits:Number = 0;

      public var defPriceOfGold:Number = 0;

      public var defPriceOfCredits:Number = 0;

      public var useOnlyGold:Boolean = false;

      public var currentTankmanFirstName:String = null;

      public var currentTankmanLastName:String = null;

      public var currentTankmanIcon:String = null;

      public var originalIconFile:String = null;

      public var actionPrc:Number = 0;

      public var fistNameMaxChars:uint = 0;

      public var lastNameMaxChars:uint = 0;
   }

}