package scaleform.clik.utils 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    
    public class Constraints extends flash.events.EventDispatcher implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function Constraints(arg1:flash.display.Sprite, arg2:String="counterScale")
        {
            super();
            this.scope = arg1;
            this.scaleMode = arg2;
            this.elements = {};
            this.lastWidth = arg1.width;
            this.lastHeight = arg1.height;
            arg1.addEventListener(flash.events.Event.ADDED_TO_STAGE, this.handleScopeAddedToStage, false, 0, true);
            arg1.addEventListener(flash.events.Event.REMOVED_FROM_STAGE, this.handleScopeAddedToStage, false, 0, true);
            return;
        }

        public function addElement(arg1:String, arg2:flash.display.DisplayObject, arg3:uint):void
        {
            if (arg2 == null) 
                return;
            var loc1:*=this.scope.width;
            var loc2:*=this.scope.height;
            if (!(this.scope.parent == null) && this.scope.parent is flash.display.Stage) 
            {
                loc1 = this.scope.stage.stageWidth;
                loc2 = this.scope.stage.stageHeight;
            }
            var loc3:*=new scaleform.clik.utils.ConstrainedElement(arg2, arg3, arg2.x, arg2.y, loc1 / this.scope.scaleX - (arg2.x + arg2.width), loc2 / this.scope.scaleY - (arg2.y + arg2.height), arg2.scaleX, arg2.scaleY);
            if (this.elements[arg1] == null) 
            {
                var loc4:*;
                var loc5:*=((loc4 = this).elementCount + 1);
                loc4.elementCount = loc5;
            }
            this.elements[arg1] = loc3;
            return;
        }

        public function removeElement(arg1:String):void
        {
            if (this.elements[arg1] != null) 
            {
                var loc1:*;
                var loc2:*=((loc1 = this).elementCount - 1);
                loc1.elementCount = loc2;
            }
            delete this.elements[arg1];
            return;
        }

        public function removeAllElements():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.elements;
            for (loc1 in loc3) 
            {
                if (!(this.elements[loc1] is scaleform.clik.utils.ConstrainedElement)) 
                    continue;
                var loc4:*;
                var loc5:*=((loc4 = this).elementCount - 1);
                loc4.elementCount = loc5;
                delete this.elements[loc1];
            }
            return;
        }

        public function getElement(arg1:String):scaleform.clik.utils.ConstrainedElement
        {
            return this.elements[arg1] as scaleform.clik.utils.ConstrainedElement;
        }

        public function updateElement(arg1:String, arg2:flash.display.DisplayObject):void
        {
            if (arg2 == null) 
                return;
            var loc1:*=this.elements[arg1] as scaleform.clik.utils.ConstrainedElement;
            if (loc1 == null) 
                return;
            loc1.clip = arg2;
            return;
        }

        public function getXAdjust():Number
        {
            if (this.scaleMode == scaleform.clik.constants.ConstrainMode.REFLOW) 
                return this.parentXAdjust;
            return this.parentXAdjust / this.scope.scaleX;
        }

        public function getYAdjust():Number
        {
            if (this.scaleMode == scaleform.clik.constants.ConstrainMode.REFLOW) 
                return this.parentYAdjust;
            return this.parentYAdjust / this.scope.scaleY;
        }

        public function update(arg1:Number, arg2:Number):void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=NaN;
            var loc9:*=NaN;
            this.lastWidth = arg1;
            this.lastHeight = arg2;
            if (this.elementCount == 0) 
                return;
            var loc1:*=this.getXAdjust();
            var loc2:*=this.getYAdjust();
            var loc3:*=this.scaleMode == scaleform.clik.constants.ConstrainMode.COUNTER_SCALE;
            var loc10:*=0;
            var loc11:*=this.elements;
            for (loc4 in loc11) 
            {
                loc6 = (loc5 = this.elements[loc4] as scaleform.clik.utils.ConstrainedElement).edges;
                loc7 = loc5.clip;
                if (loc3) 
                {
                    loc7.scaleX = loc5.scaleX * loc1;
                    loc7.scaleY = loc5.scaleY * loc2;
                    if ((loc6 & scaleform.clik.utils.Constraints.CENTER_H) == 0) 
                        if ((loc6 & scaleform.clik.utils.Constraints.LEFT) > 0) 
                        {
                            loc7.x = loc5.left * loc1;
                            if ((loc6 & scaleform.clik.utils.Constraints.RIGHT) > 0) 
                            {
                                loc8 = arg1 - loc5.left - loc5.right;
                                if (!(loc7 is flash.text.TextField)) 
                                    loc8 = loc8 * loc1;
                                loc7.width = loc8;
                            }
                        }
                        else if ((loc6 & scaleform.clik.utils.Constraints.RIGHT) > 0) 
                            loc7.x = (arg1 - loc5.right) * loc1 - loc7.width;
                    if ((loc6 & scaleform.clik.utils.Constraints.CENTER_V) == 0) 
                        if ((loc6 & scaleform.clik.utils.Constraints.TOP) > 0) 
                        {
                            loc7.y = loc5.top * loc2;
                            if ((loc6 & scaleform.clik.utils.Constraints.BOTTOM) > 0) 
                            {
                                loc9 = arg2 - loc5.top - loc5.bottom;
                                if (!(loc7 is flash.text.TextField)) 
                                    loc9 = loc9 * loc2;
                                loc7.height = loc9;
                            }
                        }
                        else if ((loc6 & scaleform.clik.utils.Constraints.BOTTOM) > 0) 
                            loc7.y = (arg2 - loc5.bottom) * loc2 - loc7.height;
                }
                else 
                {
                    if ((loc6 & scaleform.clik.utils.Constraints.CENTER_H) == 0 && (loc6 & scaleform.clik.utils.Constraints.RIGHT) > 0) 
                        if ((loc6 & scaleform.clik.utils.Constraints.LEFT) > 0) 
                            loc7.width = arg1 - loc5.left - loc5.right;
                        else 
                            loc7.x = arg1 - loc7.width - loc5.right;
                    if ((loc6 & scaleform.clik.utils.Constraints.CENTER_V) == 0 && (loc6 & scaleform.clik.utils.Constraints.BOTTOM) > 0) 
                        if ((loc6 & scaleform.clik.utils.Constraints.TOP) > 0) 
                            loc7.height = arg2 - loc5.top - loc5.bottom;
                        else 
                            loc7.y = arg2 - loc7.height - loc5.bottom;
                    if (loc7 is scaleform.clik.core.UIComponent) 
                        (loc7 as scaleform.clik.core.UIComponent).validateNow();
                }
                if ((loc6 & scaleform.clik.utils.Constraints.CENTER_H) > 0) 
                    loc7.x = arg1 * 0.5 * loc1 - loc7.width * 0.5;
                if (!((loc6 & scaleform.clik.utils.Constraints.CENTER_V) > 0)) 
                    continue;
                loc7.y = arg2 * 0.5 * loc2 - loc7.height * 0.5;
            }
            if (!loc3) 
            {
                this.scope.scaleX = this.parentXAdjust;
                this.scope.scaleY = this.parentYAdjust;
            }
            if (hasEventListener(scaleform.clik.events.ResizeEvent.RESIZE)) 
                dispatchEvent(new scaleform.clik.events.ResizeEvent(scaleform.clik.events.ResizeEvent.RESIZE, loc1, loc2));
            return;
        }

        public override function toString():String
        {
            var loc3:*=null;
            var loc1:*=this.elements.length;
            var loc2:*="[CLIK Constraints (" + loc1 + ")]";
            var loc4:*=0;
            var loc5:*=this.elements;
            for (loc3 in loc5) 
                loc2 = loc2 + ("\n\t" + loc3 + ": " + this.elements[loc3].toString());
            return loc2;
        }

        protected function handleScopeAddedToStage(arg1:flash.events.Event):void
        {
            this.addToParentConstraints();
            return;
        }

        protected function addToParentConstraints():void
        {
            if (this.parentConstraints != null) 
                this.parentConstraints.removeEventListener(scaleform.clik.events.ResizeEvent.RESIZE, this.handleParentConstraintsResize);
            this.parentConstraints = null;
            var loc1:*=this.scope.parent;
            if (loc1 == null) 
                return;
            while (loc1 != null) 
            {
                if (loc1.hasOwnProperty("constraints")) 
                {
                    this.parentConstraints = loc1["constraints"] as scaleform.clik.utils.Constraints;
                    if (!(this.parentConstraints == null) && this.parentConstraints.scaleMode == scaleform.clik.constants.ConstrainMode.REFLOW) 
                        return;
                    if (!(this.parentConstraints == null) && this.scaleMode == scaleform.clik.constants.ConstrainMode.REFLOW) 
                        return;
                    if (this.parentConstraints != null) 
                    {
                        this.parentConstraints.addEventListener(scaleform.clik.events.ResizeEvent.RESIZE, this.handleParentConstraintsResize, false, 0, true);
                        break;
                    }
                }
                loc1 = loc1.parent;
            }
            if (this.parentConstraints != null) 
            {
                this.parentXAdjust = this.parentConstraints.getXAdjust();
                this.parentYAdjust = this.parentConstraints.getYAdjust();
            }
            return;
        }

        protected function handleParentConstraintsResize(arg1:scaleform.clik.events.ResizeEvent):void
        {
            this.parentXAdjust = arg1.scaleX;
            this.parentYAdjust = arg1.scaleY;
            this.update(this.lastWidth, this.lastHeight);
            return;
        }

        public function dispose():void
        {
            if (this.scope) 
            {
                this.scope.removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.handleScopeAddedToStage, false);
                this.scope.removeEventListener(flash.events.Event.REMOVED_FROM_STAGE, this.handleScopeAddedToStage, false);
                this.scope = null;
            }
            if (this.parentConstraints) 
            {
                this.parentConstraints.removeEventListener(scaleform.clik.events.ResizeEvent.RESIZE, this.handleParentConstraintsResize);
                this.parentConstraints = null;
            }
            return;
        }

        
        {
            ALL = LEFT | RIGHT | TOP | BOTTOM;
        }

        public static const LEFT:uint=1;

        public static const RIGHT:uint=2;

        public static const TOP:uint=4;

        public static const BOTTOM:uint=8;

        public static const CENTER_H:uint=16;

        public static const CENTER_V:uint=32;

        public var scope:flash.display.DisplayObject;

        public var scaleMode:String="counterScale";

        public var parentXAdjust:Number=1;

        public var parentYAdjust:Number=1;

        protected var elements:Object;

        protected var elementCount:int=0;

        protected var parentConstraints:scaleform.clik.utils.Constraints;

        public var lastWidth:Number=NaN;

        public var lastHeight:Number=NaN;

        public static var ALL:uint;
    }
}
