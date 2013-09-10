package net.wg.infrastructure.managers.impl 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.data.managers.*;
    import net.wg.data.managers.impl.*;
    import net.wg.gui.utils.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.infrastructure.managers.*;
    import net.wg.utils.*;
    
    public class ToolTipManager extends net.wg.infrastructure.base.meta.impl.ToolTipMgrMeta implements net.wg.infrastructure.managers.ITooltipMgr, net.wg.infrastructure.base.meta.IToolTipMgrMeta
    {
        public function ToolTipManager(arg1:flash.display.DisplayObjectContainer)
        {
            super();
            this._container = arg1;
            return;
        }

        public function as_show(arg1:Object, arg2:String):void
        {
            this.hide();
            var loc1:*=App.utils;
            if (this._props.showDelay != 0) 
                loc1.scheduler.scheduleTask(this.hide, this._props.showDelay);
            this._currentTooltip = flash.display.DisplayObject(loc1.classFactory.getObject(arg2, this._props));
            if (this._currentTooltip != null) 
            {
                net.wg.infrastructure.interfaces.IToolTip(this._currentTooltip).build(arg1, this._props);
                this._container.addChild(this._currentTooltip);
            }
            this._props = null;
            return;
        }

        public function hide():void
        {
            if (this._currentTooltip != null) 
            {
                net.wg.infrastructure.interfaces.entity.IDisposable(this._currentTooltip).dispose();
                this._container.removeChild(this._currentTooltip);
                this._currentTooltip = null;
            }
            this.cancelTasks();
            return;
        }

        public function showSpecial(arg1:String, arg2:net.wg.data.managers.ITooltipProps, ... rest):void
        {
            this._props = this.prepareProperties(arg2);
            this.cancelTasks();
            App.utils.scheduler.scheduleTask(onCreateTypedTooltipS, SCHEDULE_TIME, arg1, rest, this._props.type);
            return;
        }

        public function showComplex(arg1:String, arg2:net.wg.data.managers.ITooltipProps=null):void
        {
            this._props = this.prepareProperties(arg2);
            this.rescheduleTask(onCreateComplexTooltipS, arg1, this._props.type);
            return;
        }

        public function showComplexWithParams(arg1:String, arg2:net.wg.data.managers.IToolTipParams, arg3:net.wg.data.managers.ITooltipProps=null):void
        {
            if (!arg2) 
                return;
            var loc1:*=new net.wg.gui.utils.ComplexTooltipHelper();
            if (arg2.header) 
                loc1.addHeader(App.utils.locale.makeString(arg1 + "/header", arg2.header));
            if (arg2.body) 
                loc1.addBody(App.utils.locale.makeString(arg1 + "/body", arg2.body));
            if (arg2.note) 
                loc1.addNote(App.utils.locale.makeString(arg1 + "/note", arg2.note));
            var loc2:*;
            if ((loc2 = loc1.make()).length > 0) 
                App.toolTipMgr.showComplex(loc2);
            return;
        }

        public function show(arg1:String, arg2:net.wg.data.managers.ITooltipProps=null):void
        {
            this._props = this.prepareProperties(arg2);
            this.rescheduleTask(this.as_show, arg1, net.wg.data.constants.Linkages.TOOL_TIP_COMPLEX);
            return;
        }

        public function showLocal(arg1:String, arg2:Object, arg3:net.wg.data.managers.ITooltipProps=null):void
        {
            this._props = this.prepareProperties(arg3);
            this.cancelTasks();
            App.utils.scheduler.scheduleTask(this.as_show, SCHEDULE_TIME, arg2, arg1);
            return;
        }

        internal function prepareProperties(arg1:net.wg.data.managers.ITooltipProps):net.wg.data.managers.ITooltipProps
        {
            if (arg1 == null) 
                return net.wg.data.managers.impl.TooltipProps.DEFAULT;
            return arg1;
        }

        internal function cancelTasks():void
        {
            var loc1:*=App.utils.scheduler;
            loc1.cancelTask(onCreateTypedTooltipS);
            loc1.cancelTask(onCreateComplexTooltipS);
            loc1.cancelTask(this.as_show);
            return;
        }

        internal function rescheduleTask(arg1:Function, arg2:String, arg3:String):void
        {
            this.cancelTasks();
            App.utils.scheduler.scheduleTask(arg1, SCHEDULE_TIME, arg2, arg3);
            return;
        }

        internal static const SCHEDULE_TIME:uint=100;

        internal var _container:flash.display.DisplayObjectContainer=null;

        internal var _currentTooltip:flash.display.DisplayObject=null;

        internal var _props:net.wg.data.managers.ITooltipProps=null;
    }
}
