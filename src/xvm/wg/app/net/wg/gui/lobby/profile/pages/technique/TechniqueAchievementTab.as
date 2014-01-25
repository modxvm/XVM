package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.gui.lobby.profile.components.ResizableContent;
   import net.wg.gui.lobby.profile.components.ResizableScrollPane;
   import flash.text.TextField;
   import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
   import flash.display.MovieClip;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.lobby.profile.pages.awards.AwardsMainContainer;


   public class TechniqueAchievementTab extends ResizableContent
   {
          
      public function TechniqueAchievementTab() {
         super();
      }

      private static function isHasAchievements(param1:Array) : Boolean {
         var _loc2_:Array = null;
         for each (_loc2_ in param1)
         {
            if(_loc2_.length > 0)
            {
               return true;
            }
         }
         return false;
      }

      public var scrollPane:ResizableScrollPane;

      public var warningTextField:TextField;

      private var _data:ProfileVehicleDossierVO;

      public var listBg:MovieClip;

      override protected function configUI() : void {
         super.configUI();
         this.warningTextField.autoSize = TextFieldAutoSize.LEFT;
         this.warningTextField.text = PROFILE.SECTION_TECHNIQUE_AWARDS_NOACHIEVEMENTS;
         this.warningTextField.visible = false;
         this.scrollPane.visible = false;
         this.getPaneContent().gapBetweenBlocks = 6;
      }

      override protected function applyResizing() : void {
         super.applyResizing();
         this.scrollPane.setSize(currentDimension.x - this.scrollPane.x,currentDimension.y - this.scrollPane.y);
         this.listBg.height = currentDimension.y - this.listBg.y;
      }

      override public function update(param1:Object) : void {
         var _loc3_:Array = null;
         var _loc2_:ProfileVehicleDossierVO = ProfileVehicleDossierVO(param1);
         if(this._data != _loc2_)
         {
            this._data = _loc2_;
            _loc3_ = _loc2_.achievementsVOs;
            if(_loc3_)
            {
               if(isHasAchievements(_loc3_))
               {
                  this.warningTextField.visible = false;
                  this.scrollPane.visible = true;
               }
               else
               {
                  this.warningTextField.visible = true;
                  this.scrollPane.visible = false;
               }
            }
            else
            {
               this.warningTextField.visible = false;
               this.scrollPane.visible = false;
            }
            this.getPaneContent().data = _loc3_;
         }
      }

      private function getPaneContent() : AwardsMainContainer {
         return AwardsMainContainer(this.scrollPane.target);
      }

      override protected function onDispose() : void {
         if(this.scrollPane)
         {
            this.scrollPane.dispose();
            this.scrollPane = null;
         }
         super.onDispose();
      }
   }

}