package net.wg.gui.lobby.vehiclePreview
{
    import net.wg.infrastructure.base.meta.impl.VehiclePreviewMeta;
    import net.wg.infrastructure.base.meta.IVehiclePreviewMeta;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewHeader;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewBottomPanel;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewInfoPanel;
    import net.wg.gui.lobby.hangar.interfaces.IVehicleParameters;
    import scaleform.clik.motion.Tween;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.vehiclePreview.interfaces.IVehPreviewBuyingPanel;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewInfoPanelVO;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewStaticDataVO;
    import net.wg.data.constants.generated.VEHPREVIEW_CONSTANTS;
    import net.wg.gui.events.LobbyEvent;
    import net.wg.gui.lobby.vehiclePreview.events.VehPreviewEvent;
    import net.wg.gui.lobby.vehiclePreview.events.VehPreviewInfoPanelEvent;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.vehiclePreview.data.VehPreviewBuyingPanelDataVO;
    import scaleform.clik.events.InputEvent;

    public class VehiclePreview extends VehiclePreviewMeta implements IVehiclePreviewMeta
    {

        private static const BOTTOM_OFFSET:int = 104;

        private static const GAP:int = 2;

        private static const PARAMS_TOP_MARGIN:int = 100 + GAP;

        private static const INFO_TOP_MARGIN:int = 80 + GAP;

        private static const ANIMATION_DURATION:int = 200;

        private static const ANIMATION_DELAY:int = 150;

        private static const SHOW_SLOTS_ALPHA:Number = 1;

        private static const HIDE_SLOTS_ALPHA:Number = 0.0;

        public var header:IVehPreviewHeader = null;

        public var bottomPanel:IVehPreviewBottomPanel = null;

        public var fadingPanels:MovieClip = null;

        public var background:Sprite;

        private var _infoPanel:IVehPreviewInfoPanel = null;

        private var _vehParams:IVehicleParameters = null;

        private var _tweenInfoHide:Tween = null;

        private var _tweenInfoShow:Tween = null;

        public function VehiclePreview()
        {
            super();
            this._vehParams = this.fadingPanels.vehParams;
            this._infoPanel = this.fadingPanels.infoPanel;
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            this.background.width = param1;
            this.background.height = param2;
            setSize(param1,param2);
        }

        override protected function onInitModalFocus(param1:InteractiveObject) : void
        {
            super.onInitModalFocus(param1);
            var _loc2_:IVehPreviewBuyingPanel = this.bottomPanel.buyingPanel;
            var _loc3_:Vector.<InteractiveObject> = new <InteractiveObject>[InteractiveObject(this.header.backBtn),InteractiveObject(_loc2_.buyBtn),InteractiveObject(_loc2_.addToCompareBtn),InteractiveObject(this.header.closeBtn)];
            App.utils.commons.initTabIndex(_loc3_);
            setFocus(_loc3_[0]);
            _loc3_.splice(0,_loc3_.length);
        }

        override protected function updateInfoData(param1:VehPreviewInfoPanelVO) : void
        {
            this._infoPanel.update(param1);
        }

        override protected function setStaticData(param1:VehPreviewStaticDataVO) : void
        {
            this.header.update(param1.header);
            this.bottomPanel.update(param1.bottomPanel);
            this._infoPanel.updateTabButtonsData(param1.crewPanel);
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabled = false;
            this.fadingPanels.mouseEnabled = false;
            this.background.mouseEnabled = this.background.mouseChildren = false;
            registerFlashComponentS(this.bottomPanel.modules,VEHPREVIEW_CONSTANTS.MODULES_PY_ALIAS);
            registerFlashComponentS(this._vehParams,VEHPREVIEW_CONSTANTS.PARAMETERS_PY_ALIAS);
        }

        override protected function onPopulate() : void
        {
            App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
            addEventListener(VehPreviewEvent.BUY_CLICK,this.onBuyClickHandler);
            addEventListener(VehPreviewEvent.CLOSE_CLICK,this.onCloseClickHandler);
            addEventListener(VehPreviewEvent.BACK_CLICK,this.onBackClickHandler);
            addEventListener(VehPreviewInfoPanelEvent.INFO_TAB_CHANGED,this.onInfoTabChangedHandler);
            addEventListener(VehPreviewEvent.COMPARE_CLICK,this.onCompareClickHandler);
            App.stage.addEventListener(LobbyEvent.DRAGGING_START,this.onDraggingStartHandler);
            App.stage.addEventListener(LobbyEvent.DRAGGING_END,this.onDraggingEndHandler);
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyUpHandler,true);
        }

        override protected function onBeforeDispose() : void
        {
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyUpHandler);
            App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
            removeEventListener(VehPreviewEvent.BUY_CLICK,this.onBuyClickHandler);
            removeEventListener(VehPreviewEvent.CLOSE_CLICK,this.onCloseClickHandler);
            removeEventListener(VehPreviewEvent.BACK_CLICK,this.onBackClickHandler);
            removeEventListener(VehPreviewInfoPanelEvent.INFO_TAB_CHANGED,this.onInfoTabChangedHandler);
            removeEventListener(VehPreviewEvent.COMPARE_CLICK,this.onCompareClickHandler);
            App.stage.removeEventListener(LobbyEvent.DRAGGING_START,this.onDraggingStartHandler);
            App.stage.removeEventListener(LobbyEvent.DRAGGING_END,this.onDraggingEndHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            if(this._tweenInfoHide)
            {
                this._tweenInfoHide.paused = true;
                this._tweenInfoHide.dispose();
                this._tweenInfoHide = null;
            }
            if(this._tweenInfoShow)
            {
                this._tweenInfoShow.paused = true;
                this._tweenInfoShow.dispose();
                this._tweenInfoShow = null;
            }
            this._vehParams = null;
            this.header.dispose();
            this.header = null;
            this._infoPanel = null;
            this.bottomPanel.dispose();
            this.bottomPanel = null;
            this.background = null;
            this.fadingPanels = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                _loc1_ = width;
                _loc2_ = height;
                this.header.width = _loc1_;
                this.bottomPanel.width = _loc1_;
                this.bottomPanel.y = _loc2_ - this.bottomPanel.height + BOTTOM_OFFSET | 0;
                this.updatePosition();
            }
        }

        override protected function updateBuyingPanel(param1:VehPreviewBuyingPanelDataVO) : void
        {
            this.bottomPanel.updateBuyingPanel(param1);
        }

        public function as_updateVehicleStatus(param1:String) : void
        {
            this.bottomPanel.updateVehicleStatus(param1);
        }

        private function updatePosition() : void
        {
            this._vehParams.x = width - this._vehParams.width ^ 0;
            this._vehParams.y = PARAMS_TOP_MARGIN;
            this._infoPanel.y = INFO_TOP_MARGIN;
            var _loc1_:int = this.bottomPanel.y - GAP;
            this._vehParams.height = _loc1_ - this._vehParams.y;
            this._infoPanel.height = _loc1_ - this._infoPanel.y;
        }

        private function onDraggingEndHandler(param1:LobbyEvent) : void
        {
            this.fadingPanels.mouseEnabled = this.fadingPanels.mouseChildren = this.fadingPanels.visible = true;
            if(this._tweenInfoHide)
            {
                this._tweenInfoHide.paused = true;
            }
            if(this._tweenInfoShow)
            {
                this._tweenInfoShow.paused = true;
                this._tweenInfoShow.dispose();
            }
            if(this.fadingPanels.alpha != SHOW_SLOTS_ALPHA)
            {
                this._tweenInfoShow = new Tween(ANIMATION_DURATION,this.fadingPanels,{"alpha":SHOW_SLOTS_ALPHA},{});
            }
        }

        private function onHideContainerEnd() : void
        {
            this.fadingPanels.mouseEnabled = this.fadingPanels.mouseChildren = this.fadingPanels.visible = false;
        }

        private function onDraggingStartHandler(param1:LobbyEvent) : void
        {
            if(this._tweenInfoShow)
            {
                this._tweenInfoShow.paused = true;
            }
            if(this._tweenInfoHide)
            {
                this._tweenInfoHide.paused = true;
                this._tweenInfoHide.dispose();
            }
            this._tweenInfoHide = new Tween(ANIMATION_DURATION,this.fadingPanels,{"alpha":HIDE_SLOTS_ALPHA},{
                "delay":ANIMATION_DELAY,
                "onComplete":this.onHideContainerEnd
            });
        }

        private function onEscapeKeyUpHandler(param1:InputEvent) : void
        {
            onBackClickS();
        }

        private function onInfoTabChangedHandler(param1:VehPreviewInfoPanelEvent) : void
        {
            onOpenInfoTabS(param1.selectedTabIndex);
        }

        private function onBuyClickHandler(param1:VehPreviewEvent) : void
        {
            onBuyOrResearchClickS();
        }

        private function onCloseClickHandler(param1:VehPreviewEvent) : void
        {
            closeViewS();
        }

        private function onBackClickHandler(param1:VehPreviewEvent) : void
        {
            onBackClickS();
        }

        private function onCompareClickHandler(param1:VehPreviewEvent) : void
        {
            onCompareClickS();
        }
    }
}
