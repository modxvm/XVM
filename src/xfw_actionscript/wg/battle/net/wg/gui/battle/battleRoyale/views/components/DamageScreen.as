package net.wg.gui.battle.battleRoyale.views.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;

    public class DamageScreen extends Sprite implements IDisposable
    {

        private static const SHINE_LBL:String = "shine";

        public var shine:MovieClip = null;

        private var _showMoveAnim:Boolean = false;

        public function DamageScreen()
        {
            super();
            this.shine.stop();
            mouseChildren = mouseEnabled = false;
        }

        public final function dispose() : void
        {
            this.shine = null;
        }

        public function showSingleShineAnim() : void
        {
            this.shine.gotoAndPlay(SHINE_LBL);
        }

        public function updateStage(param1:Number, param2:Number) : void
        {
            this.shine.width = param1;
            this.shine.height = param2;
        }

        override public function set visible(param1:Boolean) : void
        {
            this._showMoveAnim = !visible && visible != param1;
            super.visible = param1;
        }
    }
}
