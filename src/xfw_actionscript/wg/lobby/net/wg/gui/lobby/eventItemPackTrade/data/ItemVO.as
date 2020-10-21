package net.wg.gui.lobby.eventItemPackTrade.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class ItemVO extends DAAPIDataClass
    {

        public var name:String = "";

        public var description:String = "";

        public var value:String = "";

        public var tooltip:String = "";

        public var specialAlias:String = "";

        public var specialArgs:Array = null;

        public function ItemVO(param1:Object)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            if(this.specialArgs != null)
            {
                this.specialArgs.splice(0,this.specialArgs.length);
                this.specialArgs = null;
            }
            super.onDispose();
        }
    }
}
