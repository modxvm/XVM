package net.wg.gui.lobby.techtree.data.vo 
{
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.utils.*;
    
    public class NodeData extends Object implements net.wg.gui.lobby.techtree.interfaces.IValueObject
    {
        public function NodeData()
        {
            super();
            return;
        }

        public function get earnedXP():Number
        {
            return this._earnedXP;
        }

        public function set earnedXP(arg1:Number):void
        {
            if (this._earnedXP == arg1) 
                return;
            this._earnedXP = arg1;
            if (this._earnedXP > 0) 
                this._earnedXPLabel = App.utils.locale.integer(this._earnedXP);
            else 
                this._earnedXPLabel = "";
            return;
        }

        public function get earnedXPLabel():String
        {
            return this._earnedXPLabel;
        }

        public function fromArray(arg1:Array, arg2:net.wg.utils.ILocale):void
        {
            throw new Error("Does not call method NodeData.fromArray.");
        }

        public function fromObject(arg1:Object, arg2:net.wg.utils.ILocale):void
        {
            var loc1:*=null;
            if (arg1 == null) 
                return;
            if (!isNaN(arg1.id)) 
                this.id = arg1.id;
            if (arg1.nameString != null) 
                this.nameString = arg1.nameString;
            this.primaryClass = new net.wg.gui.lobby.techtree.data.vo.PrimaryClass();
            if (arg1.primaryClass != null) 
                this.primaryClass.fromObject(arg1.primaryClass, arg2);
            if (arg1.level != null) 
                this.level = arg1.level;
            if (!isNaN(arg1.earnedXP)) 
                this.earnedXP = arg1.earnedXP;
            if (!isNaN(arg1.state)) 
                this.state = arg1.state;
            this.unlockProps = new net.wg.gui.lobby.techtree.data.vo.UnlockProps();
            if (arg1.unlockProps != null) 
                this.unlockProps.fromArray(arg1.unlockProps, arg2);
            if (arg1.hasOwnProperty("extraInfo")) 
            {
                loc1 = arg1["extraInfo"];
                if (loc1) 
                    this.extraInfo = loc1;
            }
            if (arg1.smallIconPath != null) 
                this.smallIconPath = arg1.smallIconPath;
            if (arg1.iconPath != null) 
                this.iconPath = arg1.iconPath;
            if (arg1.longName != null) 
                this.longName = arg1.longName;
            if (arg1.pickleDump != null) 
                this.pickleDump = arg1.pickleDump;
            this.shopPrice = new net.wg.gui.lobby.techtree.data.vo.ShopPrice();
            if (arg1.shopPrice != null) 
                this.shopPrice.fromArray(arg1.shopPrice, arg2);
            if (displayInfoClass != null) 
                this.displayInfo = new displayInfoClass();
            if (!(arg1.displayInfo == null) && !(this.displayInfo == null is net.wg.gui.lobby.techtree.interfaces.IValueObject)) 
                (this.displayInfo as net.wg.gui.lobby.techtree.interfaces.IValueObject).fromObject(arg1.displayInfo, arg2);
            return;
        }

        public function clearUp():void
        {
            this.id = 0;
            this.nameString = "";
            this.primaryClass = null;
            this.level = -1;
            this._earnedXP = 0;
            this._earnedXPLabel = "";
            this.state = 0;
            this.iconPath = "";
            this.longName = "";
            this.pickleDump = "";
            this.shopPrice = null;
            this.extraInfo = null;
            if (this.unlockProps != null) 
                this.unlockProps.clearUp();
            if (this.displayInfo != null) 
                this.displayInfo.clearUp();
            return;
        }

        public function toString():String
        {
            return "[\nNodeData:\n id = " + this.id + ",\n nameString = " + this.nameString + ",\n primaryClass = " + this.primaryClass + ",\n level = " + this.level + ",\n earnedXP = " + this.earnedXP + ",\n state = " + this.state + ",\n unlockProps = " + this.unlockProps + ",\n iconPath = " + this.iconPath + ",\n longName = " + this.longName + ",\n extraInfo = " + this.extraInfo + ",\n pickleDump = " + this.pickleDump + ",\n shopPrice = " + this.shopPrice + "\n displayInfo = " + this.displayInfo + "\n]";
        }

        public static function setDisplayInfoClass(arg1:Class):void
        {
            displayInfoClass = arg1;
            return;
        }

        
        {
            displayInfoClass = null;
        }

        public static const NODE_DUMP_FIELD:String="nodeDump";

        public static const UNLOCK_PROPS_FIELD:String="unlockProps";

        internal var _earnedXP:Number=0;

        internal var _earnedXPLabel:String="";

        public var id:Number=0;

        public var nameString:String="";

        public var primaryClass:net.wg.gui.lobby.techtree.data.vo.PrimaryClass=null;

        public var level:int=-1;

        public var state:Number=0;

        public var unlockProps:net.wg.gui.lobby.techtree.data.vo.UnlockProps=null;

        public var smallIconPath:String="";

        public var iconPath:String="";

        public var longName:String="";

        public var pickleDump:String="";

        public var shopPrice:net.wg.gui.lobby.techtree.data.vo.ShopPrice=null;

        public var displayInfo:Object=null;

        public var extraInfo:String=null;

        internal static var displayInfoClass:Class=null;
    }
}
