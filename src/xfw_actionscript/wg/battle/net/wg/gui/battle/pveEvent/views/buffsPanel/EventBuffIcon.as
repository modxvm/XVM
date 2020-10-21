package net.wg.gui.battle.pveEvent.views.buffsPanel
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.battle.components.BattleAtlasSprite;

    public class EventBuffIcon extends MovieClip implements IDisposable
    {

        public var icon:BattleAtlasSprite = null;

        public function EventBuffIcon()
        {
            super();
        }

        public function set iconPath(param1:String) : void
        {
            this.icon.imageName = param1;
        }

        public final function dispose() : void
        {
            this.icon = null;
        }
    }
}
