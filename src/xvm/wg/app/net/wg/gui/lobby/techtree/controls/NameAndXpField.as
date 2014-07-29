package net.wg.gui.lobby.techtree.controls
{
    import flash.text.TextField;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.techtree.constants.XpTypeStrings;
    
    public class NameAndXpField extends NodeComponent
    {
        
        public function NameAndXpField()
        {
            super();
        }
        
        private static var statesMap:Object = {"locked":["locked","locked","locked"],
        "normal":["normal_name","normal_name_and_xp","normal_name_and_xp_action"],
        "premium":["premium_name","premium_name_and_xp","premium_name_and_xp_action"]
    };
    
    private static var FIRST_COLUMN:int = 0;
    
    private static var SECOND_COLUMN:int = 1;
    
    private static var THIRD_COLUMN:int = 2;
    
    public var xpLabel:String = "earnedXPLabel";
    
    public var changeXpIconToElite:Boolean = false;
    
    public var nameField:TextField;
    
    public var xpField:TextField;
    
    public var xpIcon:XPIcon;
    
    private var _isInAction:Boolean;
    
    public function setIsInAction(param1:Boolean) : void
    {
        this._isInAction = param1;
    }
    
    override protected function configUI() : void
    {
        mouseEnabled = mouseChildren = false;
        super.configUI();
    }
    
    override protected function draw() : void
    {
        var _loc1_:String = null;
        var _loc2_:* = 0;
        var _loc3_:String = null;
        if(!(_owner == null) && (isInvalid(InvalidationType.DATA)))
        {
            _loc1_ = this.xpLabel.length > 0?_owner.getNamedLabel(this.xpLabel):"";
            _loc2_ = FIRST_COLUMN;
            if(_loc1_.length > 0)
            {
                _loc2_ = this._isInAction?THIRD_COLUMN:SECOND_COLUMN;
            }
            _loc3_ = statesMap[state][_loc2_];
            if(!(currentFrameLabel == _loc3_) && (_labelHash[_loc3_]))
            {
                gotoAndStop(_loc3_);
            }
            this.setNameField(_owner.getItemName());
            this.setXpField(_loc1_);
            if(this.changeXpIconToElite)
            {
                if(_owner.isElite())
                {
                    this.setXpIcon(XpTypeStrings.ELITE_XP_TYPE);
                }
                else
                {
                    this.setXpIcon(XpTypeStrings.EARNED_XP_TYPE);
                }
            }
        }
        super.draw();
    }
    
    private function setNameField(param1:String) : void
    {
        if(!(this.nameField == null) && !(param1 == null))
        {
            this.nameField.text = param1;
        }
    }
    
    private function setXpField(param1:String) : void
    {
        if(!(this.xpField == null) && !(param1 == null))
        {
            this.xpField.text = param1;
        }
    }
    
    private function setXpIcon(param1:String) : void
    {
        if(this.xpIcon != null)
        {
            this.xpIcon.type = param1;
            this.xpIcon.validateNow();
        }
    }
}
}
