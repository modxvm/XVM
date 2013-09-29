package net.wg.gui.lobby.techtree.controls 
{
    import __AS3__.vec.*;
    import fl.transitions.easing.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.gui.lobby.techtree.constants.*;
    import net.wg.gui.lobby.techtree.data.state.*;
    import net.wg.gui.lobby.techtree.interfaces.*;
    import net.wg.gui.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.motion.*;
    import scaleform.gfx.*;
    
    public class ActionButton extends net.wg.gui.components.controls.SoundButton
    {
        public function ActionButton()
        {
            super();
            return;
        }

        public function set imgSubstitution(arg1:Object):void
        {
            this._imgSubstitution = new net.wg.gui.utils.ImageSubstitution(arg1.subString, arg1.source, arg1.baseLineY, arg1.width, arg1.height, true);
            return;
        }

        public function get action():String
        {
            return this._action;
        }

        public function set action(arg1:String):void
        {
            if (this._action == arg1) 
            {
                return;
            }
            this._action = arg1;
            this.makeStatesPrefixes();
            setState(this.state);
            return;
        }

        public function setOwner(arg1:scaleform.clik.core.UIComponent, arg2:Boolean=false):void
        {
            if (_owner != arg1) 
            {
                _owner = arg1;
            }
            if (arg2) 
            {
                validateNow();
            }
            return;
        }

        public function setAnimation(arg1:Number, arg2:net.wg.gui.lobby.techtree.data.state.AnimationProperties):Boolean
        {
            if (this.animID == arg1) 
            {
                return false;
            }
            this.animID = arg1;
            if (this.animProps != null) 
            {
                this.animProps.setTo(this);
            }
            this.animProps = arg2;
            if (arg2 != null) 
            {
                this.animProps.setFrom(this);
                if (alpha == 0) 
                {
                    enabled = false;
                }
            }
            return true;
        }

        public function startAnimation():void
        {
            if (this.animProps != null) 
            {
                this.animTween = new scaleform.clik.motion.Tween(this.animProps.duration, this, this.animProps.to, {"ease":fl.transitions.easing.Strong.easeOut, "onComplete":this.onTweenComplete});
            }
            return;
        }

        public function endAnimation(arg1:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=false;
            if (this.animProps != null) 
            {
                loc1 = scaleform.gfx.Extensions.getMouseTopMostEntity(true);
                loc2 = false;
                if (!(loc1 == null) && !(owner == null)) 
                {
                    loc2 = loc1 == owner || owner.contains(loc1);
                }
                if (!arg1 && owner.hitTestPoint(stage.mouseX, stage.mouseY, true) && loc2) 
                {
                    return;
                }
                if (this.hitTestPoint(stage.mouseX, stage.mouseY, true) && loc2) 
                {
                    if (this.animTween != null) 
                    {
                        this.animTween.reset();
                    }
                    this.animProps.setTo(this);
                }
                else 
                {
                    this.animTween = new scaleform.clik.motion.Tween(this.animProps.duration, this, this.animProps.from, {"ease":fl.transitions.easing.Strong.easeOut, "onComplete":this.onTweenComplete});
                }
            }
            return;
        }

        public override function hitTestPoint(arg1:Number, arg2:Number, arg3:Boolean=false):Boolean
        {
            return hitArea == null ? super.hitTestPoint(arg1, arg2, arg3) : hitArea.hitTestPoint(arg1, arg2, arg3);
        }

        public function onTweenComplete():void
        {
            if (alpha != 0) 
            {
                mouseEnabled = enabled;
            }
            else 
            {
                mouseEnabled = false;
            }
            return;
        }

        public override function dispose():void
        {
            owner = null;
            super.dispose();
            return;
        }

        protected override function preInitialize():void
        {
            super.preInitialize();
            _state = "up";
            return;
        }

        protected override function initialize():void
        {
            this.makeStatesPrefixes();
            super.initialize();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE) && !(this.disableIndicator == null)) 
            {
                this.disableIndicator.visible = state == "disabled";
            }
            return;
        }

        protected override function updateText():void
        {
            if (!(_label == null) && !(textField == null)) 
            {
                if (!(this._imgSubstitution == null) && this._imgSubstitution.valid) 
                {
                    scaleform.gfx.TextFieldEx.setImageSubstitutions(textField, this._imgSubstitution);
                    textField.text = label + this._imgSubstitution.subString;
                }
                else 
                {
                    textField.text = label;
                }
            }
            return;
        }

        protected override function handleClick(arg1:uint=0):void
        {
            super.handleClick(arg1);
            this.doAction();
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOut(arg1);
            this.endAnimation(false);
            return;
        }

        protected override function handleReleaseOutside(arg1:flash.events.MouseEvent):void
        {
            super.handleReleaseOutside(arg1);
            this.endAnimation(false);
            return;
        }

        internal function doAction():void
        {
            var loc2:*=null;
            var loc1:*=null;
            var loc3:*=this._action;
            switch (loc3) 
            {
                case net.wg.gui.lobby.techtree.constants.ActionName.UNLOCK:
                {
                    loc1 = net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_UNLOCK;
                    break;
                }
                case net.wg.gui.lobby.techtree.constants.ActionName.BUY:
                {
                    loc1 = net.wg.gui.lobby.techtree.TechTreeEvent.CLICK_2_BUY;
                    break;
                }
            }
            if (!(loc1 == null) && !(owner == null)) 
            {
                loc2 = owner as net.wg.gui.lobby.techtree.interfaces.IRenderer;
                if (loc2 != null) 
                {
                    dispatchEvent(new net.wg.gui.lobby.techtree.TechTreeEvent(loc1, 0, loc2.index, loc2.getEntityType()));
                }
            }
            return;
        }

        internal function makeStatesPrefixes():void
        {
            var loc1:*=this._action + "_";
            statesSelected = Vector.<String>(["selected_", loc1]);
            statesDefault = Vector.<String>([loc1]);
            return;
        }

        internal var animProps:net.wg.gui.lobby.techtree.data.state.AnimationProperties=null;

        internal var animID:Number=-1;

        internal var animTween:scaleform.clik.motion.Tween=null;

        internal var _action:String="unlock";

        internal var _imgSubstitution:net.wg.gui.utils.ImageSubstitution;

        public var icon:flash.display.MovieClip;

        public var disableIndicator:net.wg.gui.components.controls.BitmapFill;
    }
}
