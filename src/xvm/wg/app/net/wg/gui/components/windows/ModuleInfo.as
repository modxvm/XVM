package net.wg.gui.components.windows 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.moduleInfo.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class ModuleInfo extends net.wg.infrastructure.base.meta.impl.ModuleInfoMeta implements net.wg.infrastructure.base.meta.IModuleInfoMeta
    {
        public function ModuleInfo()
        {
            super();
            this.addedChildren = [];
            return;
        }

        public function get moduleInfo():Object
        {
            return this._moduleInfo;
        }

        public function set moduleInfo(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=NaN;
            var loc5:*=null;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=null;
            var loc13:*=null;
            var loc14:*=null;
            var loc15:*=0;
            this._moduleInfo = arg1;
            if (this.moduleInfo) 
            {
                loc1 = this.moduleInfo.type;
                this.moduleName.text = this.moduleInfo.name;
                if (loc1 != net.wg.data.constants.FittingTypes.EQUIPMENT) 
                {
                    this.moduleDescription.text = this.moduleInfo.description;
                }
                else 
                {
                    this.moduleDescription.text = "";
                }
                this.moduleIcon.setValues(loc1, this.moduleInfo.level);
                this.moduleIcon.extraIconSource = this.moduleInfo[net.wg.data.constants.ValObject.EXTRA_MODULE_INFO];
                this.moduleParams.headerText = this.moduleInfo.parameters.headerText;
                this.moduleParams.setParameters(this.moduleInfo.parameters.params);
                this.moduleEffects.setEffects(this.moduleInfo.effects);
                loc2 = this.moduleParams.y + this.moduleParams.height;
                if (loc1 == net.wg.data.constants.FittingTypes.VEHICLE_GUN) 
                {
                    loc5 = "otherParameters";
                    if (this.moduleInfo.hasOwnProperty(loc5)) 
                    {
                        loc6 = 10;
                        loc8 = new (loc7 = Object(this.moduleParams).constructor)();
                        loc9 = this.moduleInfo[loc5];
                        loc8.y = loc2;
                        loc8.x = this.moduleParams.x;
                        loc8.height = 45;
                        addChild(loc8);
                        this.addedChildren.push(loc8);
                        loc8.headerText = loc9.headerText;
                        loc8.setParameters(loc9.params);
                        loc2 = loc8.y + loc8.actualHeight + loc6;
                    }
                }
                if ((loc3 = this.moduleInfo.compatible.length) > 0) 
                {
                    loc11 = App.utils.classFactory;
                    var loc16:*=0;
                    var loc17:*=this.moduleInfo.compatible;
                    for each (loc10 in loc17) 
                    {
                        (loc12 = loc11.getObject("ModuleCompatibilityMC") as flash.display.MovieClip).x = this.moduleParams.x;
                        loc12.y = loc2;
                        addChild(loc12);
                        this.addedChildren.push(loc12);
                        loc12.header.text = loc10.type;
                        (loc13 = loc12.compValue).htmlText = loc10.value;
                        loc15 = (loc14 = loc13.getLineMetrics(0)).leading + loc14.descent;
                        loc13.height = loc13.textHeight + loc15;
                        loc2 = loc2 + (loc12.height + 15);
                    }
                }
                loc4 = this.moduleEffects.y + this.moduleEffects.height;
                if (loc2 < loc4) 
                {
                    loc2 = loc4;
                }
                this.closeBottomBtn.y = loc2 + 5;
                height = loc2 + this.closeBottomBtn.height + 5;
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            this.closeBottomBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClose);
            window.useBottomBtns = true;
            var loc1:*=window.contentPadding as scaleform.clik.utils.Padding;
            loc1.right = loc1.right + 10;
            window.contentPadding = loc1;
            return;
        }

        protected override function onDispose():void
        {
            var loc1:*=null;
            this._moduleInfo = null;
            this.closeBottomBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onClose);
            var loc2:*=0;
            var loc3:*=this.addedChildren;
            for each (loc1 in loc3) 
            {
                removeChild(loc1);
                if (!(loc1 is scaleform.clik.core.UIComponent)) 
                {
                    continue;
                }
                (loc1 as scaleform.clik.core.UIComponent).dispose();
            }
            this.addedChildren.splice(0);
            this.addedChildren = null;
            super.onDispose();
            return;
        }

        internal function onClose(arg1:scaleform.clik.events.ButtonEvent):void
        {
            onCancelClickS();
            return;
        }

        public function as_setModuleInfo(arg1:Object):void
        {
            window.title = arg1.windowTitle;
            this.moduleInfo = arg1;
            return;
        }

        public var moduleIcon:net.wg.gui.components.advanced.ExtraModuleIcon;

        public var moduleName:flash.text.TextField;

        public var moduleDescription:flash.text.TextField;

        public var moduleParams:net.wg.gui.lobby.moduleInfo.ModuleParameters;

        public var moduleEffects:net.wg.gui.lobby.moduleInfo.ModuleEffects;

        public var closeBottomBtn:net.wg.gui.components.controls.SoundButtonEx;

        internal var addedChildren:Array;

        internal var _moduleInfo:Object;
    }
}
