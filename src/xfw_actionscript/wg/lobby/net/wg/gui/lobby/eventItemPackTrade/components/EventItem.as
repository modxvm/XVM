package net.wg.gui.lobby.eventItemPackTrade.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.eventItemPackTrade.data.ItemVO;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventItem extends Sprite implements IDisposable
    {

        public var item:UILoaderAlt = null;

        public var valueTF:TextField = null;

        private var _toolTipMgr:ITooltipMgr;

        private var _tooltip:String = "";

        private var _specialAlias:String = "";

        private var _specialArgs:Array = null;

        public function EventItem()
        {
            super();
        }

        public function configUI() : void
        {
            this._toolTipMgr = App.toolTipMgr;
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
        }

        public final function dispose() : void
        {
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            this.item.dispose();
            this.item = null;
            this.valueTF = null;
            this._toolTipMgr = null;
            this._specialArgs = null;
        }

        public function setItem(param1:ItemVO) : void
        {
            this.item.source = param1.name;
            this.valueTF.text = param1.value;
            this._tooltip = param1.tooltip;
            this._specialAlias = param1.specialAlias;
            this._specialArgs = param1.specialArgs;
        }

        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            if(StringUtils.isNotEmpty(this._tooltip))
            {
                this._toolTipMgr.showComplex(this._tooltip);
            }
            else
            {
                this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[this._specialAlias,null].concat(this._specialArgs));
            }
        }

        private function onMouseOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
