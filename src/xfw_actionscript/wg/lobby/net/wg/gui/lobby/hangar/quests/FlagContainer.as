package net.wg.gui.lobby.hangar.quests
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.Image;

    public class FlagContainer extends Sprite implements IDisposable
    {

        public var flagIcon:Image = null;

        private var _src:String = "";

        public function FlagContainer()
        {
            super();
        }

        public final function dispose() : void
        {
            this.flagIcon.dispose();
            this.flagIcon = null;
        }

        public function set flag(param1:String) : void
        {
            if(this._src == param1)
            {
                return;
            }
            this._src = param1;
            this.flagIcon.source = this._src;
        }
    }
}
