package net.wg.gui.lobby.storage.categories.cards
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.components.controls.VO.ItemPriceVO;

    public class BaseCardVO extends DAAPIDataClass
    {

        private static const PRICE:String = "price";

        public var id:Number;

        public var contextMenuId:String = "";

        public var title:String = "";

        public var image:String = "";

        public var imageAlt:String = "";

        public var description:String = "";

        public var additionalInfo:String = "";

        public var price:ItemPriceVO;

        public var count:int;

        public var nationFlagIcon:String = "";

        public var selected:Boolean;

        public var enabled:Boolean = true;

        public var active:Boolean = false;

        public var isMoneyEnough:Boolean = true;

        public var type:String = "";

        public function BaseCardVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == PRICE && param2 != null)
            {
                this.price = new ItemPriceVO(param2);
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.price)
            {
                this.price.dispose();
                this.price = null;
            }
            super.onDispose();
        }

        public function isEqual(param1:BaseCardVO) : Boolean
        {
            if(param1 == null)
            {
                return false;
            }
            return this.id == param1.id && this.contextMenuId == param1.contextMenuId && this.title == param1.title && this.image == param1.image && this.description == param1.description && this.count == param1.count && this.nationFlagIcon == param1.nationFlagIcon && this.selected == param1.selected && this.enabled == param1.enabled && this.price == param1.price || this.price && this.price.isEquals(param1.price) && this.type == param1.type;
        }

        override public function toString() : String
        {
            return "[CardVO > id: " + this.id + ", image: " + this.image + "]";
        }
    }
}
