package net.wg.gui.lobby.storage.categories.cards
{
    import flash.geom.Rectangle;

    public class CardSizeVO extends Object
    {

        public var size:Rectangle;

        public var innerPadding:Rectangle;

        public var outerPadding:int;

        public var imageSize:Rectangle;

        public var descriptionOffset:int;

        public var flagsOffset:int;

        public function CardSizeVO(param1:Rectangle, param2:Rectangle, param3:int, param4:Rectangle, param5:int, param6:int)
        {
            super();
            this.size = param1;
            this.innerPadding = param2;
            this.outerPadding = param3;
            this.imageSize = param4;
            this.descriptionOffset = param5;
            this.flagsOffset = param6;
        }
    }
}
