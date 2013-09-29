package net.wg.gui.prebattle.battleSession 
{
    import flash.display.*;
    import flash.text.*;
    import scaleform.clik.core.*;
    
    public class RequirementInfo extends scaleform.clik.core.UIComponent
    {
        public function RequirementInfo()
        {
            super();
            this._textFields = {"lightTank":this.lightLevelField, "mediumTank":this.mediumLevelField, "heavyTank":this.heavyLevelField, "SPG":this.spgLevelField, "AT-SPG":this.atspgLevelField};
            return;
        }

        public function get textFields():Object
        {
            return this._textFields;
        }

        public var flagList:net.wg.gui.prebattle.battleSession.FlagsList;

        public var requiredNationText:flash.text.TextField;

        public var heavyLevelField:flash.text.TextField;

        public var mediumLevelField:flash.text.TextField;

        public var lightLevelField:flash.text.TextField;

        public var atspgLevelField:flash.text.TextField;

        public var spgLevelField:flash.text.TextField;

        public var requiredTypeText:flash.text.TextField;

        public var icons:flash.display.MovieClip;

        internal var _textFields:Object;
    }
}
