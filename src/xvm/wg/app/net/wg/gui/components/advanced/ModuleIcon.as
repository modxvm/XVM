package net.wg.gui.components.advanced 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class ModuleIcon extends scaleform.clik.core.UIComponent
    {
        public function ModuleIcon()
        {
            super();
            return;
        }

        public function setValues(arg1:String, arg2:String):void
        {
            var loc1:*;
            this.moduleLevel.visible = loc1 = net.wg.data.constants.FittingTypes.MANDATORY_SLOTS.indexOf(arg1) > -1;
            this.moduleType.visible = loc1;
            this.artefact.visible = net.wg.data.constants.FittingTypes.ARTEFACT_SLOTS.indexOf(arg1) > -1;
            this.shell.visible = arg1 == net.wg.data.constants.FittingTypes.SHELL;
            if (net.wg.data.constants.FittingTypes.ARTEFACT_SLOTS.indexOf(arg1) > -1) 
            {
                this.artefact.source = arg2;
            }
            else if (arg1 != net.wg.data.constants.FittingTypes.SHELL) 
            {
                this.moduleType.gotoAndPlay(arg1);
                this.moduleLevel.gotoAndStop(arg2);
            }
            else 
            {
                this.shell.source = arg2;
            }
            return;
        }

        public function setValuesWithType(arg1:String, arg2:String, arg3:int):void
        {
            this.moduleType.gotoAndStop(1);
            this.moduleLevel.gotoAndStop(1);
            if (arg1 != net.wg.data.constants.FittingTypes.MODULE) 
            {
                if (arg1 != net.wg.data.constants.FittingTypes.SHELL) 
                {
                    this.shell.unload();
                    this.artefact.visible = true;
                    this.artefact.source = arg2;
                    this.moduleLevel.visible = false;
                }
                else 
                {
                    this.artefact.unload();
                    this.shell.visible = true;
                    this.shell.source = arg2;
                    this.moduleLevel.visible = false;
                }
            }
            else 
            {
                this.artefact.unload();
                this.shell.unload();
                this.moduleType.gotoAndStop(arg2);
                this.moduleLevel.gotoAndStop(arg3);
            }
            return;
        }

        public var moduleType:flash.display.MovieClip;

        public var artefact:net.wg.gui.components.controls.UILoaderAlt;

        public var shell:net.wg.gui.components.controls.UILoaderAlt;

        public var moduleLevel:flash.display.MovieClip;
    }
}
