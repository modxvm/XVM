package net.wg.gui.lobby.fortifications.battleRoom
{
    import net.wg.gui.components.controls.TableRenderer;
    import net.wg.gui.rally.interfaces.IManualSearchRenderer;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.IndicationOfStatus;
    import net.wg.gui.lobby.fortifications.data.sortie.SortieRenderVO;
    import net.wg.data.constants.Values;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.infrastructure.interfaces.IUserProps;
    import org.idmedia.as3commons.util.StringUtils;
    import flash.geom.Point;
    import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
    
    public class SortieListRenderer extends TableRenderer implements IManualSearchRenderer
    {
        
        public function SortieListRenderer()
        {
            super();
            UIID = 33;
            preventAutosizing = true;
        }
        
        private static var IN_BATTLE_LABLE:String = "inBattle";
        
        public var commander:TextField = null;
        
        public var divisionName:TextField = null;
        
        public var description:TextField = null;
        
        public var commandSize:TextField = null;
        
        public var commandMaxSize:TextField = null;
        
        public var battleIndicator:IndicationOfStatus = null;
        
        private var _creatorName:String = null;
        
        private var _description:String = null;
        
        override public function setData(param1:Object) : void
        {
            var _loc2_:Array = null;
            this.data = param1;
            if(this.data)
            {
                _loc2_ = SortieRenderVO(param1).sortieID;
                if(!(_loc2_[0] == Values.DEFAULT_INT) && !(_loc2_[1] == Values.DEFAULT_INT))
                {
                    startSimulationDoubleClick();
                }
                else
                {
                    stopSimulationDoubleClick();
                }
            }
            else
            {
                stopSimulationDoubleClick();
            }
            invalidateData();
        }
        
        public function update(param1:Object) : void
        {
            this.data = param1;
            if(this.data)
            {
                this.populateUI(SortieRenderVO(param1));
            }
        }
        
        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            mouseEnabled = true;
            mouseChildren = true;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.commander.mouseEnabled = false;
            this.divisionName.mouseEnabled = false;
            this.commandSize.mouseEnabled = false;
            this.commandMaxSize.mouseEnabled = false;
            this.description.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverDesrcHandler);
            this.battleIndicator.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverIconHandler);
            this.battleIndicator.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            this.description.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
        }
        
        override protected function onDispose() : void
        {
            this.description.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverDesrcHandler);
            this.battleIndicator.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverIconHandler);
            this.battleIndicator.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            this.description.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            this.battleIndicator.dispose();
            this.battleIndicator = null;
            this.commander = null;
            this.divisionName = null;
            this.commandSize = null;
            this.commandMaxSize = null;
            this.description = null;
            this._description = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            var _loc1_:SortieRenderVO = null;
            mouseEnabled = true;
            mouseChildren = true;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(data)
                {
                    _loc1_ = SortieRenderVO(data);
                    this.visible = true;
                    this.populateUI(_loc1_);
                }
                else
                {
                    this.visible = false;
                }
            }
        }
        
        protected function populateUI(param1:SortieRenderVO) : void
        {
            var _loc2_:String = null;
            var _loc4_:IUserProps = null;
            var _loc5_:IUserProps = null;
            if(param1.creatorName)
            {
                _loc4_ = App.utils.commons.getUserProps(param1.creatorName,"","",param1.igrType);
                _loc4_.rgb = param1.color;
                App.utils.commons.formatPlayerName(this.commander,_loc4_);
                _loc2_ = this.commander.htmlText;
            }
            else
            {
                _loc2_ = "";
            }
            this._description = param1.description;
            this.description.htmlText = this._description;
            if(StringUtils.isNotEmpty(this.description.text))
            {
                this.description.visible = true;
                _loc5_ = App.utils.commons.getUserProps(param1.description,"","");
                App.utils.commons.formatPlayerName(this.description,_loc5_);
            }
            else
            {
                this.description.visible = false;
            }
            if(param1.isInBattle)
            {
                this.battleIndicator.visible = true;
                this.battleIndicator.gotoAndStop(IN_BATTLE_LABLE);
            }
            else
            {
                this.battleIndicator.visible = false;
            }
            var _loc3_:Point = new Point(mouseX,mouseY);
            _loc3_ = this.localToGlobal(_loc3_);
            if((this.description.visible) && (this.description.hitTestPoint(_loc3_.x,_loc3_.y,true)))
            {
                App.toolTipMgr.show(this._description);
            }
            if((this.battleIndicator.visible) && (this.battleIndicator.hitTestPoint(_loc3_.x,_loc3_.y,true)))
            {
                App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_BATTLESTATUS);
            }
            if(this._creatorName != _loc2_)
            {
                this._creatorName = _loc2_;
                this.commander.htmlText = _loc2_;
            }
            _loc2_ = String(param1.playersCount);
            if(_loc2_ != this.commandSize.text)
            {
                this.commandSize.text = _loc2_;
            }
            _loc2_ = "/" + String(param1.commandSize);
            if(_loc2_ != this.commandMaxSize.text)
            {
                this.commandMaxSize.text = _loc2_;
            }
            this.divisionName.text = param1.divisionName;
        }
        
        override protected function handleMouseRelease(param1:MouseEvent) : void
        {
            var _loc2_:uint = 0;
            super.handleMouseRelease(param1);
            if(param1.type == MouseEvent.CLICK)
            {
                _loc2_ = 0;
                if(_loc2_ != 0)
                {
                    _loc2_ = data.rallyIndex;
                }
                App.eventLogManager.logUIElement(this,EVENT_LOG_CONSTANTS.EVENT_TYPE_CLICK,_loc2_);
            }
        }
        
        private function onMouseOverIconHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_BATTLESTATUS);
        }
        
        private function onMouseOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
            var _loc2_:MouseEvent = new MouseEvent(MouseEvent.ROLL_OVER,true);
            dispatchEvent(_loc2_);
        }
        
        private function onMouseOverDesrcHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.show(this._description);
        }
    }
}
