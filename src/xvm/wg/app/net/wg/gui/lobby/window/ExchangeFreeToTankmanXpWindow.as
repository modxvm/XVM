package net.wg.gui.lobby.window
{
   import net.wg.infrastructure.base.meta.impl.ExchangeFreeToTankmanXpWindowMeta;
   import net.wg.infrastructure.base.meta.IExchangeFreeToTankmanXpWindowMeta;
   import net.wg.gui.components.controls.NumericStepper;
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.IconText;
   import flash.display.Sprite;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.advanced.SkillsItemRenderer;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.IWindow;
   import flash.events.Event;
   import scaleform.clik.utils.Constraints;
   import scaleform.clik.constants.ConstrainMode;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;


   public class ExchangeFreeToTankmanXpWindow extends ExchangeFreeToTankmanXpWindowMeta implements IExchangeFreeToTankmanXpWindowMeta
   {
          
      public function ExchangeFreeToTankmanXpWindow() {
         super();
         isModal = false;
         canResize = false;
         canMinimize = false;
         isCentered = true;
         showWindowBg = false;
      }

      public static const INIT_DATA_INVALID:String = "initDataInv";

      public static const SELECTED_VALUE_INVALID:String = "selValInvalid";

      public static const WARNING_INVALID:String = "warningInvalid";

      private static const MOVINGCONTAINER_NAME:String = "movingContainer";

      public var nsLevel:NumericStepper;

      public var form_bg:MovieClip;

      public var itToPay:IconText;

      public var background:Sprite;

      public var warningMc:ExchangeFreeToTankmanXpWarning;

      public var submitBtn:SoundButtonEx;

      public var cancelBtn:SoundButtonEx;

      public var skillAfter:SkillsItemRenderer;

      public var skillBefore:SkillsItemRenderer;

      public var afterTeachingHeader:TextField;

      public var blockMc:MovieClip;

      private var initData:ExchangeFreeToTankmanInitVO;

      private var selectedValue:uint;

      private var originalWindowHeight:Number = NaN;

      private var expandedWindowHeight:Number = NaN;

      public function as_setInitData(param1:Object) : void {
         this.initData = new ExchangeFreeToTankmanInitVO(param1);
         invalidate(INIT_DATA_INVALID);
      }

      public function as_setCalcValueResponse(param1:Number) : void {
         this.itToPay.text = App.utils.locale.integer(param1);
         this.submitBtn.enabled = param1 > 0;
         this.initData.afterSkill.level = this.selectedValue;
         this.skillAfter.data = this.initData.afterSkill;
      }

      override public function set window(param1:IWindow) : void {
         super.window = param1;
         if(param1)
         {
            window.title = MENU.TEACHINGSKILL_TITLE;
            addEventListener(Event.ENTER_FRAME,this.calcHeightInNextFrame,false,0,true);
         }
      }

      override protected function preInitialize() : void {
         super.preInitialize();
         constraints = new Constraints(this,ConstrainMode.REFLOW);
      }

      override protected function configUI() : void {
         super.configUI();
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onClickSubmitButton,false,0,true);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onClickCancelButton,false,0,true);
         this.nsLevel.addEventListener(IndexEvent.INDEX_CHANGE,this.nsFirstCurrencyChangeHandler,false,0,true);
         try
         {
            this.warningMc.textField.text = App.utils.locale.makeString(MENU.TEACHINGSKILL_FREEXPISTIGHT);
         }
         catch(e:Error)
         {
         }
         this.warningMc.visible = false;
         this.blockMc.visible = false;
         var _loc1_:int = this.background.parent.getChildIndex(this.background) + 1;
         var _loc2_:Sprite = new Sprite();
         addChildAt(_loc2_,_loc1_);
         _loc2_.addChild(this.afterTeachingHeader);
         _loc2_.addChild(this.skillAfter);
         _loc2_.addChild(this.submitBtn);
         _loc2_.addChild(this.cancelBtn);
         constraints.addElement(this.background.name,this.background,Constraints.ALL);
         constraints.addElement(this.form_bg.name,this.form_bg,Constraints.ALL);
         constraints.addElement(MOVINGCONTAINER_NAME,_loc2_,Constraints.BOTTOM);
      }

      override protected function draw() : void {
         var _loc1_:* = false;
         super.draw();
         if(isInvalid(INIT_DATA_INVALID))
         {
            if(this.initData)
            {
               this.nsLevel.minimum = this.initData.lastSkillLevel;
               this.nsLevel.maximum = this.initData.nextSkillLevel;
               this.nsLevel.value = this.nsLevel.maximum;
               this.nsLevel.enabled = !(this.initData.lastSkillLevel == this.initData.nextSkillLevel);
               this.blockMc.visible = !this.nsLevel.enabled;
               this.skillBefore.data = this.initData.beforeSkill;
               this.skillAfter.data = this.initData.afterSkill;
               this.selectedValue = this.nsLevel.value;
               invalidate(SELECTED_VALUE_INVALID);
               invalidate(WARNING_INVALID);
            }
         }
         if(isInvalid(SELECTED_VALUE_INVALID))
         {
            if(this.initData)
            {
               calcValueRequestS(this.selectedValue);
            }
         }
         if((isInvalid(WARNING_INVALID)) && !isNaN(this.originalWindowHeight))
         {
            _loc1_ = !this.nsLevel.enabled;
            if(_loc1_ != this.warningMc.visible)
            {
               this.warningMc.visible = _loc1_;
               if(_loc1_)
               {
                  window.height = this.expandedWindowHeight;
               }
               else
               {
                  window.height = this.originalWindowHeight;
               }
            }
         }
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onClickSubmitButton,false,0,true);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onClickCancelButton,false,0,true);
         removeEventListener(Event.ENTER_FRAME,this.calcHeightInNextFrame);
         this.submitBtn.dispose();
         this.submitBtn = null;
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.nsLevel.dispose();
         this.nsLevel = null;
         this.skillAfter.dispose();
         this.skillAfter = null;
         this.skillBefore.dispose();
         this.skillBefore = null;
      }

      private function nsFirstCurrencyChangeHandler(param1:IndexEvent) : void {
         this.selectedValue = this.nsLevel.value;
         invalidate(SELECTED_VALUE_INVALID);
      }

      private function calcHeightInNextFrame(param1:Event) : void {
         removeEventListener(Event.ENTER_FRAME,this.calcHeightInNextFrame);
         this.originalWindowHeight = window.height;
         this.expandedWindowHeight = this.originalWindowHeight + this.warningMc.height - 30;
         invalidate(WARNING_INVALID);
      }

      private function onClickSubmitButton(param1:ButtonEvent) : void {
         applyS();
      }

      private function onClickCancelButton(param1:ButtonEvent) : void {
         onWindowCloseS();
      }
   }

}