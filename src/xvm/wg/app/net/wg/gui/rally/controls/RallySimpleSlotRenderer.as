package net.wg.gui.rally.controls
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.infrastructure.interfaces.IVehicleButton;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import net.wg.gui.rally.interfaces.IRallySlotVO;
    import net.wg.data.constants.Errors;
    import net.wg.gui.rally.events.RallyViewsEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.events.ButtonEvent;
    import flash.display.DisplayObject;
    import net.wg.data.VO.ExtendedUserVO;
    import net.wg.gui.rally.helpers.PlayerCIGenerator;
    import flash.display.InteractiveObject;
    import flash.events.Event;
    
    public class RallySimpleSlotRenderer extends UIComponent
    {
        
        public function RallySimpleSlotRenderer() {
            super();
        }
        
        private static var UPDATE_SLOT_DATA:String = "updateSlotData";
        
        public var orderNo:TextField;
        
        public var slotLabel:TextField;
        
        public var takePlaceBtn:IGrayTransparentButton;
        
        public var takePlaceFirstTimeBtn:SoundButtonEx;
        
        public var vehicleBtn:IVehicleButton;
        
        public var contextMenuArea:Sprite;
        
        public var statusIndicator:MovieClip;
        
        public var commander:MovieClip;
        
        private var _index:int = 0;
        
        private var _slotData:IRallySlotVO;
        
        private var _helper:ISlotRendererHelper;
        
        public function get index() : int {
            return this._index;
        }
        
        public function set index(param1:int) : void {
            this._index = param1;
        }
        
        public function get slotData() : IRallySlotVO {
            return this._slotData;
        }
        
        public function set slotData(param1:IRallySlotVO) : void {
            this._slotData = param1;
            this.updateComponents();
        }
        
        override protected function draw() : void {
            super.draw();
            if((isInvalid(UPDATE_SLOT_DATA)) && (this._slotData))
            {
                App.utils.asserter.assertNotNull(this.vehicleBtn,"\"vehicleBtn\" in " + name + Errors.CANT_NULL);
                this.updateComponents();
            }
        }
        
        public function cooldown(param1:Boolean) : void {
        }
        
        public function get helper() : ISlotRendererHelper {
            return this._helper;
        }
        
        public function set helper(param1:ISlotRendererHelper) : void {
            this._helper = param1;
        }
        
        override protected function configUI() : void {
            var _loc1_:Array = null;
            super.configUI();
            if(this.orderNo)
            {
                this.orderNo.text = (this._index + 1).toString() + ".";
            }
            if(this.vehicleBtn)
            {
                this.vehicleBtn.addEventListener(RallyViewsEvent.VEH_BTN_ROLL_OVER,this.onMedallionRollOver,false,int.MAX_VALUE);
                this.vehicleBtn.addEventListener(RallyViewsEvent.VEH_BTN_ROLL_OUT,this.onControlRollOut);
            }
            _loc1_ = [this.slotLabel,this.takePlaceBtn,this.takePlaceFirstTimeBtn];
            if(this.contextMenuArea)
            {
                this.contextMenuArea.buttonMode = this.contextMenuArea.useHandCursor = true;
                this.contextMenuArea.addEventListener(MouseEvent.CLICK,this.onContextMenuAreaClick);
                this.contextMenuArea.visible = false;
                _loc1_.push(this.contextMenuArea);
            }
            this.tooltipSubscribe(_loc1_,true);
            if(this.takePlaceBtn)
            {
                this.takePlaceBtn.addEventListener(ButtonEvent.CLICK,this.onTakePlaceClick);
            }
            if(this.takePlaceFirstTimeBtn)
            {
                this.takePlaceFirstTimeBtn.addEventListener(ButtonEvent.CLICK,this.onTakePlaceClick);
            }
            this.initControlsState();
        }
        
        override protected function onDispose() : void {
            if(this.vehicleBtn)
            {
                this.vehicleBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onMedallionRollOver);
                this.vehicleBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
                this.vehicleBtn.dispose();
                this.vehicleBtn = null;
            }
            var _loc1_:Array = [this.slotLabel,this.takePlaceBtn,this.takePlaceFirstTimeBtn];
            if(this.contextMenuArea)
            {
                _loc1_.push(this.contextMenuArea);
            }
            this.tooltipSubscribe(_loc1_,false);
            if(this.takePlaceBtn)
            {
                this.takePlaceBtn.removeEventListener(ButtonEvent.CLICK,this.onTakePlaceClick);
                this.takePlaceBtn.dispose();
                this.takePlaceBtn = null;
            }
            if(this.takePlaceFirstTimeBtn)
            {
                this.takePlaceFirstTimeBtn.addEventListener(ButtonEvent.CLICK,this.onTakePlaceClick);
                this.takePlaceFirstTimeBtn.dispose();
                this.takePlaceFirstTimeBtn = null;
            }
            if(this.contextMenuArea)
            {
                this.contextMenuArea.removeEventListener(MouseEvent.CLICK,this.onContextMenuAreaClick);
            }
            super.onDispose();
        }
        
        protected function initControlsState() : void {
            this._helper.initControlsState(this);
        }
        
        protected function updateComponents() : void {
            this.initControlsState();
            this._helper.updateComponents(this,this._slotData);
        }
        
        protected function tooltipSubscribe(param1:Array, param2:Boolean = true) : void {
            var _loc3_:DisplayObject = null;
            for each(_loc3_ in param1)
            {
                if(_loc3_)
                {
                    if(param2)
                    {
                        _loc3_.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
                        _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
                    }
                    else
                    {
                        _loc3_.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
                        _loc3_.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
                    }
                }
            }
        }
        
        protected function onContextMenuAreaClick(param1:MouseEvent) : void {
            var _loc2_:ExtendedUserVO = null;
            var _loc3_:PlayerCIGenerator = null;
            if(App.utils.commons.isRightButton(param1))
            {
                _loc2_ = this._slotData?this._slotData.playerObj as ExtendedUserVO:null;
                if((_loc2_) && !_loc2_.himself)
                {
                    _loc3_ = new PlayerCIGenerator(false);
                    App.contextMenuMgr.showUserContextMenu(this,_loc2_,_loc3_);
                }
            }
        }
        
        protected function onControlRollOver(param1:MouseEvent) : void {
            this._helper.onControlRollOver(param1.currentTarget as InteractiveObject,this,this._slotData);
        }
        
        protected function onMedallionRollOver(param1:RallyViewsEvent) : void {
            this._helper.onControlRollOver(InteractiveObject(this.vehicleBtn),this,this._slotData,param1.data);
        }
        
        protected function onTakePlaceClick(param1:ButtonEvent) : void {
            dispatchEvent(new RallyViewsEvent(RallyViewsEvent.ASSIGN_SLOT_REQUEST,this.index));
        }
        
        protected function onControlRollOut(param1:Event) : void {
            App.toolTipMgr.hide();
        }
    }
}
