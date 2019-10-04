package net.wg.gui.battle.views.epicMessagesPanel.components
{
    import net.wg.gui.battle.views.gameMessagesPanel.components.MessageContainerBase;
    import flash.display.MovieClip;
    import net.wg.gui.battle.views.epicMessagesPanel.data.SectorBaseContestedMessageVO;
    import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
    import net.wg.data.constants.generated.GAME_MESSAGES_CONSTS;

    public class BaseContestedMessage extends MessageContainerBase
    {

        private static const ERROR_CONVERTING_VO:String = "[BaseContestedMessage] setData object was not in correct structure, could not convert to proper VO";

        public var mainTextMc:MovieClip = null;

        public var epicBaseInProgress:MessageBaseMarker = null;

        private var _msgDataVO:SectorBaseContestedMessageVO = null;

        public function BaseContestedMessage()
        {
            super();
        }

        override public function getID() : int
        {
            return this._msgDataVO.baseID;
        }

        override public function setData(param1:GameMessageVO) : void
        {
            messageData = param1;
            var _loc2_:SectorBaseContestedMessageVO = param1.msgData as SectorBaseContestedMessageVO;
            App.utils.asserter.assertNotNull(_loc2_,ERROR_CONVERTING_VO);
            this._msgDataVO = _loc2_;
            this.mainTextMc.titleTF.text = _loc2_.title;
            this.epicBaseInProgress.captureCircle.setOwner(messageData.messageType == GAME_MESSAGES_CONSTS.BASE_CONTESTED);
            this.epicBaseInProgress.captureCircle.updateProgress(_loc2_.progress);
            this.epicBaseInProgress.baseId.gotoAndStop(_loc2_.baseID);
        }

        override protected function onDispose() : void
        {
            this.epicBaseInProgress.dispose();
            this.epicBaseInProgress = null;
            this.mainTextMc = null;
            this._msgDataVO = null;
            super.onDispose();
        }
    }
}
