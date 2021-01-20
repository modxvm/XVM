package net.wg.gui.bootcamp.battleResult.containers.base
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.bootcamp.containers.AnimatedLoaderTextContainer;
    import net.wg.utils.StageSizeBoundaries;

    public class BattleResultVideoButtonContent extends MovieClip implements IDisposable
    {

        private static const SMALL:String = "s";

        private static const MEDIUM:String = "m";

        private static const BIG:String = "b";

        private static const DIVIDER:String = "_";

        public var content:AnimatedLoaderTextContainer = null;

        public function BattleResultVideoButtonContent()
        {
            super();
        }

        public function updateSize(param1:int) : void
        {
            var _loc3_:String = null;
            var _loc2_:Number = App.instance.appWidth;
            if(_loc2_ < StageSizeBoundaries.WIDTH_1600)
            {
                _loc3_ = SMALL;
            }
            else if(_loc2_ < StageSizeBoundaries.WIDTH_2200)
            {
                _loc3_ = MEDIUM;
            }
            else
            {
                _loc3_ = BIG;
            }
            this.gotoAndStop(_loc3_ + DIVIDER + param1);
        }

        public final function dispose() : void
        {
            this.content.dispose();
            this.content = null;
        }

        public function set source(param1:String) : void
        {
            this.content.source = param1;
        }
    }
}
