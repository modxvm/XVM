package net.wg.gui.lobby.techtree.data.vo 
{
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.utils.*;
    
    public class VehGlobalStats extends Object implements net.wg.gui.lobby.techtree.interfaces.IValueObject
    {
        public function VehGlobalStats(arg1:Boolean=false, arg2:String="", arg3:net.wg.gui.lobby.techtree.data.vo.ExtraInformation=null, arg4:Number=0, arg5:Boolean=false)
        {
            super();
            this.enableInstallItems = arg1;
            this.statusString = arg2;
            this.extraInfo = arg3;
            this.freeXP = arg4;
            this.hasNationTree = arg5;
            return;
        }

        public function fromArray(arg1:Array, arg2:net.wg.utils.ILocale):void
        {
            if (arg1.length > 4) 
            {
                this.enableInstallItems = arg1[0];
                this.statusString = arg1[1];
                this.extraInfo = new net.wg.gui.lobby.techtree.data.vo.ExtraInformation();
                this.extraInfo.fromArray(arg1[2], arg2);
                this.freeXP = isNaN(arg1[3]) ? 0 : arg1[3];
                this.hasNationTree = arg1[4];
            }
            return;
        }

        public function fromObject(arg1:Object, arg2:net.wg.utils.ILocale):void
        {
            if (arg1 == null) 
            {
                return;
            }
            if (arg1.enableInstallItems != null) 
            {
                this.enableInstallItems = arg1.enableInstallItems;
            }
            if (arg1.statusString != null) 
            {
                this.statusString = arg1.statusString;
            }
            this.extraInfo = new net.wg.gui.lobby.techtree.data.vo.ExtraInformation();
            if (arg1.extraInfo != null) 
            {
                this.extraInfo.fromObject(arg1.extraInfo, arg2);
            }
            this.freeXP = isNaN(arg1.freeXP) ? 0 : arg1.freeXP;
            if (arg1.hasNationTree != null) 
            {
                this.hasNationTree = arg1.hasNationTree;
            }
            return;
        }

        public function toString():String
        {
            return "[VehGlobalStats: enableInstallItems = " + this.enableInstallItems + ", statusString = " + this.statusString + ", extraInfo = " + this.extraInfo + ", freeXP = " + this.freeXP + ", hasNationTree = " + this.hasNationTree + "]";
        }

        public var enableInstallItems:Boolean;

        public var statusString:String;

        public var extraInfo:net.wg.gui.lobby.techtree.data.vo.ExtraInformation;

        public var freeXP:Number;

        public var hasNationTree:Boolean;
    }
}
