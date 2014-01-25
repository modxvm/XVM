package net.wg.gui.lobby.profile.pages.technique
{
   import scaleform.clik.core.UIComponent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.display.MovieClip;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.lobby.profile.components.ResizableViewStack;
   import scaleform.clik.data.DataProvider;
   import flash.geom.Rectangle;
   import scaleform.clik.controls.Button;


   public class TechniqueStackComponent extends UIComponent
   {
          
      public function TechniqueStackComponent() {
         super();
      }

      public var vNameTF:TextField;

      public var typeIcon:UILoaderAlt;

      public var tabsBg:MovieClip;

      public var buttonBar:ButtonBarEx;

      public var viewStack:ResizableViewStack;

      override protected function configUI() : void {
         super.configUI();
         this.viewStack.cache = true;
         this.buttonBar.dataProvider = new DataProvider([
            {
               "label":PROFILE.SECTION_TECHNIQUE_TABBTN_STATISTIC,
               "linkage":"TechniqueStatisticTab_UI",
               "tooltip":PROFILE.SECTION_TECHNIQUE_TABBTN_STATISTIC_TOOLTIP
            }
         ,
            {
               "label":PROFILE.SECTION_TECHNIQUE_TABBTN_ACHIEVEMENTS,
               "linkage":"TechniqueAchievementTab_UI",
               "tooltip":PROFILE.SECTION_TECHNIQUE_TABBTN_AWARDS_TOOLTIP
            }
         ]);
         this.buttonBar.selectedIndex = 1;
         this.buttonBar.selectedIndex = 0;
         this.buttonBar.validateNow();
      }

      override protected function onDispose() : void {
         if(this.buttonBar)
         {
            this.buttonBar.dispose();
            this.buttonBar = null;
         }
         if(this.viewStack)
         {
            this.viewStack.dispose();
            this.viewStack = null;
         }
         if(this.typeIcon)
         {
            this.typeIcon.dispose();
            this.typeIcon = null;
         }
         this.tabsBg = null;
         super.onDispose();
      }

      public function setViewSize(param1:Number, param2:Number) : void {
         this.tabsBg.scrollRect = new Rectangle(0,0,this.tabsBg.width,param2);
         this.viewStack.setAvailableSize(param1 - this.viewStack.x,param2 - this.viewStack.y);
      }

      public function updateLabel(param1:String, param2:String) : void {
         this.vNameTF.text = param1;
         if(param2 != null)
         {
            this.typeIcon.source = param2;
         }
         else
         {
            this.typeIcon.unload();
         }
      }

      public function updateTankData(param1:Object) : void {
         this.viewStack.updateData(param1);
      }

      public function enableAwardsButton(param1:Boolean) : void {
         if(!param1)
         {
            this.buttonBar.selectedIndex = 0;
         }
         var _loc2_:Button = this.buttonBar.getButtonAt(1);
         if(_loc2_)
         {
            _loc2_.enabled = param1;
         }
      }
   }

}