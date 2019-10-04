package net.wg.gui.lobby.storage.categories.cards
{
    public class BlueprintCardVO extends BaseCardVO
    {

        public var fragmentsProgress:String = "";

        public var fragmentsCostText:String = "";

        public var hasDiscount:Boolean = false;

        public var availableToUnlock:Boolean = false;

        public var convertAvailable:Boolean = false;

        public function BlueprintCardVO(param1:Object)
        {
            super(param1);
        }

        override public function toString() : String
        {
            return "[BlueprintCardVO > id: " + id + ", image: " + image + "]";
        }
    }
}
