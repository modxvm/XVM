package net.wg.gui.lobby.profile.pages
{
   import net.wg.infrastructure.base.meta.impl.ProfileSectionMeta;
   import net.wg.infrastructure.base.meta.IProfileSectionMeta;
   import net.wg.gui.lobby.profile.components.IResizableContent;
   import net.wg.gui.lobby.profile.components.LineDescrIconText;
   import flash.geom.Point;
   import net.wg.gui.lobby.profile.data.SectionLayoutManager;
   import net.wg.gui.lobby.profile.components.BattlesTypeDropdown;
   import net.wg.gui.lobby.profile.components.ResizableInvalidationTypes;
   import flash.events.Event;


   public class ProfileSection extends ProfileSectionMeta implements IProfileSectionMeta, IResizableContent
   {
          
      public function ProfileSection() {
         super();
      }

      private static const DOSSIER_DATA_INVALID:String = "ddInvalid";

      public static function applyInitDataToTextField(param1:String, param2:Object, param3:LineDescrIconText) : void {
         var _loc4_:Object = param2[param1];
         param3.description = _loc4_["description"];
         param3.iconSource = _loc4_["icon"];
      }

      protected var currentDimension:Point;

      public var layoutManager:SectionLayoutManager;

      private var isActive:Boolean;

      protected var _centerOffset:int = 0;

      public var battlesDropdown:BattlesTypeDropdown;

      protected var currentData:Object;

      protected var battlesType:String;

      override protected function draw() : void {
         super.draw();
         if((isInvalid(ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID)) && (this.currentDimension))
         {
            this.applyResizing();
         }
         if((isInvalid(DOSSIER_DATA_INVALID)) && (this.currentData))
         {
            this.applyData(this.currentData);
         }
      }

      override protected function configUI() : void {
         super.configUI();
         if(this.battlesDropdown)
         {
            this.battlesDropdown.addEventListener(Event.CHANGE,this.dropDownChangeHandler,false,0,true);
         }
      }

      private function dropDownChangeHandler(param1:Event) : void {
         requestDossierS(this.battlesDropdown.selectedItem);
      }

      protected function applyResizing() : void {
         if(this.layoutManager)
         {
            this.layoutManager.setDimension(this.currentDimension.x,this.currentDimension.y);
         }
         this.x = Math.round(this.currentDimension.x / 2 - this._centerOffset);
      }

      public function setViewSize(param1:Number, param2:Number) : void {
         if(!this.currentDimension)
         {
            this.currentDimension = new Point();
         }
         this.currentDimension.x = param1;
         this.currentDimension.y = param2;
         invalidate(ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID);
      }

      public function as_update(param1:Object) : void {
          
      }

      protected function applyData(param1:Object) : Object {
         return null;
      }

      public function as_setInitData(param1:Object) : void {
          
      }

      protected function disposeLayoutManager() : void {
         if(this.layoutManager)
         {
            this.layoutManager.dispose();
            this.layoutManager = null;
         }
      }

      override protected function onDispose() : void {
         this.currentData = null;
         this.currentDimension = null;
         if(this.battlesDropdown)
         {
            this.battlesDropdown.removeEventListener(Event.CHANGE,this.dropDownChangeHandler);
            this.battlesDropdown.dispose();
            this.battlesDropdown = null;
         }
         this.disposeLayoutManager();
         super.onDispose();
      }

      public function update(param1:Object) : void {
          
      }

      public function set active(param1:Boolean) : void {
         this.isActive = param1;
         setActiveS(param1);
      }

      public function get active() : Boolean {
         return this.isActive;
      }

      public function set centerOffset(param1:int) : void {
         this._centerOffset = param1;
         invalidate(ResizableInvalidationTypes.CURRENT_DIMENSION_INVALID);
      }

      public function get centerOffset() : int {
         return this._centerOffset;
      }

      public function as_responseDossier(param1:String, param2:Object) : void {
         this.currentData = param2;
         this.battlesType = param1;
         if(this.battlesDropdown)
         {
            this.battlesDropdown.selectedItem = param1;
         }
         invalidate(DOSSIER_DATA_INVALID);
      }
   }

}