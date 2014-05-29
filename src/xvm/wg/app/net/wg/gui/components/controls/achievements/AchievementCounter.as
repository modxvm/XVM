package net.wg.gui.components.controls.achievements
{
   import net.wg.gui.lobby.battleResults.CustomAchievement;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.Tooltips;
   import net.wg.gui.events.UILoaderEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;


   public class AchievementCounter extends CustomAchievement
   {
          
      public function AchievementCounter() {
         super();
      }

      public static const COUNTER_TYPE_INVALID:String = "cTypeInv";

      public static const COUNTER_VALUE_INVALID:String = "cValueInv";

      public static const LAYOUT_INVALID:String = "layoutInvalid";

      public static const NONE:String = "";

      public static const RED:String = "red";

      public static const GREY:String = "grey";

      public static const YELLOW:String = "yellow";

      public static const BEIGE:String = "beige";

      public static const SMALL:String = "small";

      protected var counter:CounterComponent;

      private var currentCounterClassName:String;

      private var _counterType:String;

      private var _counterValue:String;

      override public function setData(param1:Object) : void {
         super.setData(param1);
         this.applyData();
      }

      public function get counterType() : String {
         return this._counterType;
      }

      public function set counterType(param1:String) : void {
         this._counterType = param1;
         invalidate(COUNTER_TYPE_INVALID);
      }

      public function get counterValue() : String {
         return this._counterValue;
      }

      public function set counterValue(param1:String) : void {
         this._counterValue = param1;
         invalidate(COUNTER_VALUE_INVALID);
      }

      override protected function configUI() : void {
         super.configUI();
         loader.mouseChildren = false;
         loader.buttonMode = false;
         this.buttonMode = false;
      }

      override protected function draw() : void {
         var _loc1_:String = null;
         super.draw();
         if(isInvalid(COUNTER_TYPE_INVALID))
         {
            if(this._counterType == GREY)
            {
               _loc1_ = "GreyCounter_UI";
            }
            else
            {
               if(this._counterType == YELLOW)
               {
                  _loc1_ = "YellowCounter_UI";
               }
               else
               {
                  if(this._counterType == RED)
                  {
                     _loc1_ = "RedCounter_UI";
                  }
                  else
                  {
                     if(this._counterType == BEIGE)
                     {
                        _loc1_ = "BeigeCounter_UI";
                     }
                     else
                     {
                        if(this._counterType == SMALL)
                        {
                           _loc1_ = "SmallCounter_UI";
                        }
                     }
                  }
               }
            }
            if(this.currentCounterClassName != _loc1_)
            {
               this.currentCounterClassName = _loc1_;
               if(this.counter)
               {
                  this.counter.parent.removeChild(this.counter);
                  this.counter = null;
               }
               if((_loc1_) && !(_loc1_ == ""))
               {
                  if(App.utils)
                  {
                     this.counter = App.utils.classFactory.getComponent(_loc1_,CounterComponent);
                  }
                  else
                  {
                     this.counter = getDefinitionByName(_loc1_) as CounterComponent;
                  }
                  invalidate(LAYOUT_INVALID);
               }
            }
         }
         if((isInvalid(COUNTER_VALUE_INVALID)) && (this.counter))
         {
            this.counter.text = data.hasOwnProperty("localizedValue")?data.localizedValue:"0";
            this.counter.validateNow();
            invalidate(LAYOUT_INVALID);
         }
         if(isInvalid(LAYOUT_INVALID))
         {
            this.applyLayoutChanges();
         }
      }

      override protected function onDispose() : void {
         if((this.counter) && (contains(this.counter)))
         {
            removeChild(this.counter);
         }
         super.onDispose();
      }

      protected function applyLayoutChanges() : void {
         if((this.counter) && (!(loader.width == 0)) && !(loader.height == 0))
         {
            this.counter.x = loader.x + loader.originalWidth - this.counter.actualWidth ^ 0;
            this.counter.y = loader.y + loader.originalHeight - this.counter.actualHeight - this.counter.receiveBottomPadding() ^ 0;
            addChild(this.counter);
         }
      }

      protected function applyData() : void {
         if(data)
         {
            if(data.hasOwnProperty("counterType"))
            {
               this.counterType = data["counterType"];
            }
         }
      }

      protected function showToolTip() : void {
         if(data)
         {
            if(data.name == "markOfMastery")
            {
               App.toolTipMgr.showSpecial(Tooltips.TANK_CLASS,null,data.block,data.name,data.value);
            }
            else
            {
               if(data.name == "marksOnGun")
               {
                  App.toolTipMgr.showSpecial(Tooltips.MARKS_ON_GUN_ACHIEVEMENT,null,data.dossierType,data.dossierCompDescr,data.block,data.name,data.isRare,data.isDossierForCurrentUser);
               }
               else
               {
                  App.toolTipMgr.showSpecial(Tooltips.ACHIEVEMENT,null,data.dossierType,data.dossierCompDescr,data.block,data.name,data.isRare,data.isDossierForCurrentUser);
               }
            }
         }
      }

      override protected function onComplete(param1:UILoaderEvent) : void {
         super.onComplete(param1);
         invalidate(LAYOUT_INVALID);
      }

      override protected function handleStageChange(param1:Event) : void {
         if(param1.type == Event.ADDED_TO_STAGE)
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.handleStageChange,false);
            addEventListener(Event.RENDER,validateNow,false,0,true);
            addEventListener(Event.ENTER_FRAME,handleEnterFrameValidation,false,0,true);
            if(stage != null)
            {
               stage.invalidate();
            }
         }
      }

      override protected function handleMouseRollOver(param1:MouseEvent) : void {
         super.handleMouseRollOver(param1);
         this.showToolTip();
      }

      override protected function handleMouseRollOut(param1:MouseEvent) : void {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
      }
   }

}