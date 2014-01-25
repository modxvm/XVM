package net.wg.gui.lobby.settings
{
   import net.wg.infrastructure.base.meta.impl.SettingsWindowMeta;
   import net.wg.infrastructure.base.meta.ISettingsWindowMeta;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import flash.display.Sprite;
   import net.wg.gui.components.advanced.ViewStack;
   import net.wg.gui.components.controls.SoundButtonEx;
   import scaleform.clik.controls.ScrollingList;
   import net.wg.gui.components.controls.DropDownListItemRendererSound;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.utils.Padding;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.utils.ICommons;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.lobby.settings.evnts.SettingViewEvent;
   import net.wg.gui.lobby.settings.evnts.AlternativeVoiceEvent;
   import net.wg.gui.lobby.settings.vo.SettingsKeyProp;
   import flash.display.MovieClip;
   import scaleform.clik.interfaces.IDataProvider;
   import net.wg.data.constants.KeysMap;
   import net.wg.infrastructure.interfaces.ISettingsBase;
   import flash.geom.Point;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.data.constants.Tooltips;
   import net.wg.gui.components.tooltips.helpers.Utils;


   public class SettingsWindow extends SettingsWindowMeta implements ISettingsWindowMeta
   {
          
      public function SettingsWindow() {
         super();
         this.canDrag = false;
         this.canClose = false;
         this.canResize = false;
         this.showWindowBg = false;
         this.isModal = true;
         this.isCentered = true;
      }

      private static var __currentTab:Number = 0;

      public var tabs:ButtonBarEx = null;

      public var tabLine:Sprite = null;

      public var view:ViewStack = null;

      public var submitBtn:SoundButtonEx = null;

      public var cancelBtn:SoundButtonEx = null;

      public var applyBtn:SoundButtonEx = null;

      public var ddMenu_ScrollingList:ScrollingList = null;

      public var ddListItemRendererSound:DropDownListItemRendererSound = null;

      private var _settingsData:Object = null;

      private var changesData:SettingsChangesMap = null;

      private const CONTROLS_WARNING:String = "controlsWrongNotification";

      private const SOUND_MODE_WARNING:String = "soundModeInvalid";

      override public function updateStage(param1:Number, param2:Number) : void {
         super.updateStage(param1,param2);
      }

      override public function setWindow(param1:IWindow) : void {
         var _loc2_:Padding = null;
         super.setWindow(param1);
         if(window)
         {
            window.title = SETTINGS.TITLE;
            _loc2_ = new Padding();
            _loc2_.top = 35;
            _loc2_.right = 13;
            _loc2_.bottom = 19;
            _loc2_.left = 10;
            window.contentPadding = _loc2_;
         }
      }

      public function as_setCaptureDevices(param1:Number, param2:Array) : void {
         var _loc3_:SoundSettings = SoundSettings(this.tryGetView(SettingsConfig.SOUND_SETTINGS));
         if(_loc3_ != null)
         {
            _loc3_.setCaptureDevices(param1,param2);
         }
      }

      public function as_onVibroManagerConnect(param1:Boolean) : void {
         SettingsControlProp(SettingsConfig.settingsData[SettingsConfig.GAME_SETTINGS].vibroIsConnected).current = param1;
         var _loc2_:GameSettings = GameSettings(this.tryGetView(SettingsConfig.GAME_SETTINGS));
         if(_loc2_ != null)
         {
            _loc2_.onVibroManagerConnect();
         }
      }

      public function as_updateVideoSettings(param1:Object) : void {
         var _loc4_:uint = 0;
         var _loc5_:ICommons = null;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:SettingsControlProp = null;
         var _loc2_:* = false;
         if(param1)
         {
            _loc4_ = SettingsConfig.liveUpdateVideoSettingsOrderData.length;
            _loc5_ = App.utils.commons;
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc2_ = false;
               _loc7_ = SettingsConfig.liveUpdateVideoSettingsOrderData[_loc6_];
               if(param1[_loc7_] != null)
               {
                  _loc8_ = new SettingsControlProp();
                  if(param1[_loc7_]  is  Boolean || param1[_loc7_]  is  String || param1[_loc7_]  is  Number)
                  {
                     _loc8_.current = param1[_loc7_];
                     _loc2_ = true;
                  }
                  else
                  {
                     if(param1[_loc7_].current  is  Object && !(param1[_loc7_].current == undefined))
                     {
                        _loc8_.current = param1[_loc7_].real != null?param1[_loc7_].real:param1[_loc7_].current;
                     }
                     if(param1[_loc7_].options != undefined)
                     {
                        _loc8_.options = _loc5_.cloneObject(param1[_loc7_].options);
                        _loc2_ = true;
                     }
                     else
                     {
                        _loc8_.options = [];
                     }
                  }
               }
               if(_loc2_)
               {
                  SettingsConfig.liveUpdateVideoSettingsData[_loc7_] = _loc8_;
               }
               _loc6_++;
            }
         }
         var _loc3_:GraphicSettings = GraphicSettings(this.tryGetView(SettingsConfig.GRAPHIC_SETTINGS));
         if(_loc3_)
         {
            _loc3_.updateDependentData();
         }
      }

      public function as_confirmWarningDialog(param1:Boolean, param2:String) : void {
         var _loc3_:Object = null;
         var _loc4_:SettingsControlProp = null;
         var _loc5_:SoundSettings = null;
         var _loc6_:* = NaN;
         this.updateSettingsConfig(param1);
         if(param1)
         {
            if(param2.indexOf(this.SOUND_MODE_WARNING,0) >= 0)
            {
               _loc3_ = SettingsConfig.settingsData[SettingsConfig.SOUND_SETTINGS];
               _loc4_ = SettingsControlProp(_loc3_["alternativeVoices"]);
               _loc4_.current = 0;
               _loc5_ = SoundSettings(this.tryGetView(SettingsConfig.SOUND_SETTINGS));
               if(!(_loc5_ == null) && !(_loc5_.alternativeVoicesDropDown == null))
               {
                  _loc5_.alternativeVoicesDropDown.selectedIndex = 0;
               }
            }
         }
         else
         {
            _loc6_ = 2;
            if(param2.indexOf(this.CONTROLS_WARNING,0) >= 0)
            {
               _loc6_ = 3;
            }
            this.tabs.selectedIndex = _loc6_;
         }
      }

      public function as_setData(param1:Object) : void {
         this.initializeCommonData(param1);
      }

      private function initializeCommonData(param1:Object) : void {
         var _loc2_:String = null;
         var _loc3_:IViewStackContent = null;
         this._settingsData = this.normalize(param1);
         this.changesData = new SettingsChangesMap();
         this.updateApplyBtnState();
         if(this.tabs != null)
         {
            this.tabs.dataProvider = new DataProvider(SettingsConfig.tabsDataProvider);
            if(this.tabs.selectedIndex == -1)
            {
               this.tabs.selectedIndex = __currentTab;
            }
            _loc2_ = SettingsConfig.tabsDataProvider[__currentTab].linkage;
            this.view.show(_loc2_);
            _loc3_ = IViewStackContent(this.view.currentView);
            _loc3_.update(
               {
                  "id":_loc2_,
                  "data":this._settingsData[_loc2_]
               }
            );
            this.tabs.validateNow();
         }
      }

      public function as_ConfirmationOfApplication(param1:Boolean) : void {
         this.updateSettingsConfig(param1);
      }

      override protected function configUI() : void {
         super.configUI();
         this.submitBtn.label = SETTINGS.OK_BUTTON;
         this.cancelBtn.label = SETTINGS.CANCEL_BUTTON;
         this.applyBtn.label = SETTINGS.APPLY_BUTTON;
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.cancelBtnClickHandler,false,0,true);
         this.applyBtn.addEventListener(ButtonEvent.CLICK,this.applyBtnClickHandler,false,0,true);
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.submitBtnClickHandler,false,0,true);
         if(this.tabs != null)
         {
            this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabChange);
            this.view.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
            this.view.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangeHandler);
         }
         this.addEventListener(SettingViewEvent.ON_CONTROL_CHANGED,this.onControlChanged);
         this.addEventListener(SettingViewEvent.ON_PTT_CONTROL_CHANGED,this.onPTTControlChanged);
         this.addEventListener(SettingViewEvent.ON_AUTO_DETECT_QUALITY,this.onAutodetectQuality);
         this.addEventListener(SettingViewEvent.ON_VIVOX_TEST,this.onVivoxTest);
         this.addEventListener(SettingViewEvent.ON_UPDATE_CAPTURE_DEVICE,this.onUpdateCaptureDevices);
         this.addEventListener(AlternativeVoiceEvent.ON_TEST_ALTERNATIVE_VOICES,this.onAlternativeVoice);
         this.updateStage(App.appWidth,App.appHeight);
      }

      override protected function onPopulate() : void {
         super.onPopulate();
      }

      override protected function draw() : void {
         super.draw();
      }

      override protected function onDispose() : void {
         super.onDispose();
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.cancelBtnClickHandler);
         this.applyBtn.removeEventListener(ButtonEvent.CLICK,this.applyBtnClickHandler);
         this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.submitBtnClickHandler);
         if(this.view)
         {
            this.view.dispose();
            this.view.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdateHandler);
            this.view.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewChangeHandler);
         }
         if(this.tabs)
         {
            this.tabs.dispose();
            this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabChange);
         }
         this.removeEventListener(SettingViewEvent.ON_PTT_CONTROL_CHANGED,this.onPTTControlChanged);
         this.removeEventListener(SettingViewEvent.ON_CONTROL_CHANGED,this.onControlChanged);
         this.removeEventListener(SettingViewEvent.ON_AUTO_DETECT_QUALITY,this.onAutodetectQuality);
         this.removeEventListener(SettingViewEvent.ON_VIVOX_TEST,this.onVivoxTest);
         this.removeEventListener(SettingViewEvent.ON_UPDATE_CAPTURE_DEVICE,this.onUpdateCaptureDevices);
         this.removeEventListener(AlternativeVoiceEvent.ON_TEST_ALTERNATIVE_VOICES,this.onAlternativeVoice);
         this.changesData.clear();
         this.changesData = null;
         this._settingsData = null;
      }

      private function controlDefValEqNewVal(param1:*, param2:*) : Boolean {
         var _loc3_:String = null;
         if(param1  is  SettingsControlProp)
         {
            return SettingsControlProp(param1).current == param2;
         }
         if(param1  is  SettingsKeyProp)
         {
            return SettingsKeyProp(param1).key == param2;
         }
         if(!(param2  is  String) && !(param2  is  Number) && !(param2  is  Boolean))
         {
            for (_loc3_ in param2)
            {
               if(param1[_loc3_] != null)
               {
                  if(param1[_loc3_]  is  SettingsControlProp)
                  {
                     return SettingsControlProp(param1[_loc3_]).current == param2[_loc3_];
                  }
                  if(param1[_loc3_]  is  SettingsKeyProp)
                  {
                     return SettingsKeyProp(param1[_loc3_]).key == param2[_loc3_];
                  }
                  return this.controlDefValEqNewVal(param1[_loc3_],param2[_loc3_]);
               }
            }
         }
         return false;
      }

      private function checkChanges(param1:Boolean, param2:String, param3:*) : void {
         if(param1)
         {
            this.changesData.tryCutChanges(param2,param3);
         }
         else
         {
            this.changesData.tryAddChanges(param2,param3);
         }
         this.updateApplyBtnState();
      }

      private function updateApplyBtnState() : void {
         this.applyBtn.enabled = (this.changesData) && this.changesData.length > 0;
      }

      private function tryGetView(param1:String) : MovieClip {
         var _loc2_:MovieClip = null;
         if(!this.view)
         {
            return null;
         }
         if(this.view.cachedViews[param1] != null)
         {
            _loc2_ = this.view.cachedViews[param1];
         }
         return _loc2_;
      }

      private function normalize(param1:Object) : Object {
         var _loc2_:String = null;
         var _loc3_:SettingsControlProp = null;
         var _loc4_:SettingsKeyProp = null;
         for (_loc2_ in SettingsConfig.settingsData)
         {
            if(param1[_loc2_] != undefined)
            {
               this.normalizeInside(param1,SettingsConfig.settingsData[_loc2_],_loc2_);
            }
         }
         if((SettingsConfig.settingsData[SettingsConfig.SOUND_SETTINGS][SettingsConfig.PTT]) && (SettingsConfig.settingsData[SettingsConfig.CONTROLS_SETTINGS][SettingsConfig.KEYBOARD][SettingsConfig.PUSH_TO_TALK]))
         {
            _loc3_ = SettingsControlProp(SettingsConfig.settingsData[SettingsConfig.SOUND_SETTINGS][SettingsConfig.PTT]);
            _loc4_ = SettingsKeyProp(SettingsConfig.settingsData[SettingsConfig.CONTROLS_SETTINGS][SettingsConfig.KEYBOARD][SettingsConfig.PUSH_TO_TALK]);
            _loc3_.current = _loc4_.key;
         }
         SettingsControlProp(SettingsConfig.settingsData[SettingsConfig.GAME_SETTINGS][SettingsConfig.ENABLE_OL_FILTER]).readOnly = App.globalVarsMgr.isChinaS();
         return SettingsConfig.settingsData;
      }

      private function normalizeInside(param1:Object, param2:Object, param3:String) : void {
         var _loc5_:String = null;
         var _loc6_:SettingsControlProp = null;
         var _loc7_:String = null;
         var _loc4_:ICommons = App.utils.commons;
         for (_loc5_ in param2)
         {
            if(param1[param3][_loc5_] != undefined)
            {
               if(_loc5_ == SettingsConfig.PRESETS || _loc5_ == SettingsConfig.QUALITY_ORDER)
               {
                  param2[_loc5_] = _loc4_.cloneObject(param1[param3][_loc5_]);
               }
               else
               {
                  if(_loc5_ == SettingsConfig.KEYBOARD)
                  {
                     param2[_loc5_] = {};
                     param2[SettingsConfig.KEYS_LAYOUT_ORDER] = [];
                     this.normalizeKeys(param1[param3][_loc5_],param1[param3][_loc5_][SettingsConfig.KEYS_LAYOUT],param2[_loc5_],param2[SettingsConfig.KEYS_LAYOUT_ORDER]);
                  }
                  else
                  {
                     if(param2[_loc5_]  is  SettingsControlProp)
                     {
                        _loc6_ = SettingsControlProp(param2[_loc5_]);
                        if(param1[param3][_loc5_]  is  Boolean || param1[param3][_loc5_]  is  String || param1[param3][_loc5_]  is  Number)
                        {
                           _loc6_.current = _loc6_.type == SettingsConfig.TYPE_CHECKBOX?Boolean(param1[param3][_loc5_]):param1[param3][_loc5_];
                           _loc6_.prevVal = _loc6_.current;
                        }
                        else
                        {
                           if(param1[param3][_loc5_]  is  Object && !(param1[param3][_loc5_].current == undefined))
                           {
                              if(_loc6_.type == SettingsConfig.TYPE_CHECKBOX)
                              {
                                 _loc6_.current = Boolean(param1[param3][_loc5_].current);
                                 _loc6_.prevVal = _loc6_.current;
                                 if(param1[param3][_loc5_].hasOwnProperty("options"))
                                 {
                                    _loc6_.options = _loc4_.cloneObject(param1[param3][_loc5_].options);
                                    for (_loc7_ in param1[param3][_loc5_].options)
                                    {
                                       if((param1[param3][_loc5_].options[_loc7_].hasOwnProperty("advanced")) && param1[param3][_loc5_].options[_loc7_].advanced == true)
                                       {
                                          _loc6_.advanced = true;
                                          break;
                                       }
                                    }
                                 }
                                 if(param3 == SettingsConfig.CONTROLS_SETTINGS)
                                 {
                                    if(param1[param3][_loc5_].hasOwnProperty("default"))
                                    {
                                       _loc6_._default = param1[param3][_loc5_].default == undefined?false:Boolean(param1[param3][_loc5_].default);
                                    }
                                    else
                                    {
                                       _loc6_._default = false;
                                    }
                                 }
                              }
                              else
                              {
                                 _loc6_.current = Math.max(param1[param3][_loc5_].current,0);
                                 _loc6_.prevVal = _loc6_.current;
                                 if(param3 == SettingsConfig.CONTROLS_SETTINGS)
                                 {
                                    if(param1[param3][_loc5_].hasOwnProperty("default"))
                                    {
                                       _loc6_._default = Math.max(param1[param3][_loc5_].default,0);
                                    }
                                    else
                                    {
                                       _loc6_._default = 0;
                                    }
                                 }
                                 if(param1[param3][_loc5_].options != undefined)
                                 {
                                    _loc6_.options = _loc4_.cloneObject(param1[param3][_loc5_].options);
                                 }
                                 else
                                 {
                                    _loc6_.options = [];
                                 }
                              }
                           }
                        }
                     }
                     else
                     {
                        this.normalizeInside(param1[param3],param2[_loc5_],_loc5_);
                     }
                  }
               }
            }
         }
      }

      private function normalizeKeys(param1:Object, param2:Array, param3:Object, param4:Array) : void {
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:Array = null;
         var _loc14_:* = NaN;
         var _loc15_:* = NaN;
         var _loc16_:* = false;
         var _loc5_:uint = param2.length;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = param2[_loc6_].key;
            _loc8_ = param2[_loc6_].values;
            _loc9_ = _loc8_.length;
            param4.push(_loc7_);
            param3[_loc7_] = new SettingsKeyProp(_loc7_,true,_loc7_,null,NaN,NaN,null,false,_loc6_ == 0?0:18);
            _loc10_ = 0;
            while(_loc10_ < _loc9_)
            {
               _loc11_ = _loc8_[_loc10_].key;
               _loc12_ = _loc8_[_loc10_].cmd;
               _loc13_ = _loc8_[_loc10_].hasOwnProperty("descr")?_loc8_[_loc10_]["descr"]:null;
               if(param1[_loc11_].current != null)
               {
                  _loc14_ = param1[_loc11_].current;
                  _loc15_ = param1[_loc11_].default;
                  _loc16_ = true;
                  param3[_loc11_] = new SettingsKeyProp(_loc11_,false,_loc11_,_loc12_,_loc14_,_loc15_,_loc13_,_loc16_);
                  param4.push(_loc11_);
               }
               _loc10_++;
            }
            _loc6_++;
         }
      }

      private function sendData(param1:Boolean) : void {
         var _loc5_:String = null;
         this.cancelBtn.enabled = this.applyBtn.enabled = this.submitBtn.enabled = false;
         var _loc2_:SoundSettings = SoundSettings(this.tryGetView(SettingsConfig.SOUND_SETTINGS));
         if(_loc2_)
         {
            _loc2_.breakSoundCheck();
         }
         var _loc3_:Boolean = this.checkControlsWrong();
         var _loc4_:* = !isSoundModeValidS();
         if((_loc3_) || (_loc4_))
         {
            _loc5_ = _loc3_?this.CONTROLS_WARNING:"";
            _loc5_ = _loc5_ + (_loc4_?this.SOUND_MODE_WARNING:"");
            showWarningDialogS(_loc5_,this.changesData.getChanges(),param1);
         }
         else
         {
            applySettingsS(this.changesData.getChanges(),param1);
            this.as_ConfirmationOfApplication(false);
         }
      }

      private function checkControlsWrong() : Boolean {
         var _loc3_:IDataProvider = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:SettingsKeyProp = null;
         var _loc1_:* = false;
         var _loc2_:ControlsSettings = ControlsSettings(this.tryGetView(SettingsConfig.CONTROLS_SETTINGS));
         if(_loc2_)
         {
            _loc3_ = _loc2_.getKeyasDataProvider();
            _loc4_ = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(KeysMap.KEY_NONE == _loc3_[_loc5_].key)
               {
                  _loc1_ = true;
                  break;
               }
               _loc5_++;
            }
         }
         else
         {
            _loc6_ = SettingsConfig.settingsData[SettingsConfig.CONTROLS_SETTINGS][SettingsConfig.KEYBOARD];
            for (_loc7_ in _loc6_)
            {
               _loc8_ = SettingsKeyProp(_loc6_[_loc7_]);
               if(_loc8_.key == KeysMap.KEY_NONE)
               {
                  _loc1_ = true;
                  break;
               }
            }
         }
         return _loc1_;
      }

      private function updateSettingsConfig(param1:Boolean) : void {
         var _loc2_:Object = null;
         if((param1) && (this.changesData))
         {
            _loc2_ = this.changesData.getChanges();
            this.searchAndOverride(0,SettingsConfig.settingsData,_loc2_);
            this.changesData.clear();
         }
         this.cancelBtn.enabled = this.submitBtn.enabled = true;
         this.updateApplyBtnState();
      }

      private function searchAndOverride(param1:uint, param2:Object, param3:Object) : void {
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         for (_loc4_ in param3)
         {
            if(!(param3[_loc4_]  is  Boolean || param3[_loc4_]  is  Number || param3[_loc4_]  is  String))
            {
               _loc5_ = null;
               if(param1 == 0)
               {
                  _loc5_ = this.getPropObj(param2,_loc4_);
               }
               else
               {
                  _loc5_ = param2[_loc4_];
               }
               this.searchAndOverride(param1 + 1,_loc5_,param3[_loc4_]);
            }
            else
            {
               _loc6_ = null;
               if(param1 == 0)
               {
                  _loc6_ = this.getPropObj(param2,_loc4_);
               }
               else
               {
                  _loc6_ = param2[_loc4_];
               }
               if(!(_loc6_ == null) && _loc6_  is  SettingsControlProp)
               {
                  SettingsControlProp(_loc6_).current = param3[_loc4_];
               }
               else
               {
                  if(!(_loc6_ == null) && _loc6_  is  SettingsKeyProp)
                  {
                     SettingsKeyProp(_loc6_).key = param3[_loc4_];
                  }
               }
            }
         }
      }

      private function getPropObj(param1:Object, param2:String) : Object {
         var _loc3_:String = null;
         for (_loc3_ in param1)
         {
            if(param1[_loc3_].hasOwnProperty(param2))
            {
               return param1[_loc3_][param2];
            }
         }
         return null;
      }

      private function onTabChange(param1:IndexEvent) : void {
         __currentTab = param1.index;
         App.toolTipMgr.hide();
         var _loc2_:SoundSettings = SoundSettings(this.tryGetView(SettingsConfig.SOUND_SETTINGS));
         if(_loc2_)
         {
            _loc2_.onViewChanged();
         }
      }

      private function onViewNeedUpdateHandler(param1:ViewStackEvent) : void {
         var _loc2_:IViewStackContent = param1.view;
         _loc2_.update(
            {
               "id":param1.linkage,
               "data":this._settingsData[param1.linkage]
            }
         );
      }

      private function onViewChangeHandler(param1:ViewStackEvent) : void {
         var _loc2_:IViewStackContent = param1.view;
         var _loc3_:ISettingsBase = _loc2_ as ISettingsBase;
         _loc3_.updateDependentData();
      }

      private function onPTTControlChanged(param1:SettingViewEvent) : void {
         var _loc2_:SettingsControlProp = SettingsControlProp(SettingsConfig.settingsData[SettingsConfig.SOUND_SETTINGS][SettingsConfig.PTT]);
         _loc2_.current = param1.controlValue;
         var _loc3_:SoundSettings = SoundSettings(this.tryGetView(SettingsConfig.SOUND_SETTINGS));
         if(_loc3_)
         {
            _loc3_.updatePTTControl(_loc2_.current);
         }
      }

      private function onControlChanged(param1:SettingViewEvent) : void {
         var _loc2_:String = param1.viewId;
         var _loc3_:String = param1.controlId;
         var _loc4_:* = param1.controlValue;
         onSettingsChangeS(_loc3_,_loc4_);
         var _loc5_:Boolean = this.controlDefValEqNewVal(this._settingsData[_loc2_][_loc3_],_loc4_);
         this.checkChanges(_loc5_,_loc3_,_loc4_);
      }

      private function onVivoxTest(param1:SettingViewEvent) : void {
         var _loc2_:Boolean = Boolean(param1.controlValue);
         var _loc3_:Boolean = startVOIPTestS(_loc2_);
         var _loc4_:SoundSettings = SoundSettings(this.tryGetView(SettingsConfig.SOUND_SETTINGS));
         if(_loc4_ != null)
         {
            _loc4_.setVoiceTestState(!((_loc3_) || !_loc2_));
         }
      }

      private function onAutodetectQuality(param1:SettingViewEvent) : void {
         var _loc2_:Number = autodetectQualityS();
         var _loc3_:GraphicSettings = GraphicSettings(this.tryGetView(SettingsConfig.GRAPHIC_SETTINGS));
         if(_loc3_ != null)
         {
            _loc3_.setPresetAfterAutoDetect(_loc2_);
         }
      }

      private function onUpdateCaptureDevices(param1:SettingViewEvent) : void {
         updateCaptureDevicesS();
      }

      private function onAlternativeVoice(param1:AlternativeVoiceEvent) : void {
         var _loc2_:SoundSettings = null;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:Point = null;
         var _loc6_:ITooltipProps = null;
         var _loc7_:String = null;
         if(isSoundModeValidS())
         {
            altVoicesPreviewS();
         }
         else
         {
            _loc2_ = SoundSettings(this.tryGetView(SettingsConfig.SOUND_SETTINGS));
            _loc3_ = _loc2_.testAlternativeVoicesButton.x;
            _loc4_ = _loc2_.testAlternativeVoicesButton.y;
            _loc5_ = this.localToGlobal(new Point(_loc3_,_loc4_));
            _loc6_ = new TooltipProps(Tooltips.TYPE_WARNING,_loc5_.x,_loc5_.y,0,0,3000);
            _loc7_ = "<font color=\"" + Utils.instance.COLOR_ALERT + "\">" + App.utils.locale.makeString(TOOLTIPS.SETTINGS_DIALOG_SOUND_SOUNDMODEINVALID) + "</font>";
            App.toolTipMgr.show(_loc7_,_loc6_);
         }
      }

      private function cancelBtnClickHandler(param1:ButtonEvent) : void {
         var _loc2_:SoundSettings = SoundSettings(this.tryGetView(SettingsConfig.SOUND_SETTINGS));
         if(_loc2_)
         {
            _loc2_.breakSoundCheck();
         }
         onWindowCloseS();
      }

      private function applyBtnClickHandler(param1:ButtonEvent) : void {
         this.sendData(false);
      }

      private function submitBtnClickHandler(param1:ButtonEvent) : void {
         this.sendData(true);
      }
   }

}