package net.wg.gui.components.windows
{
   import net.wg.infrastructure.base.meta.impl.ModuleInfoMeta;
   import net.wg.infrastructure.base.meta.IModuleInfoMeta;
   import net.wg.gui.components.advanced.ExtraModuleIcon;
   import flash.text.TextField;
   import net.wg.gui.lobby.moduleInfo.ModuleParameters;
   import net.wg.gui.lobby.moduleInfo.ModuleEffects;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.utils.IClassFactory;
   import flash.display.MovieClip;
   import flash.text.TextLineMetrics;
   import net.wg.data.constants.FittingTypes;
   import net.wg.data.constants.ValObject;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   import flash.display.DisplayObject;
   import scaleform.clik.core.UIComponent;


   public class ModuleInfo extends ModuleInfoMeta implements IModuleInfoMeta
   {
          
      public function ModuleInfo() {
         super();
         this.addedChildren = [];
      }

      public var moduleIcon:ExtraModuleIcon;

      public var moduleName:TextField;

      public var moduleDescription:TextField;

      public var moduleParams:ModuleParameters;

      public var moduleEffects:ModuleEffects;

      public var closeBottomBtn:SoundButtonEx;

      private var addedChildren:Array;

      private var _moduleInfo:Object;

      public function get moduleInfo() : Object {
         return this._moduleInfo;
      }

      public function set moduleInfo(param1:Object) : void {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:* = 0;
         var _loc5_:* = NaN;
         var _loc6_:String = null;
         var _loc7_:* = 0;
         var _loc8_:Class = null;
         var _loc9_:ModuleParameters = null;
         var _loc10_:Object = null;
         var _loc11_:Object = null;
         var _loc12_:IClassFactory = null;
         var _loc13_:MovieClip = null;
         var _loc14_:TextField = null;
         var _loc15_:TextLineMetrics = null;
         var _loc16_:* = 0;
         this._moduleInfo = param1;
         if(this.moduleInfo)
         {
            _loc2_ = this.moduleInfo.type;
            this.moduleName.text = this.moduleInfo.name;
            if(_loc2_ == FittingTypes.EQUIPMENT)
            {
               this.moduleDescription.text = "";
            }
            else
            {
               this.moduleDescription.text = this.moduleInfo.description;
            }
            this.moduleIcon.setValues(_loc2_,this.moduleInfo.level);
            this.moduleIcon.extraIconSource = this.moduleInfo[ValObject.EXTRA_MODULE_INFO];
            this.moduleParams.headerText = this.moduleInfo.parameters.headerText;
            this.moduleParams.setParameters(this.moduleInfo.parameters.params);
            this.moduleEffects.setEffects(this.moduleInfo.effects);
            _loc3_ = this.moduleParams.y + this.moduleParams.height;
            if(_loc2_ == FittingTypes.VEHICLE_GUN)
            {
               _loc6_ = "otherParameters";
               if(this.moduleInfo.hasOwnProperty(_loc6_))
               {
                  _loc7_ = 10;
                  _loc8_ = Object(this.moduleParams).constructor;
                  _loc9_ = new _loc8_();
                  _loc10_ = this.moduleInfo[_loc6_];
                  _loc9_.y = _loc3_;
                  _loc9_.x = this.moduleParams.x;
                  _loc9_.height = 45;
                  addChild(_loc9_);
                  this.addedChildren.push(_loc9_);
                  _loc9_.headerText = _loc10_.headerText;
                  _loc9_.setParameters(_loc10_.params);
                  _loc3_ = _loc9_.y + _loc9_.actualHeight + _loc7_;
               }
            }
            _loc4_ = this.moduleInfo.compatible.length;
            if(_loc4_ > 0)
            {
               _loc12_ = App.utils.classFactory;
               for each (_loc11_ in this.moduleInfo.compatible)
               {
                  _loc13_ = _loc12_.getObject("ModuleCompatibilityMC") as MovieClip;
                  _loc13_.x = this.moduleParams.x;
                  _loc13_.y = _loc3_;
                  addChild(_loc13_);
                  this.addedChildren.push(_loc13_);
                  _loc13_.header.text = _loc11_.type;
                  _loc14_ = _loc13_.compValue;
                  _loc14_.htmlText = _loc11_.value;
                  _loc15_ = _loc14_.getLineMetrics(0);
                  _loc16_ = _loc15_.leading + _loc15_.descent;
                  _loc14_.height = _loc14_.textHeight + _loc16_;
                  _loc3_ = _loc3_ + (_loc13_.height + 15);
               }
            }
            _loc5_ = this.moduleEffects.y + this.moduleEffects.height;
            if(_loc3_ < _loc5_)
            {
               _loc3_ = _loc5_;
            }
            this.closeBottomBtn.y = _loc3_ + 5;
            height = _loc3_ + this.closeBottomBtn.height + 5;
         }
      }

      override protected function draw() : void {
         super.draw();
      }

      override protected function onPopulate() : void {
         super.onPopulate();
         this.closeBottomBtn.addEventListener(ButtonEvent.CLICK,this.onClose);
         window.useBottomBtns = true;
         var _loc1_:Padding = window.contentPadding as Padding;
         _loc1_.right = _loc1_.right + 10;
         window.contentPadding = _loc1_;
      }

      override protected function onDispose() : void {
         var _loc1_:DisplayObject = null;
         this._moduleInfo = null;
         this.closeBottomBtn.removeEventListener(ButtonEvent.CLICK,this.onClose);
         for each (_loc1_ in this.addedChildren)
         {
            removeChild(_loc1_);
            if(_loc1_  is  UIComponent)
            {
               (_loc1_ as UIComponent).dispose();
            }
         }
         this.addedChildren.splice(0);
         this.addedChildren = null;
         super.onDispose();
      }

      private function onClose(param1:ButtonEvent) : void {
         onCancelClickS();
      }

      public function as_setModuleInfo(param1:Object) : void {
         window.title = param1.windowTitle;
         this.moduleInfo = param1;
      }
   }

}