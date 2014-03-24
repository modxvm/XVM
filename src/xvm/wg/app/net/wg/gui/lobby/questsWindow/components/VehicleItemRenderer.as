package net.wg.gui.lobby.questsWindow.components
{
   import scaleform.clik.controls.ListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.lobby.questsWindow.data.QuestVehicleRendererVO;
   import net.wg.data.VO.ProgressElementVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ComponentEvent;


   public class VehicleItemRenderer extends ListItemRenderer
   {
          
      public function VehicleItemRenderer() {
         this.nations = [];
         super();
         this.levelMC.visible = false;
         this.nations = App.utils.getNationNamesS();
      }

      private static const SEPARATOR_PADDING:int = 2;

      public var nationIcon:UILoaderAlt;

      public var typeIcon:UILoaderAlt;

      public var levelMC:MovieClip;

      public var tankSmallIcon:UILoaderAlt;

      public var vehTF:TextField;

      public var htmlTF:TextField;

      public var progress:ProgressQuestIndicator;

      public var naMC:MovieClip;

      public var disableMc:BitmapFill;

      public var noVehicle:TextField;

      private var nations:Array;

      private var isDisabled:Boolean = false;

      override protected function configUI() : void {
         super.configUI();
         this.nationIcon.hideLoader = false;
         this.typeIcon.hideLoader = false;
         this.tankSmallIcon.hideLoader = false;
         this.disableMc.widthFill = Math.round(this.width);
         this.disableMc.heightFill = Math.round(this.height);
         this.setNoData();
         this.noVehicle.text = QUESTS.QUESTS_TABLE_NOVEHICLES;
      }

      override public function setData(param1:Object) : void {
         this.data = param1;
         invalidateData();
      }

      override protected function draw() : void {
         var _loc1_:QuestVehicleRendererVO = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:ProgressElementVO = null;
         if(isInvalid(InvalidationType.STATE))
         {
            if(_newFrame)
            {
               gotoAndPlay(_newFrame);
               if(_baseDisposed)
               {
                  return;
               }
               _newFrame = null;
            }
            if((focusIndicator) && (_newFocusIndicatorFrame))
            {
               focusIndicator.gotoAndPlay(_newFocusIndicatorFrame);
               _newFocusIndicatorFrame = null;
            }
            updateAfterStateChange();
            dispatchEvent(new ComponentEvent(ComponentEvent.STATE_CHANGE));
            invalidate(InvalidationType.DATA,InvalidationType.SIZE);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            if(data)
            {
               _loc1_ = QuestVehicleRendererVO(data);
               this.resetVisible();
               _loc2_ = this.getNationIconPath(_loc1_.nationID);
               _loc3_ = this.getTypeIconPath(_loc1_.vType);
               if(this.nationIcon.source != _loc2_)
               {
                  this.nationIcon.source = _loc2_;
               }
               if(this.typeIcon.source != _loc3_)
               {
                  this.typeIcon.source = _loc3_;
               }
               if(this.tankSmallIcon.source != _loc1_.vIconSmall)
               {
                  this.tankSmallIcon.source = _loc1_.vIconSmall;
               }
               this.vehTF.htmlText = _loc1_.vName;
               this.htmlTF.htmlText = _loc1_.htmlLabel;
               this.levelMC.gotoAndStop(_loc1_.vLevel);
               this.progress.visible = Boolean(_loc1_.progressData);
               this.naMC.visible = !_loc1_.isAvailable;
               this.isDisabled = _loc1_.isDisabled;
               if(_loc1_.progressData)
               {
                  _loc4_ = ProgressElementVO(_loc1_.progressData);
                  this.progress.setValues(_loc4_.progrBarType,_loc4_.currentProgrVal,_loc4_.maxProgrVal);
                  this.progress.setTooltip(_loc4_.progrTooltip);
               }
            }
            else
            {
               this.setNoData();
            }
            this.updateDisable();
         }
      }

      private function setNoData() : void {
         this.nationIcon.visible = false;
         this.typeIcon.visible = false;
         this.levelMC.visible = false;
         this.tankSmallIcon.visible = false;
         this.vehTF.visible = false;
         this.htmlTF.visible = false;
         this.progress.visible = false;
         this.naMC.visible = false;
         this.noVehicle.visible = true;
         this.isDisabled = false;
      }

      private function resetVisible() : void {
         this.nationIcon.visible = true;
         this.typeIcon.visible = true;
         this.levelMC.visible = true;
         this.tankSmallIcon.visible = true;
         this.vehTF.visible = true;
         this.htmlTF.visible = true;
         this.noVehicle.visible = false;
         this.levelMC.visible = true;
      }

      public function getNationIconPath(param1:int) : String {
         return "../maps/icons/filters/nations/" + this.nations[param1] + ".png";
      }

      public function getTypeIconPath(param1:String) : String {
         return "../maps/icons/filters/tanks/" + param1 + ".png";
      }

      override protected function onDispose() : void {
         this.disableMc.dispose();
         this.disableMc = null;
         if(this.nationIcon)
         {
            this.nationIcon.dispose();
            removeChild(this.nationIcon);
            this.nationIcon = null;
         }
         if(this.typeIcon)
         {
            this.typeIcon.dispose();
            removeChild(this.typeIcon);
            this.typeIcon = null;
         }
         removeChild(this.levelMC);
         this.levelMC = null;
         if(this.tankSmallIcon)
         {
            this.tankSmallIcon.dispose();
            removeChild(this.tankSmallIcon);
            this.tankSmallIcon = null;
         }
         if(this.nations)
         {
            this.nations.splice(0,this.nations.length);
            this.nations = null;
         }
         if(this.vehTF)
         {
            removeChild(this.vehTF);
            this.vehTF = null;
         }
         data = null;
         super.onDispose();
      }

      protected function updateDisable() : void {
         if(this.disableMc != null)
         {
            this.disableMc.visible = this.isDisabled;
            this.disableMc.scaleX = 1 / this.scaleX;
            this.disableMc.scaleY = 1 / this.scaleY;
            this.disableMc.widthFill = Math.round(this.width * this.scaleX);
            this.disableMc.heightFill = Math.round(this.height * this.scaleY) - SEPARATOR_PADDING;
         }
      }
   }

}