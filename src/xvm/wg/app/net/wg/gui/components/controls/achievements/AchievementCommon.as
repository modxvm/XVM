package net.wg.gui.components.controls.achievements
{
   import net.wg.data.constants.AchievementSection;
   import net.wg.data.constants.AchievementType;
   import net.wg.gui.events.UILoaderEvent;


   public class AchievementCommon extends AchievementProgress
   {
          
      public function AchievementCommon() {
         super();
      }

      override protected function applyData() : void {
         var _loc8_:* = 0;
         var _loc9_:* = false;
         if(data == null)
         {
            return;
         }
         var _loc1_:String = getDataOwnValue("type","");
         var _loc2_:String = getDataOwnValue("section","");
         var _loc3_:Number = getDataOwnValue("value",NaN);
         var _loc4_:uint = getDataOwnValue("lvlUpTotalValue",0);
         var _loc5_:uint = getDataOwnValue("lvlUpValue",0);
         var _loc6_:uint = _loc4_ - _loc5_;
         var _loc7_:Boolean = getDataOwnValue("isRare",false);
         loader.alpha = 1;
         if(_loc7_)
         {
            hideProgress();
            counterType = AchievementCounter.NONE;
         }
         else
         {
            if(_loc1_)
            {
               switch(_loc1_)
               {
                  case AchievementType.REPEATABLE:
                     switch(_loc2_)
                     {
                        case AchievementSection.SPECIAL:
                           this.checkReceived(_loc3_,AchievementCounter.RED);
                           if(_loc4_ > 0)
                           {
                              this.showProgress();
                           }
                           else
                           {
                              hideProgress();
                           }
                           break;
                        default:
                           this.checkReceived(_loc3_,AchievementCounter.RED);
                           hideProgress();
                     }
                     break;
                  case AchievementType.SERIES:
                     switch(_loc2_)
                     {
                        case AchievementSection.SPECIAL:
                           counterType = AchievementCounter.NONE;
                           this.setRecordRepeatable(AchievementCounter.YELLOW);
                           _loc8_ = getDataOwnValue("minValueForRecord",-1);
                           if(!isNaN(_loc3_) && (_loc6_ / _loc4_ >= 0.9 || !(_loc6_ == 0) && _loc5_ < _loc8_))
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
                     break;
                  case AchievementType.CUSTOM:
                     switch(_loc2_)
                     {
                        case AchievementSection.SPECIAL:
                           counterType = AchievementCounter.NONE;
                           _loc9_ = getDataOwnValue("isInDossier",false);
                           if(_loc9_)
                           {
                              this.showIcon();
                           }
                           else
                           {
                              this.hideIcon();
                           }
                           if(_loc6_ != _loc4_)
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
                     break;
                  case AchievementType.CLASS:
                     switch(_loc2_)
                     {
                        case AchievementSection.CLASS:
                           this.checkReceived(_loc3_,AchievementCounter.BEIGE);
                           counterType = AchievementCounter.BEIGE;
                           if(_loc6_ != _loc4_)
                           {
                              this.showProgress();
                           }
                           else
                           {
                              hideProgress();
                           }
                           break;
                     }
                     break;
                  default:
                     this.showProgress();
               }
            }
         }
         super.applyData();
      }

      override protected function showProgress() : void {
         if(!getDataOwnValue("showProgress",null))
         {
            return;
         }
         super.showProgress();
      }

      override protected function tryToLoadRareAchievement() : void {
         var _loc1_:* = getDataOwnValue("rareIconId",null);
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
         if(getDataOwnValue("isInDossier",false))
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
            this.counterType = param2;
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

      override public function dispose() : void {
         if((counter) && (contains(counter)))
         {
            removeChild(counter);
         }
         super.dispose();
      }
   }

}