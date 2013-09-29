package net.wg.gui.lobby.techtree.controls 
{
    import flash.text.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    import scaleform.gfx.*;
    
    public class ResearchTitleBar extends scaleform.clik.core.UIComponent
    {
        public function ResearchTitleBar()
        {
            super();
            scaleform.gfx.Extensions.enabled = true;
            return;
        }

        public function setTitle(arg1:String):void
        {
            if (this._title == arg1) 
            {
                return;
            }
            this._title = arg1;
            invalidate(net.wg.gui.lobby.techtree.constants.TTInvalidationType.TITLE);
            return;
        }

        public function setNation(arg1:String):void
        {
            if (this._nation == arg1) 
            {
                return;
            }
            this._nation = arg1;
            invalidate(net.wg.gui.lobby.techtree.constants.TTInvalidationType.NATION);
            return;
        }

        public override function dispose():void
        {
            if (this.returnButton != null) 
            {
                this.returnButton.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClickReturnButton, false);
                this.returnButton.dispose();
            }
            super.dispose();
            return;
        }

        protected override function configUI():void
        {
            constraints = new scaleform.clik.utils.Constraints(this);
            if (this.titleField != null) 
            {
                constraints.addElement(this.titleField.name, this.titleField, scaleform.clik.utils.Constraints.LEFT | scaleform.clik.utils.Constraints.RIGHT);
            }
            if (this.returnButton != null) 
            {
                constraints.addElement(this.returnButton.name, this.returnButton, scaleform.clik.utils.Constraints.TOP | scaleform.clik.utils.Constraints.LEFT);
                this.returnButton.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleClickReturnButton, false, 0, true);
            }
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(net.wg.gui.lobby.techtree.constants.TTInvalidationType.TITLE) && !(this.titleField == null)) 
            {
                scaleform.gfx.TextFieldEx.setVerticalAlign(this.titleField, scaleform.gfx.TextFieldEx.VALIGN_CENTER);
                this.titleField.text = this._title;
            }
            if (isInvalid(net.wg.gui.lobby.techtree.constants.TTInvalidationType.NATION) && !(this.returnButton == null)) 
            {
                if (this._nation.length > 0) 
                {
                    this.returnButton.label = this._nation;
                    this.returnButton.visible = true;
                }
                else 
                {
                    this.returnButton.visible = false;
                }
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                constraints.update(_width, _height);
            }
            return;
        }

        internal function handleClickReturnButton(arg1:scaleform.clik.events.ButtonEvent):void
        {
            dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(net.wg.gui.lobby.techtree.TechTreeEvent.RETURN_2_TECHTREE));
            return;
        }

        internal var _title:String="";

        internal var _nation:String="";

        public var titleField:flash.text.TextField;

        public var returnButton:net.wg.gui.lobby.techtree.controls.ReturnToTTButton;
    }
}
