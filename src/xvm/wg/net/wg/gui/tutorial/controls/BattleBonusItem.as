package net.wg.gui.tutorial.controls 
{
    import flash.text.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    import scaleform.gfx.*;
    
    public class BattleBonusItem extends scaleform.clik.core.UIComponent
    {
        public function BattleBonusItem()
        {
            super();
            return;
        }

        public function get hasBonusesTitle():String
        {
            return this._hasBonusesTitle;
        }

        public function set hasBonusesTitle(arg1:String):void
        {
            this._hasBonusesTitle = arg1;
            invalidate();
            return;
        }

        public function get noBonusesTitle():String
        {
            return this._noBonusesTitle;
        }

        public function set noBonusesTitle(arg1:String):void
        {
            this._noBonusesTitle = arg1;
            invalidate();
            return;
        }

        public function get noBonusesDescription():String
        {
            return this._noBonusesDescription;
        }

        public function set noBonusesDescription(arg1:String):void
        {
            this._noBonusesDescription = arg1;
            invalidate();
            return;
        }

        public function setBonuses(arg1:Number, arg2:Number):void
        {
            if (this._credits == arg1 && this._freeXP == arg2) 
                return;
            this._credits = isNaN(arg1) ? 0 : arg1;
            this._freeXP = isNaN(arg2) ? 0 : arg2;
            invalidate();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.titleField.wordWrap = true;
            this.descriptionField.wordWrap = true;
            this.valueField.wordWrap = true;
            this.valueField.autoSize = flash.text.TextFieldAutoSize.RIGHT;
            return;
        }

        protected override function draw():void
        {
            super.draw();
            var loc1:*=this._credits > 0 || this._freeXP > 0;
            if (loc1) 
            {
                gotoAndStop(STATE_HAS_BONUSES);
                this.setBonusesTextFields();
            }
            else 
            {
                gotoAndStop(STATE_NO_BONUSES);
                this.setNoBonusesTextFields();
            }
            return;
        }

        internal function setBonusesTextFields():void
        {
            this.titleField.autoSize = flash.text.TextFieldAutoSize.RIGHT;
            this.titleField.text = this._hasBonusesTitle;
            var loc1:*=App.utils.locale;
            this.valueField.htmlText = loc1.integer(this._credits) + "<br/>" + loc1.integer(this._freeXP);
            this.descriptionField.autoSize = flash.text.TextFieldAutoSize.RIGHT;
            this.descriptionField.htmlText = loc1.makeString(BATTLE_TUTORIAL.LABELS_CREDITS) + "<br/>" + loc1.makeString(BATTLE_TUTORIAL.LABELS_FREE_XP);
            scaleform.gfx.TextFieldEx.setVerticalAlign(this.titleField, scaleform.gfx.TextFieldEx.VALIGN_CENTER);
            scaleform.gfx.TextFieldEx.setVerticalAlign(this.valueField, scaleform.gfx.TextFieldEx.VALIGN_CENTER);
            scaleform.gfx.TextFieldEx.setVerticalAlign(this.descriptionField, scaleform.gfx.TextFieldEx.VALIGN_CENTER);
            return;
        }

        internal function setNoBonusesTextFields():void
        {
            this.titleField.autoSize = flash.text.TextFieldAutoSize.CENTER;
            this.titleField.text = this._noBonusesTitle;
            scaleform.gfx.TextFieldEx.setVerticalAlign(this.titleField, scaleform.gfx.TextFieldEx.VALIGN_CENTER);
            return;
        }

        internal static const STATE_HAS_BONUSES:String="has_bonuses";

        internal static const STATE_NO_BONUSES:String="no_bonuses";

        internal var _hasBonusesTitle:String="";

        internal var _noBonusesTitle:String="";

        internal var _noBonusesDescription:String="";

        internal var _credits:Number;

        internal var _freeXP:Number;

        public var titleField:flash.text.TextField;

        public var descriptionField:flash.text.TextField;

        public var valueField:flash.text.TextField;
    }
}
