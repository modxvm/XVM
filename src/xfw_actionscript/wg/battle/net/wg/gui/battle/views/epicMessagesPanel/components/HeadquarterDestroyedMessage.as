package net.wg.gui.battle.views.epicMessagesPanel.components
{
    import net.wg.gui.battle.views.gameMessagesPanel.components.MessageContainerBase;
    import flash.display.MovieClip;
    import net.wg.gui.battle.views.epicMessagesPanel.data.HeadquarterDestroyedMessageVO;
    import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;

    public class HeadquarterDestroyedMessage extends MessageContainerBase
    {

        private static const ERROR_CONVERTING_VO:String = "[HeadquarterDestroyedMessage] setData object was not in correct structure, could not convert to proper VO";

        public var mainTextMc:MovieClip = null;

        public var epicHQId:MovieClip = null;

        private var _msgDataVO:HeadquarterDestroyedMessageVO = null;

        public function HeadquarterDestroyedMessage()
        {
            super();
        }

        override public function getID() : int
        {
            return this._msgDataVO.hqID;
        }

        override public function setData(param1:GameMessageVO) : void
        {
            messageData = param1;
            var _loc2_:HeadquarterDestroyedMessageVO = param1.msgData as HeadquarterDestroyedMessageVO;
            App.utils.asserter.assertNotNull(_loc2_,ERROR_CONVERTING_VO);
            this._msgDataVO = _loc2_;
            this.mainTextMc.titleTF.text = _loc2_.title;
            this.epicHQId.gotoAndStop(_loc2_.hqID);
        }

        override protected function onDispose() : void
        {
            this.mainTextMc = null;
            this.epicHQId = null;
            this._msgDataVO = null;
            super.onDispose();
        }
    }
}
