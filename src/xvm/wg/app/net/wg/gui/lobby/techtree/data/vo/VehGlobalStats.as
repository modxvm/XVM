package net.wg.gui.lobby.techtree.data.vo
{
   import net.wg.gui.lobby.techtree.interfaces.IValueObject;
   import net.wg.utils.ILocale;


   public class VehGlobalStats extends Object implements IValueObject
   {
          
      public function VehGlobalStats(param1:Boolean=false, param2:String=undefined, param3:ExtraInformation=null, param4:Number=undefined, param5:Boolean=false) {
         super();
         this.enableInstallItems = param1;
         this.statusString = param2;
         this.extraInfo = param3;
         this.freeXP = param4;
         this.hasNationTree = param5;
      }

      public var enableInstallItems:Boolean;

      public var statusString:String;

      public var extraInfo:ExtraInformation;

      public var freeXP:Number;

      public var hasNationTree:Boolean;

      public function fromArray(param1:Array, param2:ILocale) : void {
         if(param1.length > 4)
         {
            this.enableInstallItems = param1[0];
            this.statusString = param1[1];
            this.extraInfo = new ExtraInformation();
            this.extraInfo.fromArray(param1[2],param2);
            this.freeXP = !isNaN(param1[3])?param1[3]:0;
            this.hasNationTree = param1[4];
         }
      }

      public function fromObject(param1:Object, param2:ILocale) : void {
         if(param1 == null)
         {
            return;
         }
         if(param1.enableInstallItems != null)
         {
            this.enableInstallItems = param1.enableInstallItems;
         }
         if(param1.statusString != null)
         {
            this.statusString = param1.statusString;
         }
         this.extraInfo = new ExtraInformation();
         if(param1.extraInfo != null)
         {
            this.extraInfo.fromObject(param1.extraInfo,param2);
         }
         this.freeXP = !isNaN(param1.freeXP)?param1.freeXP:0;
         if(param1.hasNationTree != null)
         {
            this.hasNationTree = param1.hasNationTree;
         }
      }

      public function toString() : String {
         return "[VehGlobalStats: enableInstallItems = " + this.enableInstallItems + ", statusString = " + this.statusString + ", extraInfo = " + this.extraInfo + ", freeXP = " + this.freeXP + ", hasNationTree = " + this.hasNationTree + "]";
      }
   }

}