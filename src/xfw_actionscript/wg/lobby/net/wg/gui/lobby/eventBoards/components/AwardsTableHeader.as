package net.wg.gui.lobby.eventBoards.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;

    public class AwardsTableHeader extends Sprite implements IDisposable
    {

        public var groupTF:TextField = null;

        public var positionTF:TextField = null;

        public var awardsTF:TextField = null;

        public function AwardsTableHeader()
        {
            super();
        }

        public final function dispose() : void
        {
            this.groupTF = null;
            this.positionTF = null;
            this.awardsTF = null;
        }
    }
}
