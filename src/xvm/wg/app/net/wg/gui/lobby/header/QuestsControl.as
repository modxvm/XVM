package net.wg.gui.lobby.header 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.exceptions.base.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    
    public class QuestsControl extends net.wg.infrastructure.base.meta.impl.QuestsControlMeta implements net.wg.infrastructure.base.meta.IQuestsControlMeta, net.wg.infrastructure.interfaces.IDAAPIModule
    {
        public function QuestsControl()
        {
            super();
            return;
        }

        public function get disposed():Boolean
        {
            return this._disposed;
        }

        public function as_highlightControl():void
        {
            this._hasNew = true;
            invalidate(NEW);
            return;
        }

        public function as_resetControl():void
        {
            this._hasNew = false;
            invalidate(NEW);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.label = QUESTS.QUESTSCONTROL_TITLE;
            addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onPress);
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            addEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            return;
        }

        public override function dispose():void
        {
            removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onPress);
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.showTooltip);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.hideTooltip);
            removeEventListener(flash.events.MouseEvent.CLICK, this.hideTooltip);
            super.dispose();
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(NEW)) 
            {
                if (this._hasNew) 
                {
                    this.anim.gotoAndPlay(ANIMATE);
                }
                else 
                {
                    this.anim.gotoAndStop(PAUSE);
                }
                setState("up");
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
            {
                if (_newFrame) 
                {
                    gotoAndPlay(_newFrame);
                    _newFrame = null;
                }
                if (focusIndicator && _newFocusIndicatorFrame) 
                {
                    focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
                    _newFocusIndicatorFrame = null;
                }
                updateAfterStateChange();
                dispatchEvent(new scaleform.clik.events.ComponentEvent(scaleform.clik.events.ComponentEvent.STATE_CHANGE));
                invalidate(scaleform.clik.constants.InvalidationType.DATA, scaleform.clik.constants.InvalidationType.SIZE);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                updateText();
            }
            return;
        }

        internal function onPress(arg1:scaleform.clik.events.ButtonEvent):void
        {
            App.toolTipMgr.hide();
            this.anim.gotoAndStop(PAUSE);
            showQuestsWindowS();
            return;
        }

        protected override function getStatePrefixes():__AS3__.vec.Vector.<String>
        {
            var loc1:*="new_";
            return this._hasNew ? Vector.<String>([loc1]) : statesDefault;
        }

        public function as_populate():void
        {
            return;
        }

        public function as_dispose():void
        {
            var loc1:*;
            try 
            {
                dispatchEvent(new net.wg.infrastructure.events.LifeCycleEvent(net.wg.infrastructure.events.LifeCycleEvent.ON_BEFORE_DISPOSE));
                this.dispose();
                this._disposed = true;
                dispatchEvent(new net.wg.infrastructure.events.LifeCycleEvent(net.wg.infrastructure.events.LifeCycleEvent.ON_AFTER_DISPOSE));
            }
            catch (error:net.wg.infrastructure.exceptions.base.WGGUIException)
            {
                DebugUtils.LOG_WARNING(error.getStackTrace());
            }
            catch (error:Error)
            {
                DebugUtils.LOG_ERROR(error.getStackTrace());
            }
            return;
        }

        internal function hideTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function showTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.QUESTS_NOTIFIER);
            return;
        }

        internal static const ANIMATE:String="animate";

        internal static const PAUSE:String="pause";

        internal static const NEW:String="New";

        public var anim:flash.display.MovieClip=null;

        internal var _disposed:Boolean=false;

        internal var _hasNew:Boolean=false;
    }
}
