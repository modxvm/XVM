package net.wg.gui.lobby.eventHangar.components
{
    import net.wg.gui.components.common.FrameStateCmpnt;
    import net.wg.utils.helpLayout.IHelpLayoutComponent;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.lobby.profile.components.SimpleLoader;
    import net.wg.gui.lobby.eventHangar.data.EventProgressBannerVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.gfx.TextFieldEx;
    import flash.geom.Rectangle;
    import net.wg.gui.lobby.eventHangar.components.constants.EventBannerStates;
    import net.wg.utils.helpLayout.HelpLayoutVO;
    import net.wg.data.constants.Values;
    import scaleform.gfx.MouseEventEx;
    import net.wg.gui.lobby.eventHangar.events.HangarBannerEvent;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventProgressBanner extends FrameStateCmpnt implements IHelpLayoutComponent
    {

        private static const HEADER_MESSAGE_DISTANCE:int = -2;

        private static const ASSAULT_LABEL_SUFFIX:String = "_assault";

        private static const HIDE_POS_Y:int = -2500;

        private static const WIDTH_BIG:int = 220;

        private static const WIDTH_SMALL:int = 160;

        private static const HEIGHT_BIG:int = 140;

        private static const HEIGHT_SMALL:int = 120;

        private static const VISIBILITY_INV:String = "visibilityInv";

        private static const IS_ANIMATED_INV:String = "isAnimatedInv";

        private static const SEPARATOR:String = "_";

        public var txtHeader:TextField = null;

        public var txtMessage:TextField = null;

        public var fuelValue:TextField = null;

        public var fuelIcon:Sprite = null;

        public var novelty:Sprite = null;

        public var hover:EventProgressBannerHover = null;

        public var loader:SimpleLoader = null;

        private var _isPlaying:Boolean = false;

        private var _helpDirection:String = "L";

        private var _data:EventProgressBannerVO = null;

        private var _helpLayoutId:String = "";

        private var _state:String = "";

        private var _toolTipMgr:ITooltipMgr = null;

        private var _isAnimated:Boolean = false;

        public function EventProgressBanner()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.hover.addEventListener(MouseEvent.CLICK,this.onClickHandler);
            this.hover.addEventListener(MouseEvent.ROLL_OVER,this.onOverHandler);
            this.hover.addEventListener(MouseEvent.ROLL_OUT,this.onOutHandler);
            this.hover.buttonMode = this.hover.useHandCursor = true;
            App.utils.helpLayout.registerComponent(this);
            this._toolTipMgr = App.toolTipMgr;
            this.novelty.mouseEnabled = this.novelty.mouseChildren = false;
            mouseEnabled = false;
        }

        override protected function onDispose() : void
        {
            this.hover.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
            this.hover.removeEventListener(MouseEvent.ROLL_OVER,this.onOverHandler);
            this.hover.removeEventListener(MouseEvent.ROLL_OUT,this.onOutHandler);
            this.txtHeader = null;
            this.txtMessage = null;
            this.fuelValue = null;
            this.fuelIcon = null;
            this.novelty = null;
            this.hover.dispose();
            this.hover = null;
            this.loader.dispose();
            this.loader = null;
            this._toolTipMgr = null;
            this._data = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data != null)
            {
                if(isInvalid(InvalidationType.DATA))
                {
                    this.hover.setHoverState(this._state);
                    frameLabel = this.getFrameLabel();
                    if(_baseDisposed)
                    {
                        return;
                    }
                    this.txtHeader.text = EVENT.ENTRYPOINT_BANNER_HEADER;
                    TextFieldEx.setVerticalAlign(this.txtHeader,TextFieldEx.VALIGN_BOTTOM);
                    this.txtHeader.mouseEnabled = false;
                    if(this._data.isAssault && this.txtMessage != null)
                    {
                        this.txtMessage.text = EVENT.ENTRYPOINT_BANNER_ASSAULT;
                        TextFieldEx.setVerticalAlign(this.txtMessage,TextFieldEx.VALIGN_BOTTOM);
                        this.txtMessage.mouseEnabled = false;
                        this.txtHeader.y = this.txtMessage.y - this.txtHeader.height + HEADER_MESSAGE_DISTANCE | 0;
                    }
                    this.fuelIcon.mouseEnabled = this.fuelIcon.mouseChildren = false;
                    this.fuelValue.text = this._data.fuel.toString();
                    this.fuelValue.mouseEnabled = false;
                    this.novelty.visible = this._data.showNew;
                    this.loader.scrollRect = new Rectangle(0,0,this.getWidth(),this.getHeight());
                    invalidate(VISIBILITY_INV);
                }
                if(isInvalid(VISIBILITY_INV,IS_ANIMATED_INV))
                {
                    if(visible && this._isAnimated)
                    {
                        this.loader.setSource(this.getAnimationURL());
                        this._isPlaying = true;
                    }
                    else if(this._isPlaying)
                    {
                        this.loader.dispose();
                        this._isPlaying = false;
                    }
                }
            }
        }

        public function getHeight() : int
        {
            return this._state == EventBannerStates.BANNER_STATE_BIG?HEIGHT_BIG:HEIGHT_SMALL;
        }

        public function getLayoutProperties() : Vector.<HelpLayoutVO>
        {
            if(!this._helpLayoutId)
            {
                this._helpLayoutId = name + SEPARATOR + Math.random();
            }
            var _loc1_:HelpLayoutVO = new HelpLayoutVO();
            _loc1_.x = -1;
            _loc1_.y = visible?0:HIDE_POS_Y;
            _loc1_.width = this.getWidth();
            _loc1_.height = this.getHeight();
            _loc1_.extensibilityDirection = this._helpDirection;
            _loc1_.message = LOBBY_HELP.HANGAR_EVENT;
            _loc1_.id = this._helpLayoutId;
            _loc1_.scope = this;
            return new <HelpLayoutVO>[_loc1_];
        }

        public function getWidth() : int
        {
            return this._state == EventBannerStates.BANNER_STATE_BIG?WIDTH_BIG:WIDTH_SMALL;
        }

        public function setData(param1:EventProgressBannerVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        public function setState(param1:String) : void
        {
            if(this._state == param1)
            {
                return;
            }
            this._state = param1;
            invalidateData();
        }

        private function getFrameLabel() : String
        {
            return this._state + (this._data && this._data.isAssault?ASSAULT_LABEL_SUFFIX:Values.EMPTY_STR);
        }

        private function getAnimationURL() : String
        {
            if(this._state == EventBannerStates.BANNER_STATE_BIG)
            {
                if(this._data.isAssault)
                {
                    return ANIMATION_CONSTANTS.FLASH_ANIMATIONS_EVENT_BANNER_BERLIN;
                }
                return ANIMATION_CONSTANTS.FLASH_ANIMATIONS_EVENT_BANNER;
            }
            if(this._data.isAssault)
            {
                return ANIMATION_CONSTANTS.FLASH_ANIMATIONS_EVENT_BANNER_BERLIN_SMALL;
            }
            return ANIMATION_CONSTANTS.FLASH_ANIMATIONS_EVENT_BANNER_SMALL;
        }

        override public function set visible(param1:Boolean) : void
        {
            if(super.visible != param1)
            {
                super.visible = param1;
                invalidate(VISIBILITY_INV);
            }
        }

        public function get isAnimated() : Boolean
        {
            return this._isAnimated;
        }

        public function set isAnimated(param1:Boolean) : void
        {
            if(this._isAnimated == param1)
            {
                return;
            }
            this._isAnimated = param1;
            invalidate(IS_ANIMATED_INV);
        }

        private function onClickHandler(param1:MouseEvent) : void
        {
            if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
                dispatchEvent(new HangarBannerEvent(HangarBannerEvent.BANNER_CLICK));
            }
        }

        private function onOverHandler(param1:MouseEvent) : void
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

        private function onOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }
    }
}
