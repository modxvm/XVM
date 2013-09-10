package net.wg.gui.prebattle.company 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class CompanyListItemRenderer extends net.wg.gui.components.controls.SoundListItemRenderer
    {
        public function CompanyListItemRenderer()
        {
            super();
            tabEnabled = true;
            focusable = true;
            return;
        }

        public function showPlayersList(arg1:Boolean):void
        {
            this._showPlayers = arg1;
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.clickHandler);
            if (this.dd) 
                this.dd.dispose();
            if (this.listRefreshData != null) 
                this.listRefreshData = null;
            return;
        }

        protected override function configUI():void
        {
            focusIndicator = this.emtyFocusIndicator;
            toggle = true;
            allowDeselect = true;
            super.configUI();
            constraints.addElement(this.descriptionField.name, this.descriptionField, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement(this.pCountField.name, this.pCountField, scaleform.clik.utils.Constraints.ALL);
            constraints.addElement(this.mainTextField.name, this.mainTextField, scaleform.clik.utils.Constraints.ALL);
            this.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.clickHandler);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && data) 
                this.afterSetData();
            return;
        }

        internal function afterSetData():void
        {
            this.pCountField.text = data.playersCount;
            this.divisionField.text = data.division;
            this.cutText(this.descriptionField, data.comment);
            this.cutText(this.mainTextField, data.creatorName);
            this.updateTextFieldWidth();
            return;
        }

        internal function cutText(arg1:flash.text.TextField, arg2:String):void
        {
            var loc1:*=null;
            var loc2:*=0;
            arg1.text = arg2;
            if (arg1.getLineLength(1) != -1) 
            {
                loc1 = arg2;
                loc2 = arg1.getLineLength(0);
                loc1 = loc1.substr(0, loc2 - 2);
                loc1 = loc1 + "..";
                arg1.text = loc1;
            }
            return;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1 == null) 
            {
                visible = false;
                return;
            }
            if (!visible) 
                visible = true;
            super.setData(arg1);
            this.dd.prbID = arg1.prbID;
            if (this.isPlayersData()) 
            {
                while (arg1.players.length < 15) 
                    arg1.players.push({"label":"", "color":null});
                this.dd.dataProvider = new scaleform.clik.data.DataProvider(arg1.players);
            }
            if (this._showPlayers && this.isPlayersData() && selected) 
                if (!this.dd.isOpen()) 
                    this.dd.open();
            else if (this.dd.isOpen()) 
                this.dd.close();
            this.afterSetData();
            invalidate(scaleform.clik.constants.InvalidationType.DATA);
            return;
        }

        internal function clickHandler(arg1:scaleform.clik.events.ButtonEvent):void
        {
            if (arg1.isKeyboard) 
                return;
            App.utils.focusHandler.setFocus(this);
            this.dispatchIsSelectedItem(selected);
            if (this._showPlayers) 
                if (this.dd.isOpen()) 
                    this.dd.close();
                else if (selected) 
                    this.dd.open();
            else if (this.dd.isOpen()) 
                this.dropDownState = -1;
            else 
                this.dropDownState = 1;
            return;
        }

        internal function dispatchIsSelectedItem(arg1:Boolean):void
        {
            var loc1:*=new net.wg.gui.prebattle.company.CompanyEvent(net.wg.gui.prebattle.company.CompanyEvent.SELECTED_ITEM, true);
            loc1.isSelected = arg1;
            loc1.prbID = data.prbID;
            dispatchEvent(loc1);
            return;
        }

        internal function isPlayersData():Boolean
        {
            return data.hasOwnProperty("players") && !(data.players == null);
        }

        internal function updateTextFieldWidth():void
        {
            this.divisionField.x = Math.round(this.mainTextField.x + this.mainTextField.textWidth + 12);
            this.divisionField.width = Math.round(this.pCountField.x - this.divisionField.x - 8);
            return;
        }

        public override function set selected(arg1:Boolean):void
        {
            if (!arg1 && this.dd.isOpen()) 
                this.dd.close();
            super.selected = arg1;
            return;
        }

        public function refreshPopulateData(arg1:Function):void
        {
            this.listRefreshData = arg1;
            return;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(arg1);
            App.toolTipMgr.show(data.creatorName);
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOut(arg1);
            App.toolTipMgr.hide();
            return;
        }

        protected override function handleMousePress(arg1:flash.events.MouseEvent):void
        {
            this.pressEvent = arg1;
            return;
        }

        protected override function handleMouseRelease(arg1:flash.events.MouseEvent):void
        {
            if (this.pressEvent) 
                super.handleMousePress(this.pressEvent);
            super.handleMouseRelease(arg1);
            return;
        }

        public var descriptionField:flash.text.TextField;

        public var pCountField:flash.text.TextField;

        public var divisionField:flash.text.TextField;

        public var dd:net.wg.gui.prebattle.company.GroupPlayersDropDownMenu;

        public var bg:flash.display.MovieClip;

        public var mainTextField:flash.text.TextField;

        public var emtyFocusIndicator:flash.display.MovieClip;

        internal var dropDownState:int=1;

        internal var _showPlayers:Boolean=false;

        internal var listRefreshData:Function;

        internal var pressEvent:flash.events.MouseEvent;
    }
}
