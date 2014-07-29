package net.wg.gui.prebattle.company
{
    import net.wg.gui.components.controls.SoundListItemRenderer;
    import net.wg.infrastructure.interfaces.entity.IFocusContainer;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.utils.Constraints;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.data.DataProvider;
    import net.wg.infrastructure.events.FocusRequestEvent;
    
    public class CompanyListItemRenderer extends SoundListItemRenderer implements IFocusContainer
    {
        
        public function CompanyListItemRenderer()
        {
            super();
            tabEnabled = true;
            focusable = true;
        }
        
        public var descriptionField:TextField;
        
        public var pCountField:TextField;
        
        public var divisionField:TextField;
        
        public var dd:GroupPlayersDropDownMenu;
        
        public var bg:MovieClip;
        
        public var mainTextField:TextField;
        
        public var emtyFocusIndicator:MovieClip;
        
        private var dropDownState:int = 1;
        
        private var _showPlayers:Boolean = false;
        
        private var listRefreshData:Function;
        
        private var pressEvent:MouseEvent;
        
        public function showPlayersList(param1:Boolean) : void
        {
            this._showPlayers = param1;
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return this;
        }
        
        override protected function onDispose() : void
        {
            super.onDispose();
            this.removeEventListener(ButtonEvent.CLICK,this.clickHandler);
            if(this.dd)
            {
                this.dd.dispose();
            }
            if(this.listRefreshData != null)
            {
                this.listRefreshData = null;
            }
        }
        
        override protected function configUI() : void
        {
            focusIndicator = this.emtyFocusIndicator;
            toggle = true;
            allowDeselect = true;
            super.configUI();
            constraints.addElement(this.descriptionField.name,this.descriptionField,Constraints.ALL);
            constraints.addElement(this.pCountField.name,this.pCountField,Constraints.ALL);
            constraints.addElement(this.mainTextField.name,this.mainTextField,Constraints.ALL);
            this.addEventListener(ButtonEvent.CLICK,this.clickHandler);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (data))
            {
                this.afterSetData();
            }
        }
        
        private function afterSetData() : void
        {
            this.pCountField.text = data.playersCount;
            this.divisionField.text = data.division;
            this.cutText(this.descriptionField,data.comment);
            App.utils.commons.formatPlayerName(this.mainTextField,App.utils.commons.getUserProps(data.creatorName,data.creatorClan,data.creatorRegion,data.creatorIgrType));
            this.updateTextFieldWidth();
        }
        
        private function cutText(param1:TextField, param2:String) : void
        {
            var _loc3_:String = null;
            var _loc4_:* = 0;
            param1.text = param2;
            if(param1.getLineLength(1) != -1)
            {
                _loc3_ = param2;
                _loc4_ = param1.getLineLength(0);
                _loc3_ = _loc3_.substr(0,_loc4_ - 2);
                _loc3_ = _loc3_ + "..";
                param1.text = _loc3_;
            }
        }
        
        override public function setData(param1:Object) : void
        {
            if(param1 == null)
            {
                visible = false;
                return;
            }
            if(!visible)
            {
                visible = true;
            }
            super.setData(param1);
            this.dd.prbID = param1.prbID;
            if(this.isPlayersData())
            {
                while(param1.players.length < 15)
                {
                    param1.players.push({"label":"",
                    "color":null
                });
            }
            this.dd.dataProvider = new DataProvider(param1.players);
        }
        if((this._showPlayers) && (this.isPlayersData()) && (selected))
        {
            if(!this.dd.isOpen())
            {
                this.dd.open();
            }
        }
        else if(this.dd.isOpen())
        {
            this.dd.close();
        }
        
        this.afterSetData();
        invalidate(InvalidationType.DATA);
    }
    
    private function clickHandler(param1:ButtonEvent) : void
    {
        if(param1.isKeyboard)
        {
            return;
        }
        dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
        this.dispatchIsSelectedItem(selected);
        if(this._showPlayers)
        {
            if(this.dd.isOpen())
            {
                this.dd.close();
            }
            else if(selected)
            {
                this.dd.open();
            }
            
        }
        else if(this.dd.isOpen())
        {
            this.dropDownState = -1;
        }
        else
        {
            this.dropDownState = 1;
        }
        
    }
    
    private function dispatchIsSelectedItem(param1:Boolean) : void
    {
        var _loc2_:CompanyEvent = new CompanyEvent(CompanyEvent.SELECTED_ITEM,true);
        _loc2_.isSelected = param1;
        _loc2_.prbID = data.prbID;
        dispatchEvent(_loc2_);
    }
    
    private function isPlayersData() : Boolean
    {
        return (data.hasOwnProperty("players")) && !(data.players == null);
    }
    
    private function updateTextFieldWidth() : void
    {
        this.divisionField.x = Math.round(this.mainTextField.x + this.mainTextField.textWidth + 12);
        this.divisionField.width = Math.round(this.pCountField.x - this.divisionField.x - 8);
    }
    
    override public function set selected(param1:Boolean) : void
    {
        if(!param1 && (this.dd.isOpen()))
        {
            this.dd.close();
        }
        super.selected = param1;
    }
    
    public function refreshPopulateData(param1:Function) : void
    {
        this.listRefreshData = param1;
    }
    
    override protected function handleMouseRollOver(param1:MouseEvent) : void
    {
        super.handleMouseRollOver(param1);
        App.toolTipMgr.show(App.utils.commons.getFullPlayerName(App.utils.commons.getUserProps(data.creatorName,data.creatorClan,data.creatorRegion,data.creatorIgrType)));
    }
    
    override protected function handleMouseRollOut(param1:MouseEvent) : void
    {
        super.handleMouseRollOut(param1);
        App.toolTipMgr.hide();
    }
    
    override protected function handleMousePress(param1:MouseEvent) : void
    {
        this.pressEvent = param1;
    }
    
    override protected function handleMouseRelease(param1:MouseEvent) : void
    {
        if(this.pressEvent)
        {
            super.handleMousePress(this.pressEvent);
        }
        super.handleMouseRelease(param1);
    }
}
}
