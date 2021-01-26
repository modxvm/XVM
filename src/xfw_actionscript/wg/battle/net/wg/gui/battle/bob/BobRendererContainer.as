package net.wg.gui.battle.bob
{
    import net.wg.gui.battle.random.battleloading.renderers.RandomRendererContainer;
    import net.wg.gui.battle.components.BattleAtlasSprite;

    public class BobRendererContainer extends RandomRendererContainer
    {

        public var selfBgEnemy0:BattleAtlasSprite;

        public var selfBgEnemy1:BattleAtlasSprite;

        public var selfBgEnemy2:BattleAtlasSprite;

        public var selfBgEnemy3:BattleAtlasSprite;

        public var selfBgEnemy4:BattleAtlasSprite;

        public var selfBgEnemy5:BattleAtlasSprite;

        public var selfBgEnemy6:BattleAtlasSprite;

        public var selfBgEnemy7:BattleAtlasSprite;

        public var selfBgEnemy8:BattleAtlasSprite;

        public var selfBgEnemy9:BattleAtlasSprite;

        public var selfBgEnemy10:BattleAtlasSprite;

        public var selfBgEnemy11:BattleAtlasSprite;

        public var selfBgEnemy12:BattleAtlasSprite;

        public var selfBgEnemy13:BattleAtlasSprite;

        public var selfBgEnemy14:BattleAtlasSprite;

        public var selfBgsEnemy:Vector.<BattleAtlasSprite>;

        public function BobRendererContainer()
        {
            super();
            this.selfBgsEnemy = new <BattleAtlasSprite>[this.selfBgEnemy0,this.selfBgEnemy1,this.selfBgEnemy2,this.selfBgEnemy3,this.selfBgEnemy4,this.selfBgEnemy5,this.selfBgEnemy6,this.selfBgEnemy7,this.selfBgEnemy8,this.selfBgEnemy9,this.selfBgEnemy10,this.selfBgEnemy11,this.selfBgEnemy12,this.selfBgEnemy13,this.selfBgEnemy14];
        }

        override public function dispose() : void
        {
            this.selfBgEnemy0 = null;
            this.selfBgEnemy1 = null;
            this.selfBgEnemy2 = null;
            this.selfBgEnemy3 = null;
            this.selfBgEnemy4 = null;
            this.selfBgEnemy5 = null;
            this.selfBgEnemy6 = null;
            this.selfBgEnemy7 = null;
            this.selfBgEnemy8 = null;
            this.selfBgEnemy9 = null;
            this.selfBgEnemy10 = null;
            this.selfBgEnemy11 = null;
            this.selfBgEnemy12 = null;
            this.selfBgEnemy13 = null;
            this.selfBgEnemy14 = null;
            super.dispose();
        }
    }
}
