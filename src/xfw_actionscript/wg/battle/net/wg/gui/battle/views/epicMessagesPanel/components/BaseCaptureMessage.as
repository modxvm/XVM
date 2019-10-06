package net.wg.gui.battle.views.epicMessagesPanel.components
{
    import net.wg.gui.battle.views.gameMessagesPanel.components.MessageContainerBase;
    import flash.display.MovieClip;
    import net.wg.gui.battle.views.epicMessagesPanel.data.SectorBaseMessageVO;
    import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;

    public class BaseCaptureMessage extends MessageContainerBase
    {

        private static const ERROR_CONVERTING_VO:String = "[BaseCaptureMessage] setData object was not in correct structure, could not convert to proper VO";

        public var mainTextMc:MovieClip = null;

        public var timerTextMc:MovieClip = null;

        public var baseID:MovieClip = null;

        private var _msgDataVO:SectorBaseMessageVO = null;

        public function BaseCaptureMessage()
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
            var _loc2_:SectorBaseMessageVO = param1.msgData as SectorBaseMessageVO;
            App.utils.asserter.assertNotNull(_loc2_,ERROR_CONVERTING_VO);
            this._msgDataVO = _loc2_;
            this.baseID.gotoAndStop(_loc2_.baseID);
            this.mainTextMc.titleTF.text = _loc2_.title;
            this.timerTextMc.titleTF.text = _loc2_.timerText;
        }

        override protected function onDispose() : void
        {
            this.baseID = null;
            this.mainTextMc = null;
            this.timerTextMc = null;
            this._msgDataVO = null;
            super.onDispose();
        }
    }
}
