package net.wg.gui.lobby.techtree.data.vo
{
   import net.wg.gui.lobby.techtree.interfaces.IValueObject;
   import net.wg.utils.ILocale;


   public class ExtraInformation extends Object implements IValueObject
   {
          
      public function ExtraInformation(param1:String=undefined, param2:String=undefined, param3:String=undefined, param4:String=undefined) {
         super();
         this.type = param1;
         this.title = param2;
         this.benefitsHead = param3;
         this.benefitsList = param4;
      }

      public var type:String;

      public var title:String;

      public var benefitsHead:String;

      public var benefitsList:String;

      public function fromArray(param1:Array, param2:ILocale) : void {
         if(param1.length > 3)
         {
            this.type = param1[0];
            this.title = param1[1];
            this.benefitsHead = param1[2];
            this.benefitsList = param1[3];
         }
      }

      public function fromObject(param1:Object, param2:ILocale) : void {
         if(param1 == null)
         {
            return;
         }
         if(param1.type != null)
         {
            this.type = param1.type;
         }
         if(param1.title != null)
         {
            this.title = param1.title;
         }
         if(param1.benefitsHead != null)
         {
            this.benefitsHead = param1.benefitsHead;
         }
         if(param1.benefitsList != null)
         {
            this.benefitsList = param1.benefitsList;
         }
      }

      public function toString() : String {
         return "[ExtraInformation: type = " + this.type + ", title = " + this.title + " benefitsHead = " + this.benefitsHead + " benefitsList = " + this.benefitsList + "]";
      }
   }

}