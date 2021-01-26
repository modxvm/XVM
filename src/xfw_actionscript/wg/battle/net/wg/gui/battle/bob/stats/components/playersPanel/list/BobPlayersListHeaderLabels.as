package net.wg.gui.battle.bob.stats.components.playersPanel.list
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;

    public class BobPlayersListHeaderLabels extends Sprite implements IDisposable
    {

        private static const TEAM_NAME_KEY_PREFIX:String = "blogger_";

        public var teamLeaderHeaderLabel:TextField;

        public var teamHeaderLabel:TextField;

        public function BobPlayersListHeaderLabels()
        {
            super();
            this.teamHeaderLabel.autoSize = TextFieldAutoSize.LEFT;
            this.teamLeaderHeaderLabel.autoSize = TextFieldAutoSize.LEFT;
        }

        public final function dispose() : void
        {
            this.teamLeaderHeaderLabel = null;
            this.teamHeaderLabel = null;
        }

        public function setBloggerId(param1:int) : void
        {
            var _loc2_:String = TEAM_NAME_KEY_PREFIX + param1;
            this.teamHeaderLabel.text = BOB.BATTLE_TEAM_HEADER;
            this.teamLeaderHeaderLabel.text = BOB.battle(_loc2_);
            this.teamLeaderHeaderLabel.x = this.teamHeaderLabel.width;
        }
    }
}
