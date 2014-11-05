package net.wg.gui.lobby.techtree.data.vo
{
    import net.wg.gui.lobby.techtree.interfaces.IValueObject;
    import net.wg.utils.ILocale;
    
    public class ExtraInformation extends Object implements IValueObject
    {
        
        public function ExtraInformation(param1:String = "", param2:String = "", param3:String = "", param4:String = "", param5:Boolean = false)
        {
            super();
            this.type = param1;
            this.title = param2;
            this.benefitsHead = param3;
            this.benefitsList = param4;
            this.isPremiumIgr = param5;
        }
        
        public var type:String;
        
        public var title:String;
        
        public var benefitsHead:String;
        
        public var benefitsList:String;
        
        public var isPremiumIgr:Boolean;
        
        public function fromArray(param1:Array, param2:ILocale) : void
        {
            if(param1.length > 4)
            {
                this.type = param1[0];
                this.title = param1[1];
                this.benefitsHead = param1[2];
                this.benefitsList = param1[3];
                this.isPremiumIgr = param1[4];
            }
        }
        
        public function fromObject(param1:Object, param2:ILocale) : void
        {
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
            if(param1.isPremiumIgr != null)
            {
                this.isPremiumIgr = param1.isPremiumIgr;
            }
        }
        
        public function toString() : String
        {
            return "[ExtraInformation: type = " + this.type + ", title = " + this.title + " benefitsHead = " + this.benefitsHead + " benefitsList = " + this.benefitsList + " isPremiumIgr = " + this.isPremiumIgr + "]";
        }
    }
}
