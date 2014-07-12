package net.wg.gui.lobby.fortifications
{
   import net.wg.infrastructure.base.meta.impl.FortChoiceDivisionWindowMeta;
   import net.wg.infrastructure.base.meta.IFortChoiceDivisionWindowMeta;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.fortifications.cmp.division.impl.ChoiceDivisionSelector;
   import net.wg.gui.lobby.fortifications.data.FortChoiceDivisionVO;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.constants.InvalidationType;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.fortifications.data.FortChoiceDivisionSelectorVO;
   import scaleform.gfx.TextFieldEx;
   
   public class FortChoiceDivisionWindow extends FortChoiceDivisionWindowMeta implements IFortChoiceDivisionWindowMeta
   {
      
      public function FortChoiceDivisionWindow() {
         super();
         isModal = true;
         isCentered = true;
         canDrag = false;
         this.description.mouseEnabled = false;
         this.selectors = [this.middleDivision,this.championDivision,this.absoluteDivision];
         TextFieldEx.setVerticalAlign(this.description,TextFieldEx.VALIGN_CENTER);
      }
      
      public var description:TextField = null;
      
      public var applyBtn:SoundButtonEx = null;
      
      public var cancelBtn:SoundButtonEx = null;
      
      public var middleDivision:ChoiceDivisionSelector = null;
      
      public var championDivision:ChoiceDivisionSelector = null;
      
      public var absoluteDivision:ChoiceDivisionSelector = null;
      
      private var selectors:Array = null;
      
      private var model:FortChoiceDivisionVO;
      
      private var divisionGroup:ButtonGroup;
      
      override protected function onPopulate() : void {
         super.onPopulate();
         window.useBottomBtns = true;
         App.utils.commons.initTabIndex([this.middleDivision,this.championDivision,this.absoluteDivision,this.applyBtn,this.cancelBtn,window.getCloseBtn()]);
      }
      
      override protected function configUI() : void {
         super.configUI();
         this.applyBtn.addEventListener(ButtonEvent.CLICK,this.onClickApplyBtnHandler);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onClickCancelBtnHandler);
      }
      
      override protected function setData(param1:FortChoiceDivisionVO) : void {
         this.divisionGroup = ButtonGroup.getGroup("divisionGroup",this);
         this.model = param1;
         invalidateData();
      }
      
      override protected function draw() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         var _loc3_:ChoiceDivisionSelector = null;
         super.draw();
         if((isInvalid(InvalidationType.DATA)) && (this.model))
         {
            window.title = this.model.windowTitle;
            this.description.htmlText = this.model.description;
            this.applyBtn.label = this.model.applyBtnLbl;
            this.cancelBtn.label = this.model.cancelBtnLbl;
            if(this.model.selectorsData)
            {
               _loc1_ = this.selectors.length;
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  _loc3_ = ChoiceDivisionSelector(this.selectors[_loc2_]);
                  _loc3_.setData(this.model.selectorsData[_loc2_]);
                  _loc3_.groupName = "divisionGroup";
                  _loc3_.allowDeselect = false;
                  _loc3_.addEventListener(MouseEvent.DOUBLE_CLICK,this.doubleClickHandler);
                  if(!(this.model.autoSelect == Values.DEFAULT_INT) && this.model.autoSelect == FortChoiceDivisionSelectorVO(this.model.selectorsData[_loc2_]).divisionID)
                  {
                     setFocus(this.selectors[_loc2_]);
                  }
                  _loc2_++;
               }
            }
         }
      }
      
      override protected function onDispose() : void {
         var _loc1_:ChoiceDivisionSelector = null;
         App.utils.scheduler.cancelTask(onWindowCloseS);
         this.applyBtn.removeEventListener(ButtonEvent.CLICK,this.onClickApplyBtnHandler);
         this.applyBtn.dispose();
         this.applyBtn = null;
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onClickCancelBtnHandler);
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         for each(_loc1_ in this.selectors)
         {
            _loc1_.removeEventListener(MouseEvent.DOUBLE_CLICK,this.doubleClickHandler);
            _loc1_.dispose();
         }
         this.selectors.splice(0,this.selectors.length);
         this.selectors = null;
         if(this.model)
         {
            this.model.dispose();
         }
         this.model = null;
         this.middleDivision = null;
         this.championDivision = null;
         this.absoluteDivision = null;
         this.divisionGroup.dispose();
         this.divisionGroup = null;
         super.onDispose();
      }
      
      private function getDivisionID() : int {
         return ChoiceDivisionSelector(this.divisionGroup.selectedButton).divisionID;
      }
      
      private function onClickApplyBtnHandler(param1:ButtonEvent) : void {
         selectedDivisionS(this.getDivisionID());
         App.utils.scheduler.envokeInNextFrame(onWindowCloseS);
      }
      
      private function doubleClickHandler(param1:MouseEvent) : void {
         selectedDivisionS(this.getDivisionID());
         App.utils.scheduler.envokeInNextFrame(onWindowCloseS);
      }
      
      private function onClickCancelBtnHandler(param1:ButtonEvent) : void {
         onWindowCloseS();
      }
   }
}
