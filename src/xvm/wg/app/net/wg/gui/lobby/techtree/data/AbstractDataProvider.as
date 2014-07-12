package net.wg.gui.lobby.techtree.data
{
   import net.wg.gui.lobby.techtree.interfaces.INodesDataProvider;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import flash.events.EventDispatcher;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
   import flash.events.Event;
   
   public class AbstractDataProvider extends Object implements INodesDataProvider
   {
      
      public function AbstractDataProvider() {
         super();
         this.dispatcher = new EventDispatcher(this);
         this.nodeData = new Vector.<NodeData>();
      }
      
      protected static function findAndSetState(param1:Vector.<NodeData>, param2:Number, param3:Number, param4:Number) : Boolean {
         var _loc5_:* = false;
         var _loc6_:Object = param1[param2];
         if(_loc6_ != null)
         {
            _loc5_ = !((_loc6_.state & param3) == (param4 & param3));
            _loc6_.state = param4;
         }
         return _loc5_;
      }
      
      protected var _nation:String = "ussr";
      
      protected var nodeData:Vector.<NodeData>;
      
      protected var nodeIdxCache:Object;
      
      protected var dispatcher:EventDispatcher;
      
      public function get nation() : String {
         return this._nation;
      }
      
      public function get length() : Number {
         return this.nodeData.length;
      }
      
      public function clearUp() : void {
         this.nodeData.splice(0,this.nodeData.length);
         this.nodeIdxCache = {};
      }
      
      public function invalidate(param1:String, param2:Object) : void {
         this._nation = param1;
         if(param2 != null)
         {
            this.parse(param2);
            this.dispatchEvent(new TechTreeEvent(TechTreeEvent.DATA_BUILD_COMPLETE));
         }
      }
      
      public function parse(param1:Object) : void {
         throw new Error("Method \'raw\' must be override.");
      }
      
      public function getRootItem() : NodeData {
         return this.nodeData.length > 0?this.nodeData[0]:null;
      }
      
      public function getItemAt(param1:Number) : NodeData {
         return this.nodeData[param1];
      }
      
      public function getIndexByID(param1:Number) : Number {
         return this.nodeIdxCache[param1] != undefined?this.nodeIdxCache[param1]:-1;
      }
      
      public function getItemByID(param1:Number) : NodeData {
         var _loc2_:Number = this.getIndexByID(param1);
         var _loc3_:NodeData = null;
         if(this.nodeData.length > _loc2_ > -1)
         {
            _loc3_ = this.nodeData[_loc2_];
         }
         return _loc3_;
      }
      
      public function setState(param1:Number, param2:Number, param3:Number) : Boolean {
         return findAndSetState(this.nodeData,param1,param2,param3);
      }
      
      public function setEarnedXP(param1:Number, param2:Number) : Boolean {
         var _loc3_:* = false;
         if(param1 < this.nodeData.length && !(this.nodeData[param1] == null))
         {
            this.nodeData[param1].earnedXP = param2;
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      public function setUnlockProps(param1:Number, param2:UnlockProps) : Boolean {
         var _loc3_:* = false;
         if(param1 < this.nodeData.length && !(this.nodeData[param1] == null))
         {
            this.nodeData[param1].unlockProps = param2;
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      public function setItemField(param1:String, param2:Number, param3:Object) : Boolean {
         var _loc5_:UnlockProps = null;
         var _loc4_:* = false;
         switch(param1)
         {
            case NodeData.UNLOCK_PROPS_FIELD:
               _loc5_ = new UnlockProps();
               _loc5_.fromArray(param3 as Array,App.utils.locale);
               _loc4_ = this.setUnlockProps(param2,_loc5_);
               break;
         }
         return _loc4_;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void {
         this.dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void {
         this.dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function dispatchEvent(param1:Event) : Boolean {
         return this.dispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean {
         return this.dispatcher.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean {
         return this.dispatcher.willTrigger(param1);
      }
   }
}
