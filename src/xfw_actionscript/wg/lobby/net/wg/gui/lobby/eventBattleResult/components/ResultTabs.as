package net.wg.gui.lobby.eventBattleResult.components
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.eventBattleResult.events.EventBattleResultEvent;

    public class ResultTabs extends MovieClip implements IDisposable
    {

        public var hover:ISoundButtonEx = null;

        public var textFieldBtn1:TextField = null;

        public var textFieldBtn2:TextField = null;

        private var _selectedTab:uint = 0;

        public function ResultTabs()
        {
            super();
            this.configUI();
        }

        public final function dispose() : void
        {
            this.hover.removeEventListener(MouseEvent.CLICK,this.onBtnClickHandler);
            this.hover.dispose();
            this.hover = null;
            this.textFieldBtn1 = null;
            this.textFieldBtn2 = null;
        }

        public function get selectedTab() : uint
        {
            return this._selectedTab;
        }

        private function configUI() : void
        {
            this.hover.addEventListener(MouseEvent.CLICK,this.onBtnClickHandler);
            this.updateButtons();
        }

        private function updateButtons() : void
        {
            this.textFieldBtn1.text = EVENT.RESULTSCREEN_TAB_0;
            this.textFieldBtn2.text = EVENT.RESULTSCREEN_TAB_1;
        }

        private function onBtnClickHandler(param1:MouseEvent) : void
        {
            this._selectedTab = (this._selectedTab + 1) % totalFrames;
            gotoAndStop(this._selectedTab + 1);
            this.updateButtons();
            dispatchEvent(new EventBattleResultEvent(EventBattleResultEvent.TAB_CHANGED));
        }
    }
}
