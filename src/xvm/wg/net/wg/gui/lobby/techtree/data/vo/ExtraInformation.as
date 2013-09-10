package net.wg.gui.lobby.techtree.data.vo 
{
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.utils.*;
    
    public class ExtraInformation extends Object implements net.wg.gui.lobby.techtree.interfaces.IValueObject
    {
        public function ExtraInformation(arg1:String="", arg2:String="", arg3:String="", arg4:String="")
        {
            super();
            this.type = arg1;
            this.title = arg2;
            this.benefitsHead = arg3;
            this.benefitsList = arg4;
            return;
        }

        public function fromArray(arg1:Array, arg2:net.wg.utils.ILocale):void
        {
            if (arg1.length > 3) 
            {
                this.type = arg1[0];
                this.title = arg1[1];
                this.benefitsHead = arg1[2];
                this.benefitsList = arg1[3];
            }
            return;
        }

        public function fromObject(arg1:Object, arg2:net.wg.utils.ILocale):void
        {
            if (arg1 == null) 
                return;
            if (arg1.type != null) 
                this.type = arg1.type;
            if (arg1.title != null) 
                this.title = arg1.title;
            if (arg1.benefitsHead != null) 
                this.benefitsHead = arg1.benefitsHead;
            if (arg1.benefitsList != null) 
                this.benefitsList = arg1.benefitsList;
            return;
        }

        public function toString():String
        {
            return "[ExtraInformation: type = " + this.type + ", title = " + this.title + " benefitsHead = " + this.benefitsHead + " benefitsList = " + this.benefitsList + "]";
        }

        public var type:String;

        public var title:String;

        public var benefitsHead:String;

        public var benefitsList:String;
    }
}
