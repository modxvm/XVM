package net.wg.gui.lobby.vehiclePreview20
{
    import net.wg.infrastructure.base.meta.impl.VehiclePreview20Meta;
    import net.wg.infrastructure.base.meta.IVehiclePreview20Meta;
    import net.wg.utils.IStageSizeDependComponent;
    import net.wg.data.constants.generated.VEHPREVIEW_CONSTANTS;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.components.advanced.interfaces.IBackButton;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.vehiclePreview20.header.IVehiclePreviewHeader;
    import net.wg.gui.lobby.vehiclePreview20.buyingPanel.IVPBottomPanel;
    import flash.display.Sprite;
    import flash.text.TextField;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.display.Stage;
    import net.wg.gui.lobby.vehiclePreview20.infoPanel.VPInfoPanel;
    import net.wg.gui.lobby.hangar.VehicleParameters;
    import scaleform.clik.motion.Tween;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.vehiclePreview20.data.VPPageVO;
    import scaleform.clik.data.DataProvider;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.vehicleCompare.events.VehCompareEvent;
    import net.wg.gui.events.ViewStackEvent;
    import net.wg.gui.events.LobbyEvent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.vehiclePreview20.utils.VehiclePreviewAdaptive;
    import org.idmedia.as3commons.util.StringUtils;
    import flash.display.DisplayObject;
    import net.wg.utils.StageSizeBoundaries;
    import scaleform.clik.events.InputEvent;

    public class VehiclePreview20Page extends VehiclePreview20Meta implements IVehiclePreview20Meta, IStageSizeDependComponent
    {

        private static const _bottomPanelLinkageToAlias:Object = {};

        private static const INTRO_FLAG:String = "showIntro";

        private static const BIG_OFFSET:int = 50;

        private static const SMALL_OFFSET:int = BIG_OFFSET >> 1;

        private static const BIG_PANELS_VERTICAL_OFFSET:int = 90;

        private static const SMALL_PANELS_VERTICAL_OFFSET:int = 84;

        private static const FADE_ANIMATION_DURATION:int = 200;

        private static const FADE_ANIMATION_DELAY:int = 150;

        private static const INTRO_ANIMATION_DURATION:int = 500;

        private static const INTRO_ANIMATION_DELAY:int = 200;

        private static const SHOW_SLOTS_ALPHA:Number = 1;

        private static const HIDE_SLOTS_ALPHA:Number = 0.0;

        private static const NAVIGATION_BUTTONS_OFFSET:int = 10;

        private static const VEH_DESCRIPTION_H_OFFSET:int = 2;

        private static const VEH_PARAMS_H_OFFSET:int = 35;

        private static const VEH_PARAMS_V_OFFSET:int = 20;

        {
            _bottomPanelLinkageToAlias[VEHPREVIEW_CONSTANTS.BUYING_PANEL_LINKAGE] = VEHPREVIEW_CONSTANTS.BUYING_PANEL_PY_ALIAS;
            _bottomPanelLinkageToAlias[VEHPREVIEW_CONSTANTS.EVENT_PROGRESSION_BUYING_PANEL_LINKAGE] = VEHPREVIEW_CONSTANTS.EVENT_PROGRESSION_BUYING_PANEL_PY_ALIAS;
            _bottomPanelLinkageToAlias[VEHPREVIEW_CONSTANTS.TRADE_IN_BUYING_PANEL_LINKAGE] = VEHPREVIEW_CONSTANTS.TRADE_IN_BUYING_PANEL_PY_ALIAS;
            _bottomPanelLinkageToAlias[VEHPREVIEW_CONSTANTS.SECRET_EVENT_BUYING_PANEL_LINKAGE] = VEHPREVIEW_CONSTANTS.SECRET_EVENT_BUYING_PANEL_PY_ALIAS;
            _bottomPanelLinkageToAlias[VEHPREVIEW_CONSTANTS.SECRET_EVENT_BUYING_ACTION_PANEL_LINKAGE] = VEHPREVIEW_CONSTANTS.SECRET_EVENT_BUYING_ACTION_PANEL_PY_ALIAS;
            _bottomPanelLinkageToAlias[VEHPREVIEW_CONSTANTS.SECRET_EVENT_BOUGHT_PANEL_LINKAGE] = VEHPREVIEW_CONSTANTS.SECRET_EVENT_BOUGHT_PANEL_PY_ALIAS;
            _bottomPanelLinkageToAlias[VEHPREVIEW_CONSTANTS.SECRET_EVENT_SOLD_PANEL_LINKAGE] = VEHPREVIEW_CONSTANTS.SECRET_EVENT_SOLD_PANEL_PY_ALIAS;
        }

        public var closeButton:ISoundButtonEx;

        public var backButton:IBackButton;

        public var leftBackground:MovieClip;

        public var rightBackground:MovieClip;

        public var headerPanel:IVehiclePreviewHeader;

        public var bottomPanel:IVPBottomPanel;

        public var messengerBg:Sprite;

        public var fadingPanels:MovieClip = null;

        public var background:Sprite;

        public var headerBg:Sprite;

        public var eventProgressionBg:Sprite;

        public var secretEventBg:Sprite;

        public var compareBlock:CompareBlock;

        public var listDesc:TextField = null;

        private var _toolTipMgr:ITooltipMgr;

        private var _stage:Stage;

        private var _infoPanel:VPInfoPanel = null;

        private var _vehParams:VehicleParameters = null;

        private var _tweens:Vector.<Tween>;

        private var _offset:int = 50;

        private var _panelVerticalOffset:int = 90;

        private var _isIntroFinished:Boolean;

        private var _bottomPanelLinkage:String;

        public function VehiclePreview20Page()
        {
            this._toolTipMgr = App.toolTipMgr;
            this._stage = App.stage;
            super();
            this._vehParams = this.fadingPanels.vehParams;
            this._vehParams.addEventListener(Event.RESIZE,this.onVehParamsResizeHandler);
            this._infoPanel = this.fadingPanels.infoPanel;
            this.listDesc = this.fadingPanels.listDesc;
            this._tweens = new Vector.<Tween>(0);
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            setSize(param1,param2);
        }

        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            var _loc2_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>(0);
            var _loc3_:* = 0;
            _loc2_.push(InteractiveObject(this.backButton));
            if(this.bottomPanel != null)
            {
                _loc2_.push(InteractiveObject(this.bottomPanel.getBtn()));
                _loc3_ = 1;
            }
            _loc2_.push(InteractiveObject(this.compareBlock.addToCompareButton));
            _loc2_.push(InteractiveObject(this.closeButton));
            App.utils.commons.initTabIndex(_loc2_);
            setFocus(_loc2_[_loc3_]);
            _loc2_.splice(0,_loc2_.length);
        }

        override protected function setData(param1:VPPageVO) : void
        {
            this._infoPanel.setData(param1);
            this.closeButton.label = param1.closeBtnLabel;
            this.backButton.label = param1.backBtnLabel;
            this.backButton.descrLabel = param1.backBtnDescrLabel;
            this.closeButton.visible = param1.showCloseBtn;
            this.backButton.visible = param1.showBackButton;
            this.compareBlock.setData(param1);
            this.listDesc.htmlText = param1.listDesc;
            invalidateSize();
        }

        override protected function setTabsData(param1:DataProvider) : void
        {
            this._infoPanel.setTabsData(param1);
            invalidate(INTRO_FLAG);
        }

        override protected function show3DSceneTooltip(param1:String, param2:Array) : void
        {
            this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[param1,null].concat(param2));
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabled = false;
            this.fadingPanels.mouseEnabled = false;
            this.leftBackground.mouseEnabled = this.leftBackground.mouseChildren = false;
            this.rightBackground.mouseEnabled = this.rightBackground.mouseChildren = false;
            this.secretEventBg.mouseEnabled = this.secretEventBg.mouseChildren = false;
            this.headerBg.mouseEnabled = this.headerBg.mouseChildren = false;
            this.listDesc.autoSize = TextFieldAutoSize.RIGHT;
            this.listDesc.wordWrap = true;
            this.listDesc.multiline = true;
            this.listDesc.mouseWheelEnabled = this.listDesc.mouseEnabled = false;
            this.background.mouseEnabled = this.background.mouseChildren = false;
            this.backButton.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
            this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            this.compareBlock.alpha = 0;
            this.compareBlock.addEventListener(VehCompareEvent.ADD,this.onCompareBlockAddHandler);
            this._infoPanel.viewStack.addEventListener(ViewStackEvent.NEED_UPDATE,this.onStackViewNeedUpdateHandler);
            this._infoPanel.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onStackViewChangedHandler);
            this._infoPanel.alpha = 0;
            this._vehParams.bg.visible = false;
            this._vehParams.alpha = 0;
            registerFlashComponentS(this._vehParams,VEHPREVIEW_CONSTANTS.PARAMETERS_PY_ALIAS);
            App.stageSizeMgr.register(this);
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            this._stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyUpHandler,true);
            if(this.bottomPanel != null)
            {
                this.bottomPanel.alpha = 0;
            }
            this.eventProgressionBg.visible = this._bottomPanelLinkage == VEHPREVIEW_CONSTANTS.EVENT_PROGRESSION_BUYING_PANEL_LINKAGE;
            this.secretEventBg.visible = VEHPREVIEW_CONSTANTS.SECRET_EVENT_LINKAGES.indexOf(this._bottomPanelLinkage) != -1;
            if(this.bottomPanel != null)
            {
                registerFlashComponentS(IDAAPIModule(this.bottomPanel),_bottomPanelLinkageToAlias[this._bottomPanelLinkage]);
                this.bottomPanel.addEventListener(Event.RESIZE,this.onBottomPanelResizeHandler);
            }
            this.headerBg.visible = this.headerPanel != null;
            if(this.headerPanel != null)
            {
                registerFlashComponentS(IDAAPIModule(this.headerPanel),VEHPREVIEW_CONSTANTS.SECRET_EVENT_HEADER_WIDGET_PY_ALIAS);
                this.headerPanel.resize(width,height);
            }
        }

        override protected function onBeforeDispose() : void
        {
            this._infoPanel.viewStack.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onStackViewNeedUpdateHandler);
            this._infoPanel.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onStackViewChangedHandler);
            this.compareBlock.removeEventListener(VehCompareEvent.ADD,this.onCompareBlockAddHandler);
            this.backButton.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
            this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyUpHandler);
            this._stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
            this._stage.removeEventListener(LobbyEvent.DRAGGING_START,this.onDraggingStartHandler);
            this._stage.removeEventListener(LobbyEvent.DRAGGING_END,this.onDraggingEndHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            App.stageSizeMgr.unregister(this);
            this.compareBlock.dispose();
            this.compareBlock = null;
            this.disposeTweens();
            this._tweens = null;
            this.backButton.dispose();
            this.backButton = null;
            this.closeButton.dispose();
            this.closeButton = null;
            this.leftBackground = null;
            this.rightBackground = null;
            this.messengerBg = null;
            this.headerPanel = null;
            this._bottomPanelLinkage = null;
            if(this.bottomPanel != null)
            {
                this.bottomPanel.removeEventListener(Event.RESIZE,this.onBottomPanelResizeHandler);
                this.bottomPanel = null;
            }
            this._toolTipMgr = null;
            this._stage = null;
            this._vehParams.removeEventListener(Event.RESIZE,this.onVehParamsResizeHandler);
            this._vehParams = null;
            this._infoPanel = null;
            this.background = null;
            this.fadingPanels = null;
            this.listDesc = null;
            this.eventProgressionBg = null;
            this.secretEventBg = null;
            this.headerBg = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.leftBackground.height = height;
                this.rightBackground.x = width - this.rightBackground.width | 0;
                this.rightBackground.height = height;
                this.background.width = width;
                this.background.height = height;
                this.messengerBg.width = width;
                this.messengerBg.y = height | 0;
                this.backButton.x = this._offset - NAVIGATION_BUTTONS_OFFSET;
                this.closeButton.x = width - this._offset - this.closeButton.width + NAVIGATION_BUTTONS_OFFSET | 0;
                _loc1_ = 0;
                if(this.bottomPanel != null)
                {
                    _loc1_ = this.bottomPanel.getTotalHeight();
                }
                _loc2_ = height - this._offset - _loc1_;
                this._vehParams.x = width - this._offset - this._vehParams.width + VEH_PARAMS_H_OFFSET ^ 0;
                this._vehParams.y = this._offset + this._panelVerticalOffset + VEH_PARAMS_V_OFFSET;
                this._infoPanel.x = this._offset;
                this._infoPanel.y = this._offset + this._panelVerticalOffset;
                this._vehParams.height = _loc2_ - this._vehParams.y - this.listDesc.height;
                this._infoPanel.height = _loc2_ - this._infoPanel.y;
                if(this.bottomPanel != null)
                {
                    this.bottomPanel.x = width - this.bottomPanel.width >> 1;
                    this.bottomPanel.y = height - VehiclePreviewAdaptive.bottomPanelGap - this.bottomPanel.height | 0;
                }
                this.compareBlock.x = width - this._offset - this.compareBlock.width | 0;
                this.compareBlock.y = this._offset + this._panelVerticalOffset;
                this.listDesc.x = width - this._offset - this.listDesc.width + VEH_DESCRIPTION_H_OFFSET ^ 0;
                this.listDesc.y = this._vehParams.y + this._vehParams.bg.height | 0;
                if(this.eventProgressionBg.visible)
                {
                    this.eventProgressionBg.x = width - this.eventProgressionBg.width >> 1;
                    this.eventProgressionBg.y = height - this.eventProgressionBg.height >> 0;
                }
                if(this.headerPanel != null)
                {
                    this.headerPanel.resize(width,height);
                }
                this.adjustBottomShadow(this.secretEventBg);
                if(this.headerBg.visible)
                {
                    this.headerBg.x = width - this.headerBg.width >> 1;
                }
            }
            if(!this._isIntroFinished && isInvalid(INTRO_FLAG))
            {
                this.startIntroAnimation();
            }
        }

        public function as_hide3DSceneTooltip() : void
        {
            this.hideTooltip();
        }

        public function as_setBottomPanel(param1:String) : void
        {
            if(this.bottomPanel == null && StringUtils.isNotEmpty(param1))
            {
                this._bottomPanelLinkage = param1;
                this.bottomPanel = App.utils.classFactory.getComponent(param1,MovieClip);
                addChild(DisplayObject(this.bottomPanel));
            }
        }

        public function as_setBulletVisibility(param1:int, param2:Boolean) : void
        {
            if(this._infoPanel != null)
            {
                this._infoPanel.setBulletVisibility(param1,param2);
            }
        }

        public function as_setHeader(param1:String) : void
        {
            var _loc2_:DisplayObject = null;
            if(this.headerPanel == null)
            {
                this.headerPanel = App.utils.classFactory.getComponent(param1,MovieClip);
                _loc2_ = DisplayObject(this.headerPanel);
                _loc2_.alpha = 0;
                addChildAt(_loc2_,getChildIndex(this.fadingPanels));
            }
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            if(param2 == StageSizeBoundaries.HEIGHT_768)
            {
                this._offset = SMALL_OFFSET;
                this._panelVerticalOffset = SMALL_PANELS_VERTICAL_OFFSET;
            }
            else
            {
                this._offset = BIG_OFFSET;
                this._panelVerticalOffset = BIG_PANELS_VERTICAL_OFFSET;
            }
            invalidateSize();
        }

        private function adjustBottomShadow(param1:DisplayObject) : void
        {
            if(param1.visible)
            {
                param1.x = width - param1.width >> 1;
                param1.y = height - param1.height >> 0;
            }
        }

        private function hideTooltip() : void
        {
            this._toolTipMgr.hide();
        }

        private function startIntroAnimation() : void
        {
            this.disposeTweens();
            visible = true;
            this._tweens.push(new Tween(INTRO_ANIMATION_DURATION,this._vehParams,{"alpha":1},{
                "delay":INTRO_ANIMATION_DELAY,
                "fastTransform":false
            }),new Tween(INTRO_ANIMATION_DURATION,this.compareBlock,{"alpha":1},{
                "delay":INTRO_ANIMATION_DELAY,
                "fastTransform":false
            }),new Tween(INTRO_ANIMATION_DURATION,this._infoPanel,{"alpha":1},{
                "delay":INTRO_ANIMATION_DELAY,
                "fastTransform":false
            }));
            if(this.bottomPanel != null)
            {
                this._tweens.push(new Tween(INTRO_ANIMATION_DURATION,this.bottomPanel,{"alpha":1},{
                    "delay":INTRO_ANIMATION_DELAY,
                    "fastTransform":false,
                    "onComplete":this.onIntroCompleteCallback
                }));
            }
            if(this.headerPanel != null)
            {
                this._tweens.push(new Tween(INTRO_ANIMATION_DURATION,this.headerPanel,{"alpha":1},{
                    "delay":INTRO_ANIMATION_DELAY,
                    "fastTransform":false
                }));
            }
        }

        private function disposeTweens() : void
        {
            var _loc1_:Tween = null;
            for each(_loc1_ in this._tweens)
            {
                _loc1_.paused = true;
                _loc1_.dispose();
            }
            this._tweens.length = 0;
        }

        private function onIntroCompleteCallback(param1:Tween) : void
        {
            this._isIntroFinished = true;
            this._stage.addEventListener(LobbyEvent.DRAGGING_START,this.onDraggingStartHandler);
            this._stage.addEventListener(LobbyEvent.DRAGGING_END,this.onDraggingEndHandler);
        }

        override protected function get autoShowViewProperty() : int
        {
            return SHOW_VIEW_PROP_FORBIDDEN;
        }

        private function onDraggingEndHandler(param1:LobbyEvent) : void
        {
            if(this._isIntroFinished)
            {
                this.disposeTweens();
            }
            this.fadingPanels.mouseChildren = true;
            if(this.fadingPanels.alpha != SHOW_SLOTS_ALPHA)
            {
                this._tweens.push(new Tween(FADE_ANIMATION_DURATION,this.fadingPanels,{"alpha":SHOW_SLOTS_ALPHA},{"fastTransform":false}),new Tween(FADE_ANIMATION_DURATION,this.compareBlock,{
                    "alpha":SHOW_SLOTS_ALPHA,
                    "visible":true
                },{"fastTransform":false}),new Tween(FADE_ANIMATION_DURATION,this.leftBackground,{"alpha":SHOW_SLOTS_ALPHA},{"fastTransform":false}),new Tween(FADE_ANIMATION_DURATION,this.rightBackground,{"alpha":SHOW_SLOTS_ALPHA},{"fastTransform":false}));
                if(this.headerPanel != null)
                {
                    this._tweens.push(new Tween(FADE_ANIMATION_DURATION,this.headerPanel,{"alpha":SHOW_SLOTS_ALPHA},{"fastTransform":false}));
                }
            }
        }

        private function onDraggingStartHandler(param1:LobbyEvent) : void
        {
            if(this._isIntroFinished)
            {
                this.disposeTweens();
            }
            this.fadingPanels.mouseChildren = false;
            this._tweens.push(new Tween(FADE_ANIMATION_DURATION,this.fadingPanels,{"alpha":HIDE_SLOTS_ALPHA},{
                "delay":FADE_ANIMATION_DELAY,
                "fastTransform":false
            }),new Tween(FADE_ANIMATION_DURATION,this.compareBlock,{
                "alpha":HIDE_SLOTS_ALPHA,
                "visible":false
            },{
                "delay":FADE_ANIMATION_DELAY,
                "fastTransform":false
            }),new Tween(FADE_ANIMATION_DURATION,this.leftBackground,{"alpha":HIDE_SLOTS_ALPHA},{
                "delay":FADE_ANIMATION_DELAY,
                "fastTransform":false
            }),new Tween(FADE_ANIMATION_DURATION,this.rightBackground,{"alpha":HIDE_SLOTS_ALPHA},{
                "delay":FADE_ANIMATION_DELAY,
                "fastTransform":false
            }));
            if(this.headerPanel != null)
            {
                this._tweens.push(new Tween(FADE_ANIMATION_DURATION,this.headerPanel,{"alpha":HIDE_SLOTS_ALPHA},{
                    "delay":FADE_ANIMATION_DELAY,
                    "fastTransform":false
                }));
            }
        }

        private function onEscapeKeyUpHandler(param1:InputEvent) : void
        {
            onBackClickS();
        }

        private function onCloseBtnClickHandler(param1:ButtonEvent) : void
        {
            closeViewS();
        }

        private function onBackBtnClickHandler(param1:ButtonEvent) : void
        {
            onBackClickS();
        }

        private function onCompareBlockAddHandler(param1:VehCompareEvent) : void
        {
            onCompareClickS();
        }

        private function onStackViewChangedHandler(param1:ViewStackEvent) : void
        {
            onOpenInfoTabS(this._infoPanel.tabButtonBar.selectedIndex);
        }

        private function onStackViewNeedUpdateHandler(param1:ViewStackEvent) : void
        {
            registerFlashComponentS(IDAAPIModule(param1.view),param1.viewId);
        }

        private function onVehParamsResizeHandler(param1:Event) : void
        {
            invalidateSize();
        }

        private function onBottomPanelResizeHandler(param1:Event) : void
        {
            invalidateSize();
        }
    }
}
