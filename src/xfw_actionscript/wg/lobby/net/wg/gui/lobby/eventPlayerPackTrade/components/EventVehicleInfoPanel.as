package net.wg.gui.lobby.eventPlayerPackTrade.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import flash.text.TextFieldAutoSize;

    public class EventVehicleInfoPanel extends Sprite implements IDisposable
    {

        private static const OFFSET:int = 5;

        public var titleTF:TextField = null;

        public var descriptionTF:TextField = null;

        public var icon:Sprite = null;

        private var _toolTipMgr:ITooltipMgr = null;

        private var _tooltip:String = null;

        public function EventVehicleInfoPanel()
        {
            super();
        }

        public function configUI() : void
        {
            this._toolTipMgr = App.toolTipMgr;
            this.icon.addEventListener(MouseEvent.MOUSE_OVER,this.onOverHandler);
            this.icon.addEventListener(MouseEvent.MOUSE_OUT,this.onOutHandler);
            this.titleTF.autoSize = TextFieldAutoSize.LEFT;
            this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
        }

        public final function dispose() : void
        {
            this.icon.removeEventListener(MouseEvent.MOUSE_OVER,this.onOverHandler);
            this.icon.removeEventListener(MouseEvent.MOUSE_OUT,this.onOutHandler);
            this.titleTF = null;
            this.descriptionTF = null;
            this.icon = null;
            this._toolTipMgr = null;
            this._tooltip = null;
        }

        public function layoutElements() : void
        {
            this.descriptionTF.x = this.titleTF.x + this.titleTF.textWidth + OFFSET;
            this.icon.x = this.descriptionTF.x + this.descriptionTF.textWidth + OFFSET;
        }

        public function setData(param1:String, param2:String, param3:String) : void
        {
            this.titleTF.text = param1;
            this.descriptionTF.text = param2;
            this._tooltip = param3;
        }

        public function get infoWidth() : int
        {
            return this.icon.x + this.icon.width;
        }

        private function onOverHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.showComplex(this._tooltip);
        }

        private function onOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
