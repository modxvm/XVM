package net.wg.gui.lobby.store.actions.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class StoreActionsCardsVo extends DAAPIDataClass
    {

        private static const HERO_CARD_FILED:String = "heroCard";

        private static const COLUMN_LEFT_FILED:String = "columnLeft";

        private static const COLUMN_RIGHT_FILED:String = "columnRight";

        private static const COMING_SOON_FILED:String = "comingSoon";

        public var heroCardVo:StoreActionCardVo = null;

        public var storeActionCardsColumnLeft:Vector.<StoreActionCardVo> = null;

        public var storeActionCardsColumnRight:Vector.<StoreActionCardVo> = null;

        public var comingSoonVo:StoreActionCardVo = null;

        public var linkedBattleQuest:String = "";

        public function StoreActionsCardsVo(param1:Object = null)
        {
            super(param1);
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            if(param1 == HERO_CARD_FILED)
            {
                if(param2)
                {
                    this.heroCardVo = new StoreActionCardVo(param2);
                }
                return false;
            }
            var _loc3_:Array = null;
            var _loc4_:Object = null;
            if(param1 == COLUMN_LEFT_FILED)
            {
                if(param2)
                {
                    _loc3_ = param2 as Array;
                    this.storeActionCardsColumnLeft = new Vector.<StoreActionCardVo>();
                    for each(_loc4_ in _loc3_)
                    {
                        this.storeActionCardsColumnLeft.push(new StoreActionCardVo(_loc4_));
                    }
                }
                return false;
            }
            if(param1 == COLUMN_RIGHT_FILED)
            {
                if(param2)
                {
                    _loc3_ = param2 as Array;
                    this.storeActionCardsColumnRight = new Vector.<StoreActionCardVo>();
                    for each(_loc4_ in _loc3_)
                    {
                        this.storeActionCardsColumnRight.push(new StoreActionCardVo(_loc4_));
                    }
                }
                return false;
            }
            if(param1 == COMING_SOON_FILED)
            {
                if(param2)
                {
                    this.comingSoonVo = new StoreActionCardVo(param2);
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        override protected function onDispose() : void
        {
            if(this.heroCardVo)
            {
                this.heroCardVo.dispose();
                this.heroCardVo = null;
            }
            var _loc1_:StoreActionCardVo = null;
            if(this.storeActionCardsColumnLeft)
            {
                while(this.storeActionCardsColumnLeft.length)
                {
                    _loc1_ = this.storeActionCardsColumnLeft.pop();
                    _loc1_.dispose();
                }
                this.storeActionCardsColumnLeft = null;
            }
            if(this.storeActionCardsColumnRight)
            {
                while(this.storeActionCardsColumnRight.length)
                {
                    _loc1_ = this.storeActionCardsColumnRight.pop();
                    _loc1_.dispose();
                }
                this.storeActionCardsColumnRight = null;
            }
            if(this.comingSoonVo)
            {
                this.comingSoonVo.dispose();
                this.comingSoonVo = null;
            }
            super.onDispose();
        }
    }
}
