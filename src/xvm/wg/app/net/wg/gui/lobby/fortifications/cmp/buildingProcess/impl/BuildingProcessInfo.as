package net.wg.gui.lobby.fortifications.cmp.buildingProcess.impl
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.entity.IFocusContainer;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import net.wg.gui.lobby.fortifications.cmp.build.impl.OrderInfoCmp;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.advanced.DashLine;
    import net.wg.gui.lobby.fortifications.data.buildingProcess.BuildingProcessInfoVO;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import net.wg.gui.utils.ComplexTooltipHelper;
    import flash.events.Event;
    import scaleform.gfx.TextFieldEx;
    
    public class BuildingProcessInfo extends MovieClip implements IDisposable, IFocusContainer
    {
        
        public function BuildingProcessInfo()
        {
            super();
            TextFieldEx.setVerticalAlign(this.builtMessage,TextFieldEx.VALIGN_CENTER);
            this.builtMessage.mouseEnabled = false;
            this.dashLine.x = DASH_LINE_PADDING;
            this.dashLine.width = this.width - DASH_LINE_PADDING * 2;
        }
        
        public static var BUY_BUILDING:String = "buyBuilding";
        
        private static var DASH_LINE_PADDING:uint = 18;
        
        private static function onRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var buildingName:TextField = null;
        
        public var statusMsg:TextField = null;
        
        public var builtMessage:TextField = null;
        
        public var buildingImg:MovieClip = null;
        
        public var longDescription:TextField = null;
        
        public var orderInfo:OrderInfoCmp = null;
        
        public var applyButton:SoundButtonEx = null;
        
        public var dashLine:DashLine = null;
        
        private var model:BuildingProcessInfoVO = null;
        
        public function getComponentForFocus() : InteractiveObject
        {
            return this.applyButton;
        }
        
        public function dispose() : void
        {
            this.buildingName = null;
            this.statusMsg.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.statusMsg.removeEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
            this.statusMsg = null;
            this.buildingImg = null;
            this.longDescription = null;
            this.orderInfo.dispose();
            this.orderInfo = null;
            this.applyButton.removeEventListener(ButtonEvent.CLICK,this.onClickHandler);
            this.applyButton.dispose();
            this.applyButton = null;
            this.dashLine.dispose();
            this.dashLine = null;
            if(this.model)
            {
                this.model.dispose();
                this.model = null;
            }
        }
        
        public function getBuildingId() : String
        {
            if(!this.model)
            {
                return null;
            }
            return this.model.buildingID;
        }
        
        public function setData(param1:BuildingProcessInfoVO) : void
        {
            var _loc2_:* = false;
            this.model = param1;
            this.buildingName.htmlText = this.model.buildingName;
            this.statusMsg.htmlText = this.model.statusMsg;
            this.statusMsg.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this.statusMsg.addEventListener(MouseEvent.ROLL_OUT,onRollOutHandler);
            this.buildingImg.gotoAndStop(this.model.buildingID);
            this.longDescription.htmlText = this.model.longDescr;
            this.applyButton.label = this.model.buttonLabel;
            _loc2_ = this.model.isVisibleBtn;
            this.applyButton.visible = _loc2_;
            this.applyButton.enabled = this.model.isEnableBtn;
            this.builtMessage.visible = !_loc2_;
            if(this.builtMessage.visible)
            {
                this.builtMessage.htmlText = this.model.buttonLabel;
                this.builtMessage.x = Math.round((this.width - this.builtMessage.width) / 2);
            }
            if((this.model.isVisibleBtn) && (this.model.buttonTooltip))
            {
                this.applyButton.tooltip = this.makeTooltipData();
                if(this.applyButton.enabled)
                {
                    this.applyButton.addEventListener(ButtonEvent.CLICK,this.onClickHandler);
                    dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
                }
            }
            this.orderInfo.setData(this.model.orderInfo);
        }
        
        private function makeTooltipData() : String
        {
            var _loc1_:String = new ComplexTooltipHelper().addHeader(this.model.buttonTooltip["header"]).addBody(this.model.buttonTooltip["body"]).make();
            return _loc1_;
        }
        
        private function onRollOverHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(this.model.statusIconTooltip);
        }
        
        private function onClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new Event(BUY_BUILDING));
        }
    }
}
