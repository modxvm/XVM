package net.wg.gui.lobby.header 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.events.*;
    import net.wg.gui.tutorial.constants.*;
    import net.wg.gui.utils.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.exceptions.base.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class TutorialControl extends net.wg.infrastructure.base.meta.impl.TutorialControlMeta implements net.wg.infrastructure.base.meta.ITutorialControlMeta, net.wg.infrastructure.interfaces.IDAAPIModule
    {
        public function TutorialControl()
        {
            this._level = net.wg.gui.tutorial.constants.PlayerXPLevel.NEWBIE;
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            preventAutosizing = true;
            addEventListener(flash.events.MouseEvent.ROLL_OVER, this.onRollOver);
            addEventListener(flash.events.MouseEvent.ROLL_OUT, this.onRollOut);
            addEventListener(flash.events.MouseEvent.MOUSE_UP, this.onRelease);
            addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onPress);
            setState("out");
            return;
        }

        protected override function draw():void
        {
            super.draw();
            visible = this._visibleTD;
            if (this.titleField && this._title) 
            {
                this.titleField.text = this._title;
            }
            if (this.stateField) 
            {
                this.stateField.text = this._isRunning ? this._refuseStatus : this._restartStatus;
            }
            return;
        }

        protected override function getStatePrefixes():__AS3__.vec.Vector.<String>
        {
            if (!enabled) 
            {
                return Vector.<String>([this.getLevelPrefix()]);
            }
            var loc1:*=this._isRunning ? PREFIX_RUN : PREFIX_PAUSE + this.getLevelPrefix();
            return Vector.<String>([loc1]);
        }

        internal function getLevelPrefix():String
        {
            return this._level != net.wg.gui.tutorial.constants.PlayerXPLevel.NORMAL ? PREFIX_NEWBIE : PREFIX_NORMAL;
        }

        public override function dispose():void
        {
            super.dispose();
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.onRollOver);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.onRollOut);
            removeEventListener(flash.events.MouseEvent.MOUSE_UP, this.onRelease);
            removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, this.onPress);
            return;
        }

        internal function onRollOver(arg1:flash.events.MouseEvent):void
        {
            this.showToolTip();
            return;
        }

        internal function onRollOut(arg1:flash.events.MouseEvent):void
        {
            this.hideToolTip();
            return;
        }

        internal function onRelease(arg1:flash.events.MouseEvent):void
        {
            if (App.utils.commons.isLeftButton(arg1)) 
            {
                this.hideToolTip();
                if (this._isRunning) 
                {
                    dispatchEvent(new net.wg.gui.events.HeaderEvent(net.wg.gui.events.HeaderEvent.SHOW_MESSAGE_DIALOG, "refuseTraining"));
                }
                else 
                {
                    restartS();
                }
            }
            return;
        }

        internal function onPress(arg1:flash.events.MouseEvent):void
        {
            this.hideToolTip();
            return;
        }

        internal function showToolTip():void
        {
            var loc1:*=new net.wg.gui.utils.ComplexTooltipHelper().addHeader(this._title).addBody(this._description).addNote(this._isRunning ? null : TUTORIAL.TOOLTIP_NOTES_RESTART, true).make();
            if (loc1.length > 0) 
            {
                App.toolTipMgr.showComplex(loc1);
            }
            return;
        }

        internal function hideToolTip():void
        {
            App.toolTipMgr.hide();
            return;
        }

        public function get disposed():Boolean
        {
            return this._disposed;
        }

        public function as_setup(arg1:Object):void
        {
            this._visibleIfRun = arg1.visibleIfRun;
            this._restartStatus = arg1.restartStatus;
            this._refuseStatus = arg1.refuseStatus;
            return;
        }

        public function as_setPlayerXPLevel(arg1:int):void
        {
            this._level = arg1;
            invalidate();
            return;
        }

        public function as_setChapterInfo(arg1:String, arg2:String):void
        {
            this._visibleTD = this._isRunning ? this._visibleIfRun : true;
            this._title = arg1;
            this._description = arg2;
            invalidate();
            return;
        }

        public function as_clearChapterInfo():void
        {
            this._visibleTD = false;
            this._title = "";
            this._description = "";
            invalidate();
            return;
        }

        public function as_setRunMode():void
        {
            this._isRunning = true;
            this._visibleTD = this._visibleIfRun;
            setState(state);
            return;
        }

        public function as_setRestartMode():void
        {
            this._isRunning = false;
            this._visibleTD = true;
            setState(state);
            return;
        }

        public function as_setDisabled(arg1:Boolean):void
        {
            App.globalVarsMgr.setTutorialDisabledS(arg1);
            enabled = !arg1;
            this.hideToolTip();
            setState(state);
            return;
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

        internal static const PREFIX_NORMAL:String="normal_";

        internal static const PREFIX_NEWBIE:String="newbie_";

        internal static const PREFIX_RUN:String="run_";

        internal static const PREFIX_PAUSE:String="pause_";

        internal var _title:String="";

        internal var _description:String="";

        internal var _level:Number;

        internal var _isRunning:Boolean=false;

        internal var _visibleTD:Boolean;

        internal var _visibleIfRun:Boolean=false;

        internal var _restartStatus:String="";

        internal var _refuseStatus:String="";

        public var titleField:flash.text.TextField;

        public var stateField:flash.text.TextField;

        internal var _disposed:Boolean=false;
    }
}
