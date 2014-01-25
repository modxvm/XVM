package net.wg.gui.lobby.techtree.data.vo
{
   import net.wg.gui.lobby.techtree.interfaces.IValueObject;
   import net.wg.utils.ILocale;
   import net.wg.gui.lobby.techtree.constants.NamedLabels;


   public class NodeData extends Object implements IValueObject
   {
          
      public function NodeData() {
         super();
      }

      private static var displayInfoClass:Class = null;

      public static const NODE_DUMP_FIELD:String = "nodeDump";

      public static const UNLOCK_PROPS_FIELD:String = "unlockProps";

      public static function setDisplayInfoClass(param1:Class) : void {
         displayInfoClass = param1;
      }

      private var _earnedXP:Number = 0;

      private var _defEarnedXP:Number = 0;

      private var _earnedXPLabel:String = "";

      public var id:Number = 0;

      public var nameString:String = "";

      public var primaryClass:PrimaryClass = null;

      public var level:int = -1;

      public var state:Number = 0;

      public var unlockProps:UnlockProps = null;

      public var smallIconPath:String = "";

      public var iconPath:String = "";

      public var longName:String = "";

      public var shopPrice:ShopPrice = null;

      public var displayInfo:Object = null;

      public var extraInfo:String = null;

      public function get earnedXP() : Number {
         return this._earnedXP;
      }

      public function set earnedXP(param1:Number) : void {
         if(this._earnedXP == param1)
         {
            return;
         }
         this._earnedXP = param1;
         if(this._earnedXP > 0)
         {
            this._earnedXPLabel = App.utils.locale.integer(this._earnedXP);
         }
         else
         {
            this._earnedXPLabel = "";
         }
      }

      public function fromArray(param1:Array, param2:ILocale) : void {
         throw new Error("Does not call method NodeData.fromArray.");
      }

      public function fromObject(param1:Object, param2:ILocale) : void {
         var _loc3_:String = null;
         if(param1 == null)
         {
            return;
         }
         if(!isNaN(param1.id))
         {
            this.id = param1.id;
         }
         if(param1.nameString != null)
         {
            this.nameString = param1.nameString;
         }
         this.primaryClass = new PrimaryClass();
         if(param1.primaryClass != null)
         {
            this.primaryClass.fromObject(param1.primaryClass,param2);
         }
         if(param1.level != null)
         {
            this.level = param1.level;
         }
         if(!isNaN(param1.earnedXP))
         {
            this.earnedXP = param1.earnedXP;
         }
         if(!isNaN(param1.defEarnedXP))
         {
            this._defEarnedXP = param1.defEarnedXP;
         }
         if(!isNaN(param1.state))
         {
            this.state = param1.state;
         }
         this.unlockProps = new UnlockProps();
         if(param1.unlockProps != null)
         {
            this.unlockProps.fromArray(param1.unlockProps,param2);
         }
         if(param1.hasOwnProperty("extraInfo"))
         {
            _loc3_ = param1["extraInfo"];
            if(_loc3_)
            {
               this.extraInfo = _loc3_;
            }
         }
         if(param1.smallIconPath != null)
         {
            this.smallIconPath = param1.smallIconPath;
         }
         if(param1.iconPath != null)
         {
            this.iconPath = param1.iconPath;
         }
         if(param1.longName != null)
         {
            this.longName = param1.longName;
         }
         this.shopPrice = new ShopPrice();
         if(param1.shopPrice != null)
         {
            this.shopPrice.fromArray(param1.shopPrice,param2);
         }
         if(displayInfoClass != null)
         {
            this.displayInfo = new displayInfoClass();
         }
         if(!(param1.displayInfo == null) && !(this.displayInfo == null  is  IValueObject))
         {
            (this.displayInfo as IValueObject).fromObject(param1.displayInfo,param2);
         }
      }

      public function clearUp() : void {
         this.id = 0;
         this.nameString = "";
         this.primaryClass = null;
         this.level = -1;
         this._earnedXP = 0;
         this._defEarnedXP = 0;
         this._earnedXPLabel = "";
         this.state = 0;
         this.iconPath = "";
         this.longName = "";
         this.shopPrice = null;
         this.extraInfo = null;
         if(this.unlockProps != null)
         {
            this.unlockProps.clearUp();
         }
         if(this.displayInfo != null)
         {
            this.displayInfo.clearUp();
         }
      }

      public function getNamedLabel(param1:String) : String {
         var _loc2_:String = null;
         switch(param1)
         {
            case NamedLabels.XP_COST:
               _loc2_ = this.unlockProps.xpCostLabel;
               break;
            case NamedLabels.EARNED_XP:
               _loc2_ = this._earnedXPLabel;
               break;
            case NamedLabels.CREDITS_PRICE:
               _loc2_ = this.shopPrice.creditsLabel;
               break;
            case NamedLabels.GOLD_PRICE:
               _loc2_ = this.shopPrice.goldLabel;
               break;
            default:
               _loc2_ = "";
         }
         return _loc2_;
      }

      public function getNamedValue(param1:String) : Number {
         var _loc2_:* = NaN;
         switch(param1)
         {
            case NamedLabels.XP_COST:
               _loc2_ = this.unlockProps.xpCost;
               break;
            case NamedLabels.EARNED_XP:
               _loc2_ = this._earnedXP;
               break;
            case NamedLabels.CREDITS_PRICE:
               _loc2_ = this.shopPrice.credits;
               break;
            case NamedLabels.GOLD_PRICE:
               _loc2_ = this.shopPrice.gold;
               break;
            default:
               _loc2_ = 0;
         }
         return _loc2_;
      }

      public function getActionData(param1:String) : ActionData {
         var _loc2_:ActionData = new ActionData();
         switch(param1)
         {
            case NamedLabels.XP_COST:
               _loc2_.price = this.unlockProps.xpCost;
               _loc2_.defaultPrice = this.unlockProps.defXpCost;
               break;
            case NamedLabels.EARNED_XP:
               _loc2_.price = this._earnedXP;
               _loc2_.defaultPrice = this._defEarnedXP;
               break;
            case NamedLabels.CREDITS_PRICE:
               _loc2_.price = this.shopPrice.credits;
               _loc2_.defaultPrice = this.shopPrice.defCredits;
               _loc2_.actionPrice = this.shopPrice.actionPrc;
               break;
            case NamedLabels.GOLD_PRICE:
               _loc2_.price = this.shopPrice.gold;
               _loc2_.defaultPrice = this.shopPrice.defGold;
               _loc2_.actionPrice = this.shopPrice.actionPrc;
               break;
            default:
               _loc2_.price = 0;
         }
         return _loc2_;
      }

      public function toString() : String {
         return "[\nNodeData:\n id = " + this.id + ",\n nameString = " + this.nameString + ",\n primaryClass = " + this.primaryClass + ",\n level = " + this.level + ",\n earnedXP = " + this.earnedXP + ",\n state = " + this.state + ",\n unlockProps = " + this.unlockProps + ",\n iconPath = " + this.iconPath + ",\n longName = " + this.longName + ",\n extraInfo = " + this.extraInfo + ",\n shopPrice = " + this.shopPrice + "\n displayInfo = " + this.displayInfo + "\n defEarnedXP = " + this._defEarnedXP + "\n]";
      }
   }

}