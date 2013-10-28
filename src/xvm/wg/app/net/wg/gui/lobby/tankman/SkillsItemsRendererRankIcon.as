package net.wg.gui.lobby.tankman
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.UILoaderAlt;


   public class SkillsItemsRendererRankIcon extends UIComponent
   {
          
      public function SkillsItemsRendererRankIcon() {
         super();
      }

      public var iconRank:UILoaderAlt;

      private var imageUrl:String;

      private var isEnabled:Boolean = true;

      private const UPDATE_DATA:String = "updateData";

      override public function dispose() : void {
         super.dispose();
         this.iconRank.dispose();
      }

      public function setData(param1:String, param2:*) : void {
         this.imageUrl = param1;
         this.isEnabled = param2;
         invalidate(this.UPDATE_DATA);
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(this.UPDATE_DATA))
         {
            if(this.imageUrl)
            {
               this.iconRank.source = this.imageUrl;
            }
            if(enabled != this.isEnabled)
            {
               enabled = this.isEnabled;
            }
         }
      }
   }

}