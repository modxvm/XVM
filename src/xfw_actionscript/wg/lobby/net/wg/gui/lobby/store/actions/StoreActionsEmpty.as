package net.wg.gui.lobby.store.actions
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.lobby.store.actions.data.StoreActionsEmptyVo;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.store.actions.evnts.StoreActionsEvent;
    import net.wg.data.constants.Values;

    public class StoreActionsEmpty extends Sprite implements IDisposable
    {

        private static const INFO_TOP_MARGIN:Number = 15;

        private static const BTN_ACTION_TOP_MARGIN:Number = 30;

        private static const TEXT_FIELD_INSIDE_PADDING:Number = 4;

        public static const ACTION_ID_EMPTY:String = "empty";

        public var title:TextField = null;

        public var info:TextField = null;

        public var actionBtn:ISoundButtonEx = null;

        public function StoreActionsEmpty()
        {
            super();
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        public function setData(param1:String, param2:StoreActionsEmptyVo) : void
        {
            var _loc3_:* = NaN;
            this.title.text = param1;
            this.info.text = param2.info;
            this.actionBtn.label = param2.btnLabel;
            this.title.height = this.title.textHeight + TEXT_FIELD_INSIDE_PADDING ^ 0;
            this.info.height = this.info.textHeight + TEXT_FIELD_INSIDE_PADDING ^ 0;
            this.title.x = -(this.title.width >> 1);
            this.title.y = 0;
            _loc3_ = this.title.textHeight + INFO_TOP_MARGIN;
            this.info.x = -(this.info.width >> 1);
            this.info.y = _loc3_ ^ 0;
            _loc3_ = _loc3_ + (this.info.textHeight + BTN_ACTION_TOP_MARGIN);
            this.actionBtn.x = -(this.actionBtn.width >> 1);
            this.actionBtn.y = _loc3_ ^ 0;
            this.actionBtn.addEventListener(ButtonEvent.CLICK,this.onActionBtnClickHandler);
        }

        protected function onDispose() : void
        {
            this.title = null;
            this.info = null;
            this.actionBtn.removeEventListener(ButtonEvent.CLICK,this.onActionBtnClickHandler);
            this.actionBtn.dispose();
            this.actionBtn = null;
        }

        private function onActionBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new StoreActionsEvent(StoreActionsEvent.ACTION_CLICK,ACTION_ID_EMPTY,Values.EMPTY_STR));
        }
    }
}
