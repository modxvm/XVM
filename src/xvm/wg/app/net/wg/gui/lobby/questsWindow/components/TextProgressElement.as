package net.wg.gui.lobby.questsWindow.components
{
   import flash.text.TextField;
   import net.wg.data.VO.ProgressElementVO;
   import net.wg.data.constants.QuestsStates;
   import flash.text.TextFieldAutoSize;
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
      
      public var statusMC:QuestStatusComponent;
      
      override protected function configUI() : void {
         super.configUI();
         this.description.width = DEFAULT_WIDTH;
         this.indexTF.visible = false;
         this.statusMC.setStatus(QuestsStates.DONE);
         this.statusMC.textAlign = TextFieldAutoSize.RIGHT;
         this.statusMC.showTooltip = false;
         this.statusMC.validateNow();
         this.statusMC.visible = false;
      }
      
      override protected function onDispose() : void {
         this.description = null;
         this.indexTF = null;
         this.progress.dispose();
         this.progress = null;
         this.statusMC.dispose();
         this.statusMC = null;
         if(this.data)
         {
            this.data.dispose();
            this.data = null;
         }
         super.onDispose();
      }
      
      override public function setData(param1:Object) : void {
         if(this.data)
         {
            this.data.dispose();
         }
         this.data = new ProgressElementVO(param1);
         invalidateData();
      }
      
      override protected function draw() : void {
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.data))
         {
            this.description.htmlText = this.data.description;
            this.statusMC.visible = this.data.showDone;
            if(this.data.progrIndex)
            {
               this.indexTF.text = this.data.progrIndex.toString();
               this.indexTF.visible = true;
               this.description.x = Math.round(this.indexTF.width);
            }
            if((this.data.progrBarType) && !this.data.showDone)
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
         this.description.height = this.description.textHeight + PADDING;
         this.setSize(this.width,this.description.height);
         isReadyForLayout = true;
      }
   }
}
