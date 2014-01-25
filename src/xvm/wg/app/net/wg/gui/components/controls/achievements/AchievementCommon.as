package net.wg.gui.components.controls.achievements
{
   import net.wg.data.constants.AchievementType;
   import net.wg.data.constants.AchievementSection;
   import net.wg.gui.events.UILoaderEvent;


   public class AchievementCommon extends AchievementProgress
   {
          
      public function AchievementCommon() {
         super();
      }

      private static const MIN_PROGRESS_PERCENT:Number = 0.9;

      override protected function applyData() : void {
         var _loc1_:String = null;
         if(data == null)
         {
            return;
         }
         _loc1_ = getDataOwnValue(data,"type","");
         var _loc2_:String = getDataOwnValue(data,"section","");
         var _loc3_:Number = getDataOwnValue(data,"value",NaN);
         var _loc4_:uint = getDataOwnValue(data,"lvlUpTotalValue",0);
         var _loc5_:uint = getDataOwnValue(data,"lvlUpValue",0);
         var _loc6_:uint = _loc4_ - _loc5_;
         loader.alpha = 1;
         if(_loc1_)
         {
            switch(_loc1_)
            {
               case AchievementType.REPEATABLE:
                  this.adjustRepeatableType(_loc2_,_loc3_,_loc4_);
                  break;
               case AchievementType.SERIES:
                  this.adjustSpecialType(_loc2_,_loc3_,_loc4_,_loc6_,_loc5_);
                  break;
               case AchievementType.CUSTOM:
                  this.adjustCustomType(_loc2_,_loc4_,_loc6_);
                  break;
               case AchievementType.CLASS:
                  this.adjustClassType(_loc2_,_loc3_,_loc4_,_loc6_);
                  break;
               case AchievementType.SINGLE:
                  this.adjustSingleType(_loc3_);
                  break;
               default:
                  this.checkReceived(_loc3_,AchievementCounter.NONE);
                  hideProgress();
            }
         }
         super.applyData();
      }

      private function adjustClassType(param1:String, param2:Number, param3:Number, param4:Number) : void {
         switch(param1)
         {
            case AchievementSection.CLASS:
               this.checkReceived(param2,AchievementCounter.BEIGE);
               counterType = AchievementCounter.BEIGE;
               if(param4 != param3)
               {
                  this.showProgress();
               }
               else
               {
                  hideProgress();
               }
               break;
         }
      }

      private function adjustSingleType(param1:Number) : void {
         this.checkReceived(param1,AchievementCounter.NONE);
         hideProgress();
      }

      private function adjustCustomType(param1:String, param2:Number, param3:Number) : void {
         var _loc4_:* = false;
         switch(param1)
         {
            case AchievementSection.SPECIAL:
               counterType = AchievementCounter.NONE;
               _loc4_ = getDataOwnValue(data,"isInDossier",false);
               if(_loc4_)
               {
                  this.showIcon();
               }
               else
               {
                  this.hideIcon();
               }
               if(param3 != param2)
               {
                  this.showProgress();
               }
               else
               {
                  hideProgress();
               }
               break;
            default:
               this.showProgress();
         }
      }

      private function adjustRepeatableType(param1:String, param2:Number, param3:Number) : void {
         switch(param1)
         {
            case AchievementSection.SPECIAL:
               this.checkReceived(param2,AchievementCounter.RED);
               if(param3 > 0)
               {
                  this.showProgress();
               }
               else
               {
                  hideProgress();
               }
               break;
            case AchievementSection.ACTION:
               this.checkReceived(param2,AchievementCounter.RED);
               hideProgress();
               break;
            default:
               this.checkReceived(param2,AchievementCounter.RED);
               hideProgress();
         }
      }

      private function adjustSpecialType(param1:String, param2:Number, param3:Number, param4:Number, param5:Number) : void {
         var _loc6_:* = 0;
         switch(param1)
         {
            case AchievementSection.SPECIAL:
               counterType = AchievementCounter.NONE;
               this.setRecordRepeatable(AchievementCounter.YELLOW);
               _loc6_ = getDataOwnValue(data,"minValueForRecord",-1);
               if(!isNaN(param2) && (param4 / param3 >= MIN_PROGRESS_PERCENT || !(param4 == 0) && param5 < _loc6_))
               {
                  this.showProgress();
               }
               else
               {
                  hideProgress();
               }
               break;
            default:
               this.setRecordRepeatable(AchievementCounter.YELLOW);
               hideProgress();
         }
      }

      override protected function showProgress() : void {
         if(!getDataOwnValue(data,"showProgress",null))
         {
            return;
         }
         super.showProgress();
      }

      override protected function tryToLoadRareAchievement() : void {
         var _loc1_:* = getDataOwnValue(data,"rareIconId",null);
         if(_loc1_)
         {
            loader.source = "img://" + _loc1_;
            loader.addEventListener(UILoaderEvent.COMPLETE,this.onComplete);
         }
         else
         {
            loader.startLoadAlt();
            dispatchEvent(new AchievementEvent(AchievementEvent.REQUEST_RARE_ACHIEVEMENT,true));
         }
      }

      override protected function onComplete(param1:UILoaderEvent) : void {
         super.onComplete(param1);
      }

      protected function setRecordRepeatable(param1:String) : void {
         if(getDataOwnValue(data,"isInDossier",false))
         {
            this.showIcon();
         }
         else
         {
            this.hideIcon();
         }
         this.counterType = param1;
      }

      protected function checkReceived(param1:Number, param2:String) : void {
         if(param1 <= 0)
         {
            counterType = AchievementCounter.NONE;
            this.hideIcon();
         }
         else
         {
            counterType = param2;
            this.showIcon();
         }
         hideProgress();
      }

      private function hideIcon() : void {
         loader.alpha = 0.2;
      }

      private function showIcon() : void {
         loader.alpha = 1;
      }

      override protected function onDispose() : void {
         if((counter) && (contains(counter)))
         {
            removeChild(counter);
         }
         super.onDispose();
      }
   }

}