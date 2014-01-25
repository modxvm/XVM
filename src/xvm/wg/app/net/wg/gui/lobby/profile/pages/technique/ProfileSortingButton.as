package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.gui.components.advanced.InteractiveSortingButton;
   import flash.text.TextField;
   import net.wg.gui.events.UILoaderEvent;
   import scaleform.gfx.TextFieldEx;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.UILoaderAlt;
   import scaleform.clik.constants.InvalidationType;


   public class ProfileSortingButton extends InteractiveSortingButton
   {
          
      public function ProfileSortingButton() {
         super();
      }

      public var labelField:TextField;

      private var showSeparator:Boolean = true;

      override protected function configUI() : void {
         super.configUI();
         mcDescendingIcon.addEventListener(UILoaderEvent.COMPLETE,this.sortingIconLoadingCompleteHandler);
         TextFieldEx.setVerticalAlign(this.labelField,TextFieldAutoSize.CENTER);
      }

      override protected function sortingIconLoadingCompleteHandler(param1:UILoaderEvent) : void {
         var _loc2_:UILoaderAlt = UILoaderAlt(param1.target);
         if(param1.target == mcAscendingIcon)
         {
            _loc2_.y = Math.round(_height - _loc2_.height);
         }
         _loc2_.x = Math.round((_width - _loc2_.width) / 2);
         isSortIconLoadingCompete = true;
         invalidate();
      }

      override public function set data(param1:Object) : void {
         var _loc2_:ProfileSortingBtnInfo = null;
         super.data = param1;
         if(param1  is  ProfileSortingBtnInfo)
         {
            _loc2_ = ProfileSortingBtnInfo(param1);
            this.showSeparator = _loc2_.showSeparator;
            bg.gotoAndStop(this.showSeparator?"separator":"empty");
            if(_loc2_.label)
            {
               _label = _loc2_.label;
               invalidateData();
            }
         }
      }

      override protected function draw() : void {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(upperBg)
            {
               upperBg.width = this.showSeparator?_width - 2:_width;
               upperBg.height = _height;
            }
            this.labelField.width = _width;
            this.labelField.height = _height;
         }
         if(InvalidationType.DATA)
         {
            if(!(_label == null) && !(_label == "") && !(this.labelField == null))
            {
               this.labelField.text = _label;
            }
            else
            {
               this.labelField.text = "";
            }
         }
      }

      override protected function updateAfterStateChange() : void {
         TextFieldEx.setVerticalAlign(this.labelField,TextFieldAutoSize.CENTER);
         super.updateAfterStateChange();
         this.labelField.width = _width;
         this.labelField.height = _height;
      }
   }

}