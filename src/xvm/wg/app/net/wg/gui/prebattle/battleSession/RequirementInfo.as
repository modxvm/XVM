package net.wg.gui.prebattle.battleSession
{
    import scaleform.clik.core.UIComponent;
    import flash.text.TextField;
    import flash.display.MovieClip;
    
    public class RequirementInfo extends UIComponent
    {
        
        public function RequirementInfo() {
            super();
            this._textFields = {
                "lightTank":this.lightLevelField,
                "mediumTank":this.mediumLevelField,
                "heavyTank":this.heavyLevelField,
                "SPG":this.spgLevelField,
                "AT-SPG":this.atspgLevelField
            };
    }
    
    public var flagList:FlagsList;
    
    public var requiredNationText:TextField;
    
    public var heavyLevelField:TextField;
    
    public var mediumLevelField:TextField;
    
    public var lightLevelField:TextField;
    
    public var atspgLevelField:TextField;
    
    public var spgLevelField:TextField;
    
    public var requiredTypeText:TextField;
    
    public var icons:MovieClip;
    
    private var _textFields:Object;
    
    public function get textFields() : Object {
        return this._textFields;
    }
}
}
