package net.wg.gui.battle.pveEvent.views.minimap.entries
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import flash.display.Sprite;
    import flash.display.Graphics;

    public class EventDeathZoneMinimapEntry extends BattleUIComponent
    {

        private static const FILL_COLOR:int = 13369344;

        private static const FILL_ALPHA:Number = 0.8;

        public var placeholder:Sprite = null;

        public function EventDeathZoneMinimapEntry()
        {
            super();
        }

        public function setZoneSize(param1:int, param2:int) : void
        {
            var _loc3_:Graphics = this.placeholder.graphics;
            _loc3_.clear();
            _loc3_.beginFill(FILL_COLOR,FILL_ALPHA);
            _loc3_.drawRect(0,0,param1,param2);
            _loc3_.endFill();
        }

        override protected function onDispose() : void
        {
            this.placeholder = null;
            super.onDispose();
        }
    }
}
