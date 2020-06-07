package net.wg.gui.lobby.hangar
{
    import net.wg.infrastructure.base.meta.impl.VehicleParametersMeta;
    import net.wg.gui.lobby.hangar.interfaces.IVehicleParameters;
    import scaleform.clik.utils.Padding;
    import net.wg.gui.components.controls.ScrollingListEx;
    import flash.display.Sprite;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.data.constants.Linkages;
    import flash.events.MouseEvent;
    import net.wg.gui.events.ListEventEx;
    import flash.events.Event;
    import net.wg.data.ListDAAPIDataProvider;
    import net.wg.gui.lobby.components.data.VehParamVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.utils.helpLayout.HelpLayoutVO;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.Directions;
    import net.wg.data.constants.SoundManagerStates;
    import net.wg.data.constants.SoundTypes;
    import scaleform.clik.interfaces.IListItemRenderer;
    import net.wg.data.constants.generated.HANGAR_ALIASES;
    import flash.display.DisplayObject;

    public class VehicleParameters extends VehicleParametersMeta implements IVehicleParameters
    {

        private static const BG_MARGIN:int = 20;

        private static const SB_PADDING:Padding = new Padding(0,0,0,7);

        private static const HELP_LAYOUT_X_CORRECTION:int = 71;

        private static const HELP_LAYOUT_W_CORRECTION:int = 72;

        private static const RENDERER_HEIGHT:int = 24;

        private static const BG_WIDTH_BIG:int = 320;

        private static const BG_WIDTH_SMALL:int = 300;

        public var paramsList:ScrollingListEx = null;

        public var bg:Sprite = null;

        public var rendererBG:Sprite = null;

        protected var _snapHeightToRenderers:Boolean = true;

        private var _dataProvider:IDataProvider = null;

        private var _helpLayoutId:String = null;

        private var _helpLayoutW:Number = 0;

        private var _isParamsAnimated:Boolean = true;

        private var _hasListeners:Boolean = false;

        public function VehicleParameters()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            App.utils.helpLayout.registerComponent(this);
            this.paramsList.itemRenderer = App.utils.classFactory.getClass(this.getRendererLinkage());
            this.paramsList.scrollBar = Linkages.SCROLL_BAR;
            this.paramsList.smartScrollBar = true;
            this.paramsList.widthAutoResize = false;
            this.paramsList.sbPadding = SB_PADDING;
            this.paramsList.addEventListener(MouseEvent.MOUSE_WHEEL,this.onParamsListMouseWheelHandler);
            this.paramsList.addEventListener(ListEventEx.ITEM_CLICK,this.onParamsListItemClickHandler);
            this.paramsList.addEventListener(ListEventEx.ITEM_ROLL_OVER,this.onParamsListItemRollOverHandler);
            this.paramsList.addEventListener(MouseEvent.ROLL_OUT,this.onParamsListRollOutHandler);
            mouseEnabled = this.paramsList.mouseEnabled = this.bg.mouseEnabled = this.bg.mouseChildren = false;
            this.hideRendererBG();
        }

        override protected function onDispose() : void
        {
            this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            if(this._hasListeners)
            {
                this.paramsList.scrollBar.removeEventListener(MouseEvent.MOUSE_DOWN,this.onParamsListScrollBarMouseDownHandler);
                this.paramsList.scrollBar.removeEventListener(MouseEvent.ROLL_OVER,this.onParamsListScrollBarRollOverHandler);
            }
            this.paramsList.removeEventListener(ListEventEx.ITEM_CLICK,this.onParamsListItemClickHandler);
            this.paramsList.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onParamsListMouseWheelHandler);
            this.paramsList.removeEventListener(ListEventEx.ITEM_ROLL_OVER,this.onParamsListItemRollOverHandler);
            this.paramsList.removeEventListener(MouseEvent.ROLL_OUT,this.onParamsListRollOutHandler);
            this.bg = null;
            this.rendererBG = null;
            this.paramsList.dispose();
            this.paramsList = null;
            this._dataProvider.cleanUp();
            this._dataProvider = null;
            super.onDispose();
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            this._dataProvider = new ListDAAPIDataProvider(VehParamVO);
            this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            this.paramsList.dataProvider = this._dataProvider;
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.paramsList.validateNow();
                this.paramsList.rowHeight = RENDERER_HEIGHT;
                _loc1_ = RENDERER_HEIGHT * this._dataProvider.length;
                if(_loc1_ > height - BG_MARGIN)
                {
                    _loc1_ = this._snapHeightToRenderers?RENDERER_HEIGHT * ((height - BG_MARGIN) / RENDERER_HEIGHT ^ 0):height;
                }
                this.paramsList.height = _loc1_;
                this.bg.height = _loc1_ + BG_MARGIN;
                dispatchEvent(new Event(Event.RESIZE));
            }
            if(!this._hasListeners)
            {
                this._hasListeners = true;
                this.paramsList.scrollBar.addEventListener(MouseEvent.MOUSE_DOWN,this.onParamsListScrollBarMouseDownHandler);
                this.paramsList.scrollBar.addEventListener(MouseEvent.ROLL_OVER,this.onParamsListScrollBarRollOverHandler);
            }
        }

        public function as_getDP() : Object
        {
            return this._dataProvider;
        }

        public function as_setIsParamsAnimated(param1:Boolean) : void
        {
            this._isParamsAnimated = param1;
        }

        public function getHelpLayoutWidth() : Number
        {
            return width;
        }

        public function getLayoutProperties() : Vector.<HelpLayoutVO>
        {
            if(StringUtils.isEmpty(this._helpLayoutId))
            {
                this._helpLayoutId = name + "_" + Math.random();
            }
            var _loc1_:HelpLayoutVO = new HelpLayoutVO();
            _loc1_.x = HELP_LAYOUT_X_CORRECTION;
            _loc1_.y = 0;
            _loc1_.width = this._helpLayoutW - HELP_LAYOUT_W_CORRECTION;
            _loc1_.height = this.bg.height;
            _loc1_.extensibilityDirection = Directions.RIGHT;
            _loc1_.message = LOBBY_HELP.HANGAR_VEHICLE_PARAMETERS;
            _loc1_.id = this._helpLayoutId;
            _loc1_.scope = this;
            return new <HelpLayoutVO>[_loc1_];
        }

        public function showHelpLayoutEx(param1:Number, param2:Number) : void
        {
            this._helpLayoutW = param2;
        }

        protected function onRendererClick() : void
        {
        }

        protected function getRendererLinkage() : String
        {
            return Linkages.VEH_PARAMS_RENDERER_UI;
        }

        private function hideRendererBG() : void
        {
            if(this.rendererBG.visible)
            {
                App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.ITEM_RDR,null);
                this.rendererBG.visible = false;
            }
        }

        private function onParamsListItemRollOverHandler(param1:ListEventEx) : void
        {
            var _loc4_:* = false;
            var _loc5_:* = 0;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            var _loc8_:IListItemRenderer = null;
            var _loc9_:* = false;
            var _loc10_:* = 0;
            var _loc11_:String = null;
            var _loc12_:* = 0;
            var _loc2_:VehParamVO = VehParamVO(param1.itemData);
            var _loc3_:String = _loc2_.state;
            if(_loc3_ == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_TOP || _loc3_ == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_BOTTOM)
            {
                _loc4_ = this.rendererBG.visible;
                _loc5_ = this.rendererBG.y;
                _loc6_ = RENDERER_HEIGHT;
                _loc7_ = param1.itemRenderer.y;
                _loc8_ = null;
                _loc9_ = true;
                _loc10_ = param1.index - this.paramsList.scrollPosition;
                _loc11_ = _loc2_.paramID;
                if(_loc10_ > 0)
                {
                    _loc8_ = this.paramsList.getRendererAt(_loc10_ - 1);
                    if(_loc11_ == VehParamVO(_loc8_.getData()).paramID)
                    {
                        _loc7_ = _loc8_.y;
                        _loc6_ = RENDERER_HEIGHT << 1;
                        _loc9_ = false;
                    }
                }
                if(_loc9_ && _loc10_ < this.paramsList.renderersCount - 1)
                {
                    _loc8_ = this.paramsList.getRendererAt(_loc10_ + 1);
                    if(_loc11_ == VehParamVO(_loc8_.getData()).paramID)
                    {
                        _loc6_ = RENDERER_HEIGHT << 1;
                    }
                }
                this.rendererBG.width = DisplayObject(this.paramsList.scrollBar).visible?BG_WIDTH_SMALL:BG_WIDTH_BIG;
                _loc12_ = _loc7_ + this.paramsList.y;
                this.rendererBG.y = _loc12_;
                this.rendererBG.height = _loc6_;
                this.rendererBG.visible = true;
                if(!_loc4_ || _loc5_ != _loc12_)
                {
                    App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.ITEM_RDR,null);
                }
            }
            else
            {
                this.hideRendererBG();
            }
        }

        private function onParamsListRollOutHandler(param1:MouseEvent) : void
        {
            this.hideRendererBG();
        }

        private function onParamsListScrollBarRollOverHandler(param1:MouseEvent) : void
        {
            this.hideRendererBG();
        }

        private function onParamsListScrollBarMouseDownHandler(param1:MouseEvent) : void
        {
            this.hideRendererBG();
            if(this._isParamsAnimated)
            {
                onListScrollS();
            }
        }

        private function onParamsListMouseWheelHandler(param1:MouseEvent) : void
        {
            this.hideRendererBG();
            if(this._isParamsAnimated)
            {
                onListScrollS();
            }
        }

        private function onParamsListItemClickHandler(param1:ListEventEx) : void
        {
            App.toolTipMgr.hide();
            this.hideRendererBG();
            onParamClickS(VehParamVO(param1.itemData).paramID);
            this.onRendererClick();
        }

        private function onDataProviderChangeHandler(param1:Event) : void
        {
            if(this._dataProvider.length > 0 && this.paramsList.renderersCount > 0)
            {
                invalidateSize();
            }
        }
    }
}
