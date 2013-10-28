package net.wg.gui.lobby.techtree.data.vo
{
   import net.wg.gui.lobby.techtree.interfaces.IValueObject;
   import net.wg.utils.ILocale;


   public class UnlockProps extends Object implements IValueObject
   {
          
      public function UnlockProps(param1:Number=undefined, param2:Number=undefined, param3:Number=undefined, param4:Array=null) {
         super();
         this._parentID = param1;
         this._unlockIdx = param2;
         this._xpCost = param3;
         this._required = param4 != null?param4:[];
         if(this._xpCost > 0)
         {
            this._xpCostLabel = App.utils.locale.integer(this._xpCost);
         }
         else
         {
            this._xpCostLabel = "0";
         }
      }

      private var _parentID:Number;

      private var _unlockIdx:Number;

      private var _xpCost:Number;

      private var _xpCostLabel:String;

      private var _required:Array;

      public function get parentID() : Number {
         return this._parentID;
      }

      public function get unlockIdx() : Number {
         return this._unlockIdx;
      }

      public function get xpCost() : Number {
         return this._xpCost;
      }

      public function get xpCostLabel() : String {
         return this._xpCostLabel;
      }

      public function fromArray(param1:Array, param2:ILocale) : void {
         if(param1.length > 3)
         {
            this._parentID = isNaN(param1[0])?0:param1[0];
            this._unlockIdx = isNaN(param1[1])?0:param1[1];
            this._xpCost = isNaN(param1[2])?0:param1[2];
            this._xpCostLabel = param2.integer(this._xpCost);
            this._required = param1[3];
         }
      }

      public function fromObject(param1:Object, param2:ILocale) : void {
         if(param1 == null)
         {
            return;
         }
         if(!isNaN(param1.parentID))
         {
            this._parentID = param1.parentID;
         }
         if(!isNaN(param1.unlockIdx))
         {
            this._unlockIdx = param1.unlockIdx;
         }
         if(!isNaN(param1.xpCost))
         {
            this._xpCost = param1.xpCost;
            this._xpCostLabel = param2.integer(this._xpCost);
         }
         if(param1.required != null)
         {
            this._required = param1.required;
         }
      }

      public function hasID(param1:Number) : Boolean {
         return !(this._required == null) && this._required.indexOf(param1) > -1;
      }

      public function clearUp() : void {
         this._parentID = 0;
         this._unlockIdx = -1;
         this._xpCost = 0;
         this._xpCostLabel = "0";
         if(this._required != null)
         {
            this._required.splice(0,this._required.length);
         }
      }

      public function toString() : String {
         return "[UnlockProps: parentID = " + this._parentID + ", unlockIdx = " + this.unlockIdx + ", xpCost = " + this._xpCost + ", required = " + this._required + " ]";
      }
   }

}