package net.wg.gui.lobby.techtree.data.vo 
{
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.utils.*;
    
    public class UnlockProps extends Object implements net.wg.gui.lobby.techtree.interfaces.IValueObject
    {
        public function UnlockProps(arg1:Number=0, arg2:Number=-1, arg3:Number=0, arg4:Array=null)
        {
            super();
            this._parentID = arg1;
            this._unlockIdx = arg2;
            this._xpCost = arg3;
            this._required = arg4 == null ? [] : arg4;
            if (this._xpCost > 0) 
                this._xpCostLabel = App.utils.locale.integer(this._xpCost);
            else 
                this._xpCostLabel = "0";
            return;
        }

        public function get parentID():Number
        {
            return this._parentID;
        }

        public function get unlockIdx():Number
        {
            return this._unlockIdx;
        }

        public function get xpCost():Number
        {
            return this._xpCost;
        }

        public function get xpCostLabel():String
        {
            return this._xpCostLabel;
        }

        public function fromArray(arg1:Array, arg2:net.wg.utils.ILocale):void
        {
            if (arg1.length > 3) 
            {
                this._parentID = isNaN(arg1[0]) ? 0 : arg1[0];
                this._unlockIdx = isNaN(arg1[1]) ? 0 : arg1[1];
                this._xpCost = isNaN(arg1[2]) ? 0 : arg1[2];
                this._xpCostLabel = arg2.integer(this._xpCost);
                this._required = arg1[3];
            }
            return;
        }

        public function fromObject(arg1:Object, arg2:net.wg.utils.ILocale):void
        {
            if (arg1 == null) 
                return;
            if (!isNaN(arg1.parentID)) 
                this._parentID = arg1.parentID;
            if (!isNaN(arg1.unlockIdx)) 
                this._unlockIdx = arg1.unlockIdx;
            if (!isNaN(arg1.xpCost)) 
            {
                this._xpCost = arg1.xpCost;
                this._xpCostLabel = arg2.integer(this._xpCost);
            }
            if (arg1.required != null) 
                this._required = arg1.required;
            return;
        }

        public function hasID(arg1:Number):Boolean
        {
            return !(this._required == null) && this._required.indexOf(arg1) > -1;
        }

        public function clearUp():void
        {
            this._parentID = 0;
            this._unlockIdx = -1;
            this._xpCost = 0;
            this._xpCostLabel = "0";
            if (this._required != null) 
                this._required.splice(0, this._required.length);
            return;
        }

        public function toString():String
        {
            return "[UnlockProps: parentID = " + this._parentID + ", unlockIdx = " + this.unlockIdx + ", xpCost = " + this._xpCost + ", required = " + this._required + " ]";
        }

        internal var _parentID:Number;

        internal var _unlockIdx:Number;

        internal var _xpCost:Number;

        internal var _xpCostLabel:String;

        internal var _required:Array;
    }
}
