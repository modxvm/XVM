package net.wg.gui.lobby.rankedBattles19.components.league
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.Sprite;

    public class LeagueIcon extends MovieClip implements IDisposable
    {

        public var hit:Sprite = null;

        public function LeagueIcon()
        {
            super();
            hitArea = this.hit;
        }

        public final function dispose() : void
        {
            hitArea = null;
            this.hit = null;
        }
    }
}
