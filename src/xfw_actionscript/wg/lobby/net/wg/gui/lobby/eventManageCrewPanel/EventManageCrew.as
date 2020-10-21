package net.wg.gui.lobby.eventManageCrewPanel
{
    import net.wg.infrastructure.base.meta.impl.EventManageCrewMeta;
    import net.wg.infrastructure.base.meta.IEventManageCrewMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.Image;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventManageCrewPanel.data.EventManageCrewVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;
    import flash.events.Event;

    public class EventManageCrew extends EventManageCrewMeta implements IEventManageCrewMeta
    {

        public static const VISIBILITY_CHANGED:String = "manageCrewVisibilityChanged";

        private static const ICON_COMPLETED_OFFSET:int = 0;

        private static const DEFAULT_BG_FRAME:String = "default";

        private static const HEIGHT:int = 90;

        public var textField:TextField = null;

        public var icon:Image = null;

        public var btnRepair:SoundButtonEx = null;

        public var price:TextField = null;

        public var iconCompleted:Sprite = null;

        public var textCompleted:TextField = null;

        public var activatedHighlight:Sprite = null;

        public var background:MovieClip = null;

        private var _data:EventManageCrewVO = null;

        private var _toolTipMgr:ITooltipMgr;

        public function EventManageCrew()
        {
            this._toolTipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.btnRepair.addEventListener(ButtonEvent.CLICK,this.onBtnRepairClickHandler);
            addEventListener(MouseEvent.MOUSE_OVER,this.onInfoIconRollOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.onInfoIconRollOutHandler);
            this.textCompleted.text = EVENT.HANGAR_CREW_BOOSTER_PANEL_ACTIVATED;
            App.utils.commons.updateTextFieldSize(this.textCompleted,true,false);
            addEventListener(MouseEvent.CLICK,this.clickHandler,false,int.MAX_VALUE);
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.btnRepair.label = this._data.buttonLabel;
                this.textField.text = this._data.description;
                this.btnRepair.enabled = this._data.buttonEnabled;
                this.icon.source = this._data.icon;
                _loc1_ = StringUtils.isNotEmpty(this._data.inStorage);
                if(_loc1_)
                {
                    this.price.text = this._data.inStorage;
                }
                else
                {
                    this.price.htmlText = this._data.cost;
                }
                if(this._data.bgFrame)
                {
                    this.background.gotoAndStop(this._data.bgFrame);
                }
                else
                {
                    this.background.gotoAndStop(DEFAULT_BG_FRAME);
                }
                if(_baseDisposed)
                {
                    return;
                }
                this.price.visible = !this._data.isActivated || _loc1_;
                this.btnRepair.visible = !this._data.isActivated;
                this.iconCompleted.visible = this.textCompleted.visible = this.activatedHighlight.visible = this._data.isActivated;
                App.utils.commons.updateTextFieldSize(this.textField,true,false);
                this.iconCompleted.x = this.textCompleted.x + this.textCompleted.width + ICON_COMPLETED_OFFSET | 0;
            }
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.CLICK,this.clickHandler);
            this._toolTipMgr = null;
            removeEventListener(MouseEvent.MOUSE_OVER,this.onInfoIconRollOverHandler);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onInfoIconRollOutHandler);
            this.btnRepair.removeEventListener(ButtonEvent.CLICK,this.onBtnRepairClickHandler);
            this.btnRepair.dispose();
            this.btnRepair = null;
            this.price = null;
            this.icon.dispose();
            this.icon = null;
            this.textField = null;
            this.iconCompleted = null;
            this.textCompleted = null;
            this.activatedHighlight = null;
            this.background = null;
            this._data = null;
            super.onDispose();
        }

        override protected function setData(param1:EventManageCrewVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function as_setVisible(param1:Boolean) : void
        {
            if(visible != param1)
            {
                visible = param1;
                this.dispatchVisibilityChange();
            }
        }

        private function dispatchVisibilityChange() : void
        {
            dispatchEvent(new Event(VISIBILITY_CHANGED));
        }

        override public function get height() : Number
        {
            return HEIGHT;
        }

        private function onBtnRepairClickHandler(param1:ButtonEvent) : void
        {
            onApplyS();
        }

        private function onInfoIconRollOverHandler(param1:MouseEvent) : void
        {
            if(this._data == null)
            {
                return;
            }
            if(StringUtils.isNotEmpty(this._data.tooltip))
            {
                this._toolTipMgr.showComplex(this._data.tooltip);
            }
            else
            {
                this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[this._data.specialAlias,null].concat(this._data.specialArgs));
            }
        }

        private function clickHandler(param1:MouseEvent) : void
        {
            if(param1.target != this.btnRepair)
            {
                param1.stopImmediatePropagation();
            }
        }

        private function onInfoIconRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
