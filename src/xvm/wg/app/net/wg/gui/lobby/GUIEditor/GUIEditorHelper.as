package net.wg.gui.lobby.GUIEditor
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.utils.getQualifiedClassName;
   import flash.text.TextField;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.controls.ScrollingList;
   import __AS3__.vec.Vector;


   public class GUIEditorHelper extends Object
   {
          
      public function GUIEditorHelper() {
         super();
         this.componentsInfo = new ComponentsInfoContainer();
      }

      private static var ms_instance:GUIEditorHelper = null;

      public static const TYPE_ALL:String = "all";

      public static const TYPE_SIMPLE:String = "simple";

      public static const TYPE_STANDART:String = "standart";

      public static const TYPE_ADVANCED:String = "advanced";

      public static const TYPE_NON_SMART:String = "nonSmart";

      public static const TYPE_SMART:String = "smart";

      public static function get instance() : GUIEditorHelper {
         if(ms_instance == null)
         {
            ms_instance = new GUIEditorHelper();
         }
         return ms_instance;
      }

      private static function createGEComponentVO(param1:String, param2:String, param3:DisplayObject) : GEComponentVO {
         return new GEComponentVO(
            {
               "label":param1,
               "icon":param2,
               "instance":param3
            }
         );
      }

      private var componentsInfo:ComponentsInfoContainer = null;

      public function getDisplayList(param1:DisplayObjectContainer, param2:String="") : Array {
         var _loc9_:* = NaN;
         var _loc10_:DisplayObject = null;
         var _loc11_:String = null;
         var _loc12_:* = NaN;
         var _loc13_:String = null;
         var _loc3_:* = 1000;
         var _loc4_:* = "../maps/icons/tooltip/complex_equipment.png";
         var _loc5_:* = "TextField";
         var _loc6_:* = "|   ";
         var _loc7_:Array = [];
         var _loc8_:String = null;
         if(param2.length <= _loc3_)
         {
            _loc9_ = 0;
            while(_loc9_ < param1.numChildren)
            {
               _loc10_ = param1.getChildAt(_loc9_);
               _loc11_ = getQualifiedClassName(_loc10_);
               _loc12_ = _loc11_.lastIndexOf("::");
               if(_loc12_ != -1)
               {
                  _loc11_ = _loc11_.substr(_loc12_ + 2);
               }
               _loc8_ = _loc4_;
               _loc13_ = param2;
               switch(_loc11_)
               {
                  case _loc5_:
                     _loc13_ = _loc13_ + TextField(_loc10_).text;
                     break;
                  default:
                     _loc13_ = _loc13_ + _loc10_.name + "(" + _loc11_ + ")";
               }
               _loc7_.push(createGEComponentVO(_loc13_,_loc8_,_loc10_));
               if(_loc10_  is  DisplayObjectContainer)
               {
                  _loc7_ = _loc7_.concat(this.getDisplayList(DisplayObjectContainer(_loc10_),param2 + _loc6_));
               }
               _loc9_++;
            }
         }
         return _loc7_;
      }

      public function getPropsList(param1:Object) : Array {
         var _loc2_:Array = [];
         if(param1  is  InteractiveObject)
         {
            _loc2_ = _loc2_.concat(["tabEnabled","tabIndex","mouseEnabled","doubleClickEnabled"]);
         }
         if(param1  is  DisplayObject)
         {
            _loc2_ = _loc2_.concat(["x","y","width","height","alpha","name","rotation","scaleX","scaleY","visible"]);
         }
         if(param1  is  DisplayObjectContainer)
         {
            _loc2_ = _loc2_.concat(["numChildren","tabChildren","mouseChildren"]);
         }
         if(param1  is  Sprite)
         {
            _loc2_ = _loc2_.concat(["hitArea","buttonMode","useHandCursor"]);
         }
         if(param1  is  MovieClip)
         {
            _loc2_ = _loc2_.concat(["currentFrame","framesLoaded","totalFrames","currentLabel","currentFrameLabel","currentLabels","enabled"]);
         }
         if(param1  is  TextField)
         {
            _loc2_ = _loc2_.concat(["antiAliasType","autoSize","background","backgroundColor","border","borderColor","bottomScrollV","condenseWhite","embedFonts","htmlText","length","textInteractionMode","maxChars","maxScrollH","maxScrollV","mouseWheelEnabled","multiline","numLines","restrict","scrollH","scrollV","selectable","selectedText","selectionBeginIndex","selectionEndIndex","text","textColor","textHeight","textWidth","type"]);
         }
         if(param1  is  UIComponent)
         {
            _loc2_ = _loc2_.concat(["componentInspectorSetting","hasFocus","focused","focusTarget","actualWidth","actualHeight","actualScaleX","actualScaleY"]);
         }
         if(param1  is  Button)
         {
            _loc2_ = _loc2_.concat(["autoRepeat","owner","selected","groupName","label","autoSize","focusIndicator"]);
         }
         if(param1  is  CoreList)
         {
            _loc2_ = _loc2_.concat(["itemRendererName","itemRenderer","labelField"]);
         }
         if(param1  is  ScrollingList)
         {
            _loc2_ = _loc2_.concat(["margin","scrollBar","scrollPosition","rowCount","rowHeight"]);
         }
         return _loc2_;
      }

      public function getComponentsList(param1:String="all") : Array {
         var _loc4_:ComponentInfoVo = null;
         var _loc2_:Vector.<ComponentInfoVo> = this.componentsInfo.getComponentsList(param1);
         var _loc3_:Array = [];
         for each (_loc4_ in _loc2_)
         {
            if(_loc4_.isAvailable())
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
   }

}   import __AS3__.vec.Vector;
   import net.wg.gui.lobby.GUIEditor.ComponentInfoVo;
   import net.wg.infrastructure.exceptions.ArgumentException;
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   import flash.utils.getQualifiedClassName;


   class ComponentsInfoContainer extends Object
   {
          
      function ComponentsInfoContainer() {
         var _loc1_:String = null;
         this._information = {};
         this._SIMPLE_CONTROLS_LINKAGES = ["BitmapFill","ButtonBlack","ButtonNormal","ButtonRed","CheckBox","DropDownListItemRendererSound","DropdownMenu","DropdownMenu_ScrollingList","HyperLink","LoadingBar","RedButton","ScrollBar","TextFieldShort","TextInput","UILoaderAlt"];
         this._CONTROLS_LINKAGES = ["ActionPriceUI","AlertIcon_UI","IconText","ButtonCaps","ButtonCapsRed","ButtonIcon","ButtonIconText","CheckBoxFilter","CheckBoxTankers","CompactCheckBoxUI","ContextMenu","ContextMenuItem","DropDownImageText","UILoaderAlt","DropdownMenu","LabelControl","ListItemRedererImageText","LobbyMenuButton","MainMenuButton","NationDropdownMenuUI","NumericStepper","RadioButton","RedButtonDropDown","RedButtonDropDown_ListItemRenderer","RedButtonDropDown_ScrollingList","RegionDropdownMenu_UI","ScrollingList","Slider","UILoaderCut"];
         this._ADVANCED_CONTROLS_LINKAGES = ["AccordionUI","ViewStack","AccrodionSoundRendererUI","BigAccrodionSoundRenderer","ButtonBarEx","ClanEmblem","CounterEx","DashLine_UI","DashLine","DoubleProgressBar","FieldSet","HelpLayout","InteractiveSortingButton_UI","ModuleIconUI","moduleIconExtra","PortraitsItemRendererUI","ScalableIconButton_UI","ScalableIconWrapper_UI","ShellButton","SkillItemViewMiniUI","SkillsItemRendererUI","SmallTabButton","SortableHeaderButtonBar_UI","SortingIconLoader","TabButton","TankIcon","TextAreaSimple","vehicleTypeButtonUI"];
         this.LINKAGES = {};
         super();
         this.LINKAGES[ComponentsInfoContainer.TYPE_SIMPLE] = this._SIMPLE_CONTROLS_LINKAGES;
         this.LINKAGES[ComponentsInfoContainer.TYPE_STANDART] = this._CONTROLS_LINKAGES;
         this.LINKAGES[ComponentsInfoContainer.TYPE_ADVANCED] = this._ADVANCED_CONTROLS_LINKAGES;
         this.LINKAGES[ComponentsInfoContainer.TYPE_NON_SMART] = this._SIMPLE_CONTROLS_LINKAGES.concat(this._CONTROLS_LINKAGES).concat(this._ADVANCED_CONTROLS_LINKAGES);
         this.LINKAGES[ComponentsInfoContainer.TYPE_SMART] = [];
         for (_loc1_ in this.LINKAGES)
         {
            this._information[_loc1_] = this.createComponentsInfoByType(_loc1_);
         }
      }

      private var _information:Object;

      private const _SIMPLE_CONTROLS_LINKAGES:Array;

      private const _CONTROLS_LINKAGES:Array;

      private const _ADVANCED_CONTROLS_LINKAGES:Array;

      private var LINKAGES:Object;

      private function createComponentsInfoByType(param1:String) : Vector.<ComponentInfoVo> {
         var _loc4_:String = null;
         var _loc2_:Array = this.LINKAGES[param1];
         var _loc3_:Vector.<ComponentInfoVo> = new Vector.<ComponentInfoVo>();
         for each (_loc4_ in _loc2_)
         {
            _loc3_.push(new ComponentInfoVo(_loc4_));
         }
         return _loc3_;
      }

      public function getComponentsList(param1:String) : Vector.<ComponentInfoVo> {
         switch(param1)
         {
            case ComponentsInfoContainer.TYPE_ALL:
               this.updateSmartControls(App.stage);
               return this._information[ComponentsInfoContainer.TYPE_NON_SMART].concat(this._information[ComponentsInfoContainer.TYPE_SMART]);
            case ComponentsInfoContainer.TYPE_SMART:
               this.updateSmartControls(App.stage);
               return this._information[ComponentsInfoContainer.TYPE_SMART];
            case ComponentsInfoContainer.TYPE_SIMPLE:
            case ComponentsInfoContainer.TYPE_STANDART:
            case ComponentsInfoContainer.TYPE_ADVANCED:
            case ComponentsInfoContainer.TYPE_NON_SMART:
               return this._information[param1];
            default:
               throw new ArgumentException("Unknown components type: " + param1);
         }
      }

      private function updateSmartControls(param1:DisplayObjectContainer) : void {
         var _loc3_:DisplayObject = null;
         var _loc4_:String = null;
         var _loc2_:Number = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_);
            _loc4_ = getQualifiedClassName(_loc3_);
            if(_loc4_.indexOf(".app.") == -1)
            {
               if(this.LINKAGES[ComponentsInfoContainer.TYPE_NON_SMART].indexOf(_loc4_) == -1 && this.LINKAGES[ComponentsInfoContainer.TYPE_SMART].indexOf(_loc4_) == -1)
               {
                  this._information[ComponentsInfoContainer.TYPE_SMART].push(new ComponentInfoVo(_loc4_));
                  this.LINKAGES[ComponentsInfoContainer.TYPE_SMART].push(_loc4_);
               }
            }
            if(_loc3_  is  DisplayObjectContainer)
            {
               this.updateSmartControls(DisplayObjectContainer(_loc3_));
            }
            _loc2_++;
         }
      }
   }
