package net.wg.gui.lobby.hangar.crew 
{
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.events.*;
    
    public class SmallSkillItemRenderer extends scaleform.clik.controls.ListItemRenderer
    {
        public function SmallSkillItemRenderer()
        {
            super();
            _stateMap = {"up":["up"], "over":["over"], "down":["down"], "release":["release", "over"], "out":["out", "up"], "disabled":["disabled"], "selecting":["selecting", "over"], "toggle":["toggle", "up"], "kb_selecting":["kb_selecting", "up"], "kb_release":["kb_release", "out", "up"], "kb_down":["kb_down", "down"], "in_progress":["in_progress"], "new_skill":["new_skill"]};
            return;
        }

        public override function setData(arg1:Object):void
        {
            var loc1:*=null;
            this.data = arg1;
            if (arg1) 
            {
                loc1 = net.wg.gui.lobby.hangar.crew.SkillsVO(arg1);
                this.inprogress = loc1.inprogress == true;
                if (loc1.name && loc1.desc) 
                    this._tooltipID = loc1.name + "\n\n" + loc1.desc;
                invalidateData();
            }
            return;
        }

        public override function toString():String
        {
            return "[Scaleform RoleItemRenderer " + name + "]";
        }

        public function get inprogress():Boolean
        {
            return this._inprogress;
        }

        public function set inprogress(arg1:Boolean):void
        {
            this._inprogress = arg1;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && data) 
            {
                loc1 = net.wg.gui.lobby.hangar.crew.SkillsVO(data);
                if (loc1.icon) 
                {
                    this.loader.visible = true;
                    this.loader.source = loc1.icon;
                }
                else 
                {
                    this.loader.visible = false;
                    this.loader.source = "";
                }
                if (loc1.buy) 
                {
                    this.loader.visible = false;
                    this._tooltipID = MENU.HANGAR_CREW_TOOLTIP_NEW_SKILL;
                    gotoAndStop("new_skill");
                }
                else 
                {
                    gotoAndStop(this.inprogress ? "in_progress" : "up");
                    this.loader.alpha = loc1.active || loc1.buy ? 1 : 0.35;
                }
            }
            return;
        }

        public override function dispose():void
        {
            removeEventListener(flash.events.Event.ADDED, addToAutoGroup, false);
            removeEventListener(flash.events.Event.REMOVED, addToAutoGroup, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, handleMouseRollOver, false);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, handleMouseRollOut, false);
            removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, handleMousePress, false);
            removeEventListener(flash.events.MouseEvent.CLICK, handleMouseRelease, false);
            removeEventListener(flash.events.MouseEvent.DOUBLE_CLICK, handleMouseRelease, false);
            removeEventListener(scaleform.clik.events.InputEvent.INPUT, handleInput, false);
            if (_repeatTimer) 
            {
                _repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, beginRepeat, false);
                _repeatTimer.removeEventListener(flash.events.TimerEvent.TIMER, handleRepeat, false);
            }
            if (this.loader) 
            {
                this.loader.dispose();
                this.loader = null;
            }
            _data = null;
            super.dispose();
            return;
        }

        public var loader:net.wg.gui.components.controls.UILoaderAlt;

        internal var _tooltipID:String=null;

        internal var _inprogress:Boolean=false;
    }
}
