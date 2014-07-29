package net.wg.gui.cyberSport.controls
{
    import net.wg.gui.components.controls.TableRenderer;
    import net.wg.gui.rally.interfaces.IManualSearchRenderer;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import net.wg.gui.cyberSport.vo.CSCommandVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.infrastructure.interfaces.IUserProps;
    
    public class ManualSearchRenderer extends TableRenderer implements IManualSearchRenderer
    {
        
        public function ManualSearchRenderer()
        {
            super();
            preventAutosizing = true;
        }
        
        public var commander:TextField = null;
        
        public var commandDescr:TextField = null;
        
        public var commandSize:TextField = null;
        
        public var commandMaxSize:TextField = null;
        
        public var effency:TextField = null;
        
        public var freezeIcon:MovieClip;
        
        public var restrictionIcon:MovieClip;
        
        public var inBattleMC:MovieClip;
        
        private var _creatorName:String = null;
        
        protected function checkTooltip() : void
        {
            var _loc1_:Point = new Point(mouseX,mouseY);
            _loc1_ = localToGlobal(_loc1_);
            if(hitTestPoint(_loc1_.x,_loc1_.y))
            {
                if(data)
                {
                    dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
                }
                else
                {
                    App.toolTipMgr.hide();
                }
            }
        }
        
        override public function setData(param1:Object) : void
        {
            this.data = param1;
            invalidateData();
        }
        
        public function update(param1:Object) : void
        {
            this.data = param1;
            if(this.data)
            {
                this.populateUI(CSCommandVO(param1));
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.commander.mouseEnabled = false;
            this.commandSize.mouseEnabled = false;
            this.commandMaxSize.mouseEnabled = false;
            this.effency.mouseEnabled = false;
            this.inBattleMC.mouseEnabled = false;
            this.freezeIcon.useHandCursor = this.freezeIcon.buttonMode = true;
            this.restrictionIcon.useHandCursor = this.restrictionIcon.buttonMode = true;
            this.freezeIcon.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.freezeIcon.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.restrictionIcon.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.restrictionIcon.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
        }
        
        override protected function onDispose() : void
        {
            this.freezeIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.freezeIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.restrictionIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.restrictionIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOut);
            this.commander = null;
            this.commandDescr = null;
            this.commandSize = null;
            this.commandMaxSize = null;
            this.effency = null;
            super.onDispose();
        }
        
        private function onControlRollOver(param1:MouseEvent) : void
        {
            App.toolTipMgr.showComplex(param1.currentTarget == this.freezeIcon?TOOLTIPS.SETTINGSICON_FREEZED:TOOLTIPS.SETTINGSICON_CONDITIONS);
        }
        
        private function onControlRollOut(param1:MouseEvent = null) : void
        {
            App.toolTipMgr.hide();
            dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
        }
        
        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            mouseEnabled = true;
            mouseChildren = true;
        }
        
        override protected function draw() : void
        {
            var _loc1_:CSCommandVO = null;
            mouseEnabled = true;
            mouseChildren = true;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                if(data)
                {
                    _loc1_ = CSCommandVO(data);
                    this.visible = true;
                    this.populateUI(_loc1_);
                    startSimulationDoubleClick();
                }
                else
                {
                    this.visible = false;
                    stopSimulationDoubleClick();
                }
                this.checkTooltip();
            }
        }
        
        protected function populateUI(param1:CSCommandVO) : void
        {
            var _loc2_:String = null;
            var _loc4_:IUserProps = null;
            if(param1.creator)
            {
                _loc4_ = App.utils.commons.getUserProps(param1.creator.userName,param1.creator.clanAbbrev,param1.creator.region,param1.creator.igrType);
                _loc4_.rgb = param1.creator.color;
                App.utils.commons.formatPlayerName(this.commander,_loc4_);
                _loc2_ = this.commander.htmlText;
            }
            else
            {
                _loc2_ = "";
            }
            if(this._creatorName != _loc2_)
            {
                this._creatorName = _loc2_;
                this.commander.htmlText = _loc2_;
            }
            _loc2_ = param1.rating;
            if(_loc2_ != this.effency.text)
            {
                this.effency.text = _loc2_;
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
            var _loc3_:int = this.freezeIcon.x;
            this.freezeIcon.visible = param1.isFreezed;
            _loc3_ = _loc3_ + (this.freezeIcon.visible?this.freezeIcon.width + 6:0);
            this.restrictionIcon.visible = param1.isRestricted;
            this.restrictionIcon.x = _loc3_;
            _loc3_ = _loc3_ + (this.restrictionIcon.visible?this.restrictionIcon.width + 6:0);
            this.inBattleMC.visible = param1.inBattle;
            this.inBattleMC.x = _loc3_;
            _loc3_ = _loc3_ + (this.inBattleMC.visible?this.inBattleMC.width + 6:0);
            this.commandDescr.x = _loc3_;
            this.commandDescr.width = 473 - _loc3_;
            _loc4_ = App.utils.commons.getUserProps(param1.description,null,null,0);
            App.utils.commons.formatPlayerName(this.commandDescr,_loc4_);
        }
    }
}
