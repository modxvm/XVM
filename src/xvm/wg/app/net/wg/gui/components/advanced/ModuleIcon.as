package net.wg.gui.components.advanced
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.display.MovieClip;
   import net.wg.data.constants.FittingTypes;


   public class ModuleIcon extends UIComponent
   {
          
      public function ModuleIcon() {
         super();
      }

      public var moduleType:UIComponent;

      public var artefact:UILoaderAlt;

      public var shell:UILoaderAlt;

      public var moduleLevel:MovieClip;

      override public function dispose() : void {
         this.moduleType.dispose();
         this.moduleType = null;
         this.artefact.dispose();
         this.artefact = null;
         this.shell.dispose();
         this.shell = null;
         this.moduleLevel = null;
         super.dispose();
      }

      public function setValues(param1:String, param2:String) : void {
         this.moduleType.visible = this.moduleLevel.visible = FittingTypes.MANDATORY_SLOTS.indexOf(param1) > -1;
         this.artefact.visible = FittingTypes.ARTEFACT_SLOTS.indexOf(param1) > -1;
         this.shell.visible = param1 == FittingTypes.SHELL;
         if(FittingTypes.ARTEFACT_SLOTS.indexOf(param1) > -1)
         {
            this.artefact.source = param2;
         }
         else
         {
            if(param1 == FittingTypes.SHELL)
            {
               this.shell.source = param2;
            }
            else
            {
               this.moduleType.gotoAndPlay(param1);
               this.moduleLevel.gotoAndStop(param2);
            }
         }
      }

      public function setValuesWithType(param1:String, param2:String, param3:int) : void {
         this.moduleType.gotoAndStop(1);
         this.moduleLevel.gotoAndStop(1);
         if(param1 == FittingTypes.MODULE)
         {
            this.artefact.unload();
            this.shell.unload();
            this.moduleType.gotoAndStop(param2);
            this.moduleLevel.visible = true;
            this.moduleLevel.gotoAndStop(param3);
         }
         else
         {
            if(param1 == FittingTypes.SHELL)
            {
               this.artefact.unload();
               this.shell.visible = true;
               this.shell.source = param2;
               this.moduleLevel.visible = false;
            }
            else
            {
               this.shell.unload();
               this.artefact.visible = true;
               this.artefact.source = param2;
               this.moduleLevel.visible = false;
            }
         }
      }
   }

}