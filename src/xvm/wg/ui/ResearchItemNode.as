package 
{
   import net.wg.gui.lobby.techtree.nodes.ResearchItem;
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.sensors.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.ime.*;
   import flash.text.engine.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;


   public dynamic class ResearchItemNode extends ResearchItem
   {
          
      public function ResearchItemNode() {
         this.__setPropDict = new Dictionary(true);
         super();
         addFrameScript(9,this.frame10,19,this.frame20,29,this.frame30,39,this.frame40,49,this.frame50,59,this.frame60,69,this.frame70,79,this.frame80,89,this.frame90,99,this.frame100,109,this.frame110,119,this.frame120,129,this.frame130,139,this.frame140,149,this.frame150,159,this.frame160,169,this.frame170,179,this.frame180,189,this.frame190,199,this.frame200,209,this.frame210,219,this.frame220,229,this.frame230,239,this.frame240,249,this.frame250,259,this.frame260,269,this.frame270,279,this.frame280,289,this.frame290,299,this.frame300,309,this.frame310,319,this.frame320,329,this.frame330,339,this.frame340,349,this.frame350,359,this.frame360);
         addEventListener(Event.FRAME_CONSTRUCTED,this.__setProp_handler,false,0,true);
      }

      public var __setPropDict:Dictionary;

      public var __lastFrameProp:int = -1;

      function __setProp_button_ResearchItemNode_experience(param1:int) : * {
         if(!(button == null) && param1 >= 61 && param1 <= 110 && (this.__setPropDict[button] == undefined || !(int(this.__setPropDict[button]) >= 61 && int(this.__setPropDict[button]) <= 110)))
         {
            this.__setPropDict[button] = param1;
            try
            {
               button["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            button.action = "unlock";
            button.autoRepeat = false;
            button.autoSize = "none";
            button.data = "";
            button.enabled = true;
            button.enableInitCallback = false;
            button.focusable = true;
            button.imgSubstitution =
               {
                  "subString":"{icon}",
                  "source":"button_xp_cost_icon",
                  "baseLineY":13,
                  "width":16,
                  "height":16
               }
            ;
            button.label = "";
            button.selected = false;
            button.soundId = "";
            button.soundType = "normal";
            button.toggle = false;
            button.visible = true;
            try
            {
               button["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }

      function __setProp_button_ResearchItemNode_experience_1(param1:int) : * {
         if(!(button == null) && param1 >= 111 && param1 <= 160 && (this.__setPropDict[button] == undefined || !(int(this.__setPropDict[button]) >= 111 && int(this.__setPropDict[button]) <= 160)))
         {
            this.__setPropDict[button] = param1;
            try
            {
               button["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            button.action = "buy";
            button.autoRepeat = false;
            button.autoSize = "none";
            button.data = "";
            button.enabled = true;
            button.enableInitCallback = false;
            button.focusable = true;
            button.imgSubstitution =
               {
                  "subString":"{icon}",
                  "source":"button_credits_icon",
                  "baseLineY":13,
                  "width":16,
                  "height":16
               }
            ;
            button.label = "";
            button.selected = false;
            button.soundId = "";
            button.soundType = "normal";
            button.toggle = false;
            button.visible = true;
            try
            {
               button["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }

      function __setProp_actionPrice_ResearchItemNode_actionPriceIco_110(param1:int) : * {
         if(!(actionPrice == null) && param1 >= 111 && param1 <= 160 && (this.__setPropDict[actionPrice] == undefined || !(int(this.__setPropDict[actionPrice]) >= 111 && int(this.__setPropDict[actionPrice]) <= 160)))
         {
            this.__setPropDict[actionPrice] = param1;
            try
            {
               actionPrice["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            actionPrice.enabled = true;
            actionPrice.enableInitCallback = false;
            actionPrice.ico = "credits";
            actionPrice.state = "techTreeMod";
            actionPrice.textColorType = "iconColor";
            actionPrice.textSize = 12;
            actionPrice.textYOffset = 0;
            actionPrice.tooltipEnabled = true;
            actionPrice.visible = true;
            try
            {
               actionPrice["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }

      function __setProp_handler(param1:Object) : * {
         var _loc2_:int = currentFrame;
         if(this.__lastFrameProp == _loc2_)
         {
            return;
         }
         this.__lastFrameProp = _loc2_;
         this.__setProp_button_ResearchItemNode_experience(_loc2_);
         this.__setProp_button_ResearchItemNode_experience_1(_loc2_);
         this.__setProp_actionPrice_ResearchItemNode_actionPriceIco_110(_loc2_);
      }

      function frame10() : * {
         stop();
      }

      function frame20() : * {
         stop();
      }

      function frame30() : * {
         stop();
      }

      function frame40() : * {
         stop();
      }

      function frame50() : * {
         stop();
      }

      function frame60() : * {
         stop();
      }

      function frame70() : * {
         stop();
      }

      function frame80() : * {
         stop();
      }

      function frame90() : * {
         stop();
      }

      function frame100() : * {
         stop();
      }

      function frame110() : * {
         stop();
      }

      function frame120() : * {
         stop();
      }

      function frame130() : * {
         stop();
      }

      function frame140() : * {
         stop();
      }

      function frame150() : * {
         stop();
      }

      function frame160() : * {
         stop();
      }

      function frame170() : * {
         stop();
      }

      function frame180() : * {
         stop();
      }

      function frame190() : * {
         stop();
      }

      function frame200() : * {
         stop();
      }

      function frame210() : * {
         stop();
      }

      function frame220() : * {
         stop();
      }

      function frame230() : * {
         stop();
      }

      function frame240() : * {
         stop();
      }

      function frame250() : * {
         stop();
      }

      function frame260() : * {
         stop();
      }

      function frame270() : * {
         stop();
      }

      function frame280() : * {
         stop();
      }

      function frame290() : * {
         stop();
      }

      function frame300() : * {
         stop();
      }

      function frame310() : * {
         stop();
      }

      function frame320() : * {
         stop();
      }

      function frame330() : * {
         stop();
      }

      function frame340() : * {
         stop();
      }

      function frame350() : * {
         stop();
      }

      function frame360() : * {
         stop();
      }
   }

}