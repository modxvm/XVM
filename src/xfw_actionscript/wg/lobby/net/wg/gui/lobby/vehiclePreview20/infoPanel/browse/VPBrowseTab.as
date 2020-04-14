package net.wg.gui.lobby.vehiclePreview20.infoPanel.browse
{
    import net.wg.infrastructure.base.meta.impl.VehiclePreviewBrowseTabMeta;
    import net.wg.infrastructure.interfaces.IViewStackExContent;
    import net.wg.infrastructure.base.meta.IVehiclePreviewBrowseTabMeta;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import flash.text.TextFieldAutoSize;
    import net.wg.data.constants.generated.VEHPREVIEW_CONSTANTS;
    import flash.events.Event;
    import flash.display.InteractiveObject;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class VPBrowseTab extends VehiclePreviewBrowseTabMeta implements IViewStackExContent, IVehiclePreviewBrowseTabMeta
    {

        private static const TITLE_OFFSET:int = 30;

        private static const COLLECTIBLE_OFFSET:int = 30;

        private static const HISTORIC_REFERENCE_OFFSET:int = 4;

        public var title:TextField;

        public var historicReference:TextField;

        public var renderer0:VPKPIItemRenderer;

        public var renderer1:VPKPIItemRenderer;

        public var renderer2:VPKPIItemRenderer;

        public var collectibleInfo:VPCollectibleInfo;

        private var _renderers:Vector.<VPKPIItemRenderer>;

        private var _isCollectible:Boolean = false;

        public function VPBrowseTab()
        {
            super();
        }

        override public function setSize(param1:Number, param2:Number) : void
        {
            var _loc5_:VPKPIItemRenderer = null;
            var _loc3_:uint = this._renderers.length;
            var _loc4_:int = param1 / _loc3_;
            for each(_loc5_ in this._renderers)
            {
                _loc5_.width = _loc4_;
                _loc5_.validateNow();
            }
            super.setSize(param1,param2);
            validateNow();
        }

        override protected function initialize() : void
        {
            super.initialize();
            this._renderers = new <VPKPIItemRenderer>[this.renderer0,this.renderer1,this.renderer2];
        }

        override protected function onDispose() : void
        {
            var _loc1_:VPKPIItemRenderer = null;
            this.historicReference.removeEventListener(MouseEvent.ROLL_OVER,this.onHistoricReferenceRollOverHandler);
            this.historicReference.removeEventListener(MouseEvent.ROLL_OUT,this.onHistoricReferenceRollOutHandler);
            this.collectibleInfo.removeEventListener(InvalidationType.LAYOUT,this.updateLayout);
            for each(_loc1_ in this._renderers)
            {
                _loc1_.dispose();
            }
            this._renderers.length = 0;
            this._renderers = null;
            this.renderer0 = null;
            this.renderer1 = null;
            this.renderer2 = null;
            this.historicReference = null;
            this.title = null;
            this.collectibleInfo.dispose();
            this.collectibleInfo = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabled = false;
            this.title.text = VEHICLE_PREVIEW.INFOPANEL_TAB_ELITEFACTSHEET_INFO;
            this.historicReference.autoSize = TextFieldAutoSize.LEFT;
            this.historicReference.wordWrap = true;
            this.historicReference.multiline = true;
            this.historicReference.addEventListener(MouseEvent.ROLL_OVER,this.onHistoricReferenceRollOverHandler);
            this.historicReference.addEventListener(MouseEvent.ROLL_OUT,this.onHistoricReferenceRollOutHandler);
            this.collectibleInfo.addEventListener(InvalidationType.LAYOUT,this.updateLayout);
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.collectibleInfo.visible = this._isCollectible;
                this.collectibleInfo.width = width;
                this.title.width = width;
                this.historicReference.width = width;
                invalidateLayout();
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
                _loc1_ = 0;
                if(this._isCollectible)
                {
                    _loc1_ = this.collectibleInfo.y + this.collectibleInfo.height + COLLECTIBLE_OFFSET >> 0;
                }
                if(this.renderer0.visible)
                {
                    this.title.y = this.renderer0.y + this.renderer0.height + TITLE_OFFSET >> 0;
                }
                else
                {
                    this.title.y = this.renderer0.y + _loc1_;
                }
                this.historicReference.y = this.title.y + this.title.height + HISTORIC_REFERENCE_OFFSET >> 0;
            }
        }

        override protected function setData(param1:String, param2:Boolean, param3:int, param4:Array) : void
        {
            this.historicReference.htmlText = param1;
            this._isCollectible = param3 == VEHPREVIEW_CONSTANTS.COLLECTIBLE || param3 == VEHPREVIEW_CONSTANTS.COLLECTIBLE_WITHOUT_MODULES;
            mouseChildren = param2;
            this.setRenderersData(param4);
            invalidateSize();
        }

        private function updateLayout(param1:Event) : void
        {
            invalidateLayout();
        }

        public function canShowAutomatically() : Boolean
        {
            return true;
        }

        public function getComponentForFocus() : InteractiveObject
        {
            return null;
        }

        public function setActive(param1:Boolean) : void
        {
            setActiveStateS(param1);
        }

        public function update(param1:Object) : void
        {
        }

        private function setRenderersData(param1:Array) : void
        {
            var _loc2_:int = this._renderers.length;
            var _loc3_:* = 0;
            if(param1)
            {
                while(_loc3_ < _loc2_)
                {
                    this._renderers[_loc3_].setData(param1[_loc3_]);
                    this._renderers[_loc3_].visible = _loc3_ < param1.length;
                    _loc3_++;
                }
            }
            else
            {
                while(_loc3_ < _loc2_)
                {
                    this._renderers[_loc3_].visible = false;
                    _loc3_++;
                }
            }
        }

        private function onHistoricReferenceRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        private function onHistoricReferenceRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.VEHICLE_HISTORICAL_REFERENCE,null);
        }
    }
}
