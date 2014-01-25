package net.wg.gui.lobby.questsWindow.components
{
   import flash.text.TextField;
   import net.wg.data.VO.ProgressElementVO;
   import scaleform.clik.constants.InvalidationType;


   public class TextProgressElement extends AbstractResizableContent
   {
          
      public function TextProgressElement() {
         super();
      }

      private static const PADDING:int = 5;

      private static const RIGHT_PADDING:int = 55;

      private static const DEFAULT_WIDTH:int = 250;

      public var description:TextField;

      public var progress:ProgressQuestIndicator;

      public var indexTF:TextField;

      public var data:ProgressElementVO = null;

      override protected function configUI() : void {
         super.configUI();
         this.description.width = DEFAULT_WIDTH;
         this.indexTF.visible = false;
      }

      override protected function onDispose() : void {
         this.description = null;
         this.indexTF = null;
         this.progress.dispose();
         this.progress = null;
         if(this.data)
         {
            this.data.dispose();
            this.data = null;
         }
         super.onDispose();
      }

      override public function setData(param1:Object) : void {
         this.data = new ProgressElementVO(param1);
         invalidateData();
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.data))
         {
            this.description.htmlText = this.data.description;
            if(this.data.progrIndex)
            {
               this.indexTF.text = this.data.progrIndex.toString();
               this.indexTF.visible = true;
               this.description.x = Math.round(this.indexTF.width);
            }
            this.description.height = this.description.textHeight + PADDING;
            if(this.data.progrBarType)
            {
               this.progress.visible = true;
               this.progress.setValues(this.data.progrBarType,this.data.currentProgrVal,this.data.maxProgrVal);
            }
            else
            {
               this.description.width = availableWidth - this.description.x - RIGHT_PADDING;
               this.progress.visible = false;
            }
            this.layoutComponents();
         }
      }

      private function layoutComponents() : void {
         this.setSize(this.width,this.description.textHeight + PADDING);
         isReadyForLayout = true;
      }
   }

}