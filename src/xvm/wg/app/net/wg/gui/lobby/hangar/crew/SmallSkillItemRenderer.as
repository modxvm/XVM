package net.wg.gui.lobby.hangar.crew
{
    import scaleform.clik.controls.ListItemRenderer;
    import net.wg.gui.components.controls.UILoaderAlt;
    import scaleform.clik.constants.InvalidationType;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import scaleform.clik.events.InputEvent;
    import flash.events.TimerEvent;
    
    public class SmallSkillItemRenderer extends ListItemRenderer
    {
        
        public function SmallSkillItemRenderer()
        {
            super();
            _stateMap = {"up":["up"],
            "over":["over"],
            "down":["down"],
            "release":["release","over"],
            "out":["out","up"],
            "disabled":["disabled"],
            "selecting":["selecting","over"],
            "toggle":["toggle","up"],
            "kb_selecting":["kb_selecting","up"],
            "kb_release":["kb_release","out","up"],
            "kb_down":["kb_down","down"],
            "in_progress":["in_progress"],
            "new_skill":["new_skill"]
        };
    }
    
    public var loader:UILoaderAlt;
    
    private var _tooltipID:String = null;
    
    private var _inprogress:Boolean = false;
    
    override public function setData(param1:Object) : void
    {
        var _loc2_:SkillsVO = null;
        this.data = param1;
        if(param1)
        {
            _loc2_ = SkillsVO(param1);
            this.inprogress = _loc2_.inprogress == true;
            if((_loc2_.name) && (_loc2_.desc))
            {
                this._tooltipID = _loc2_.name + "\n\n" + _loc2_.desc;
            }
            invalidateData();
        }
    }
    
    override public function toString() : String
    {
        return "[Scaleform RoleItemRenderer " + name + "]";
    }
    
    public function get inprogress() : Boolean
    {
        return this._inprogress;
    }
    
    public function set inprogress(param1:Boolean) : void
    {
        this._inprogress = param1;
    }
    
    override protected function configUI() : void
    {
        super.configUI();
    }
    
    override protected function draw() : void
    {
        var _loc1_:SkillsVO = null;
        super.draw();
        if((isInvalid(InvalidationType.DATA)) && (data))
        {
            _loc1_ = SkillsVO(data);
            if(_loc1_.icon)
            {
                this.loader.visible = true;
                this.loader.source = _loc1_.icon;
            }
            else
            {
                this.loader.visible = false;
                this.loader.source = "";
            }
            if(_loc1_.buy)
            {
                this.loader.visible = false;
                this._tooltipID = MENU.HANGAR_CREW_TOOLTIP_NEW_SKILL;
                gotoAndStop("new_skill");
            }
            else
            {
                gotoAndStop(this.inprogress?"in_progress":"up");
                this.loader.alpha = (_loc1_.active) || (_loc1_.buy)?1:0.35;
            }
        }
    }
    
    override protected function onDispose() : void
    {
        removeEventListener(Event.ADDED,addToAutoGroup,false);
        removeEventListener(Event.REMOVED,addToAutoGroup,false);
        removeEventListener(MouseEvent.ROLL_OVER,handleMouseRollOver,false);
        removeEventListener(MouseEvent.ROLL_OUT,handleMouseRollOut,false);
        removeEventListener(MouseEvent.MOUSE_DOWN,handleMousePress,false);
        removeEventListener(MouseEvent.CLICK,handleMouseRelease,false);
        removeEventListener(MouseEvent.DOUBLE_CLICK,handleMouseRelease,false);
        removeEventListener(InputEvent.INPUT,handleInput,false);
        if(_repeatTimer)
        {
            _repeatTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,beginRepeat,false);
            _repeatTimer.removeEventListener(TimerEvent.TIMER,handleRepeat,false);
        }
        if(this.loader)
        {
            this.loader.dispose();
            this.loader = null;
        }
        _data = null;
        super.onDispose();
    }
}
}
