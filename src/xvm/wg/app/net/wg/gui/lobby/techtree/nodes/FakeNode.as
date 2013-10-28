package net.wg.gui.lobby.techtree.nodes
{
   import __AS3__.vec.Vector;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.math.MatrixPosition;
   import net.wg.gui.lobby.techtree.constants.ColorIndex;
   import net.wg.gui.lobby.techtree.TechTreeEvent;


   public class FakeNode extends Renderer
   {
          
      public function FakeNode() {
         super();
      }

      private var children:Vector.<IRenderer>;

      private var parents:Vector.<IRenderer>;

      private var lastPrimary:Number = NaN;

      override public function setup(param1:uint, param2:NodeData, param3:uint=0, param4:MatrixPosition=null) : void {
         this.lastPrimary = NaN;
         super.setup(param1,param2,param3,param4);
      }

      override public function isFake() : Boolean {
         return true;
      }

      override public function isUnlocked() : Boolean {
         return this.hasUnlockedParent();
      }

      override public function getInX() : Number {
         return x + Math.round(_width);
      }

      override public function getOutX() : Number {
         return x + Math.round(_width);
      }

      override public function getColorIdx(param1:Number=-1) : Number {
         var _loc2_:Number = ColorIndex.LOCKED;
         if(this.hasUnlockedChild())
         {
            if(param1 == -1 || param1 > 0 && (isParentUnlocked(param1)))
            {
               _loc2_ = ColorIndex.UNLOCKED;
            }
         }
         else
         {
            if(this.hasNext2UnlockChild())
            {
               if(param1 == -1 || param1 > 0 && (isParentUnlocked(param1)))
               {
                  _loc2_ = ColorIndex.NEXT2UNLOCK;
               }
            }
         }
         return _loc2_;
      }

      override public function getColorIdxEx(param1:IRenderer) : Number {
         var _loc2_:Number = ColorIndex.LOCKED;
         if(this.hasUnlockedChild())
         {
            if(param1 == null || (param1.isUnlocked()))
            {
               _loc2_ = ColorIndex.UNLOCKED;
            }
         }
         else
         {
            if(this.hasNext2UnlockChild())
            {
               if(param1 == null || (param1.isUnlocked()))
               {
                  _loc2_ = ColorIndex.NEXT2UNLOCK;
               }
            }
         }
         return _loc2_;
      }

      override public function invalidateNodeState(param1:Number) : void {
         if(param1 > -1 && !(this.lastPrimary == param1))
         {
            this.lastPrimary = param1;
            dispatchEvent(new TechTreeEvent(TechTreeEvent.STATE_CHANGED,param1,index));
         }
      }

      override public function cleanUp() : void {
         this.clearChildren();
         this.clearParents();
         this.lastPrimary = NaN;
         super.cleanUp();
      }

      public function setChildren(param1:Vector.<IRenderer>) : void {
         this.clearChildren();
         this.children = param1;
         var _loc2_:Number = this.children.length;
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            this.children[_loc3_].addEventListener(TechTreeEvent.STATE_CHANGED,this.handleChildStateChanged,false,0,true);
            _loc3_++;
         }
      }

      public function setParents(param1:Vector.<IRenderer>) : void {
         this.clearParents();
         this.parents = param1;
         var _loc2_:Number = this.parents.length;
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            this.parents[_loc3_].addEventListener(TechTreeEvent.STATE_CHANGED,this.handleParentStateChanged,false,0,true);
            _loc3_++;
         }
      }

      override public function toString() : String {
         return "[FakeNode " + index + ", " + name + "]";
      }

      override protected function preInitialize() : void {
         super.preInitialize();
         this.parents = new Vector.<IRenderer>();
         this.children = new Vector.<IRenderer>();
      }

      private function clearParents() : void {
         var _loc1_:IRenderer = null;
         while(this.parents.length > 0)
         {
            _loc1_ = this.parents.pop();
            if(_loc1_ != null)
            {
               _loc1_.removeEventListener(TechTreeEvent.STATE_CHANGED,this.handleParentStateChanged);
            }
         }
      }

      private function clearChildren() : void {
         var _loc1_:IRenderer = null;
         while(this.children.length > 0)
         {
            _loc1_ = this.children.pop();
            if(_loc1_ != null)
            {
               _loc1_.removeEventListener(TechTreeEvent.STATE_CHANGED,this.handleChildStateChanged);
            }
         }
      }

      private function hasUnlockedParent() : Boolean {
         var _loc1_:IRenderer = null;
         var _loc2_:Number = this.parents.length;
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this.parents[_loc3_];
            if(_loc1_.isUnlocked())
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }

      private function hasUnlockedChild() : Boolean {
         var _loc1_:IRenderer = null;
         var _loc2_:Number = this.children.length;
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this.children[_loc3_];
            if(_loc1_.isFake())
            {
               if((_loc1_ as FakeNode).hasUnlockedChild())
               {
                  return true;
               }
            }
            else
            {
               if(_loc1_.isUnlocked())
               {
                  return true;
               }
            }
            _loc3_++;
         }
         return false;
      }

      private function hasNext2UnlockChild() : Boolean {
         var _loc1_:IRenderer = null;
         var _loc2_:Number = this.children.length;
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this.children[_loc3_];
            if(_loc1_.isFake())
            {
               if((_loc1_ as FakeNode).hasNext2UnlockChild())
               {
                  return true;
               }
            }
            else
            {
               if(_loc1_.isNext2Unlock())
               {
                  return true;
               }
            }
            _loc3_++;
         }
         return false;
      }

      private function handleParentStateChanged(param1:TechTreeEvent) : void {
         this.invalidateNodeState(param1.primary);
      }

      private function handleChildStateChanged(param1:TechTreeEvent) : void {
         this.invalidateNodeState(param1.primary);
      }
   }

}