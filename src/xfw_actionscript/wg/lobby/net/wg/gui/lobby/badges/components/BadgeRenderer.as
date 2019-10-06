package net.wg.gui.lobby.badges.components
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import flash.text.TextField;
    import net.wg.infrastructure.interfaces.IImage;
    import flash.display.Sprite;
    import net.wg.gui.components.assets.NewIndicator;
    import net.wg.gui.lobby.badges.data.BadgeVO;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.gui.lobby.badges.events.BadgesEvent;

    public class BadgeRenderer extends SoundListItemRenderer
    {

        private static const INV_SELECTED:String = "inv_selected";

        private static const NOT_ENABLED_ALPHA:Number = 0.7;

        private static const ICON_NOT_ENABLED_ALPHA:Number = 0.5;

        private static const STATE_NORMAL:String = "normal";

        private static const STATE_SELECTED:String = "selected";

        private static const STATE_DISABLED:String = "disabled";

        public var titleTF:TextField = null;

        public var descrTF:TextField = null;

        public var icon:IImage = null;

        public var selectedImg:IImage = null;

        public var hit:Sprite = null;

        public var highlightIcon:IImage = null;

        public var newIndicator:NewIndicator = null;

        private var _badgeData:BadgeVO = null;

        private var _seenByUser:Boolean = false;

        public function BadgeRenderer()
        {
            super();
        }

        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            this._badgeData = BadgeVO(param1);
            invalidateData();
        }

        override protected function configUI() : void
        {
            super.configUI();
            hitArea = this.hit;
            this.newIndicator.mouseChildren = false;
            this.newIndicator.mouseEnabled = false;
            addEventListener(ButtonEvent.CLICK,this.onClickHandler);
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            super.draw();
            if(this._badgeData != null && isInvalid(InvalidationType.DATA))
            {
                enabled = this._badgeData.enabled;
                gotoAndStop(enabled?STATE_NORMAL:STATE_DISABLED);
                alpha = enabled?1:NOT_ENABLED_ALPHA;
                this.titleTF.htmlText = this._badgeData.title;
                this.descrTF.htmlText = this._badgeData.description;
                this.icon.alpha = enabled?1:ICON_NOT_ENABLED_ALPHA;
                this.icon.source = this._badgeData.icon;
                this.highlightIcon.source = this._badgeData.highlightIcon;
                if(!this._seenByUser)
                {
                    _loc1_ = this._badgeData.isFirstLook;
                    this.newIndicator.visible = _loc1_;
                    if(_loc1_)
                    {
                        this.newIndicator.shine();
                    }
                }
            }
            if(isInvalid(INV_SELECTED))
            {
                if(_selected)
                {
                    if(this.selectedImg && StringUtils.isEmpty(this.selectedImg.source))
                    {
                        this.selectedImg.source = RES_ICONS.MAPS_ICONS_LIBRARY_COMPLETEDINDICATOR;
                    }
                    gotoAndStop(STATE_SELECTED);
                }
                else
                {
                    gotoAndStop(STATE_NORMAL);
                }
            }
        }

        override protected function onDispose() : void
        {
            removeEventListener(ButtonEvent.CLICK,this.onClickHandler);
            this.icon.dispose();
            this.icon = null;
            if(this.selectedImg)
            {
                this.selectedImg.dispose();
                this.selectedImg = null;
            }
            this.newIndicator.dispose();
            this.newIndicator = null;
            this.highlightIcon.dispose();
            this.highlightIcon = null;
            this.titleTF = null;
            this.descrTF = null;
            this.hit = null;
            this._badgeData = null;
            super.onDispose();
        }

        public function getBadgeID() : int
        {
            if(this._badgeData == null)
            {
                return -1;
            }
            return this._badgeData.id;
        }

        override public function set selected(param1:Boolean) : void
        {
            if(_selected == param1)
            {
                return;
            }
            super.selected = param1;
            invalidate(INV_SELECTED);
        }

        private function onClickHandler(param1:ButtonEvent) : void
        {
            if(this._badgeData.isFirstLook)
            {
                this.newIndicator.hide();
                this._seenByUser = true;
            }
            dispatchEvent(new BadgesEvent(BadgesEvent.BADGE_RENDERER_CLICK,true));
        }
    }
}
