package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.infrastructure.base.meta.impl.ProfileTechniqueMeta;
   import net.wg.infrastructure.base.meta.IProfileTechniqueMeta;
   import net.wg.gui.lobby.profile.data.SectionLayoutManager;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
   import scaleform.clik.data.DataProvider;
   import flash.events.Event;
   import net.wg.gui.lobby.profile.ProfileConstants;
   import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;


   public class ProfileTechnique extends ProfileTechniqueMeta implements IProfileTechniqueMeta
   {
          
      public function ProfileTechnique() {
         super();
         this.listComponent.addEventListener(TechniqueListComponent.DATA_CHANGED,this.listDataChangeHandler,false,0,true);
      }

      private static const CURRENT_DIMENSION_INVALID:String = "cdInv";

      public var listComponent:TechniqueListComponent;

      public var stackComponent:TechniqueStackComponent;

      public var emptyScreen:ProfileTechniqueEmptyScreen;

      override protected function initialize() : void {
         super.initialize();
         layoutManager = new SectionLayoutManager(525,740);
         layoutManager.registerComponents(this.listComponent,this.stackComponent);
      }

      override protected function applyData(param1:Object) : Object {
         var _loc3_:Array = null;
         var _loc4_:TechniqueListVehicleVO = null;
         var _loc5_:Object = null;
         var _loc6_:* = false;
         var _loc7_:* = false;
         var _loc2_:Array = param1 as Array;
         _loc3_ = [];
         for each (_loc5_ in _loc2_)
         {
            _loc4_ = new TechniqueListVehicleVO(_loc5_);
            _loc3_.push(_loc4_);
         }
         _loc6_ = !(battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_TEAM);
         this.stackComponent.enableAwardsButton(_loc6_);
         this.listComponent.enableMarkOfMasteryBtn(_loc6_);
         this.listComponent.techniqueList.dataProvider = new DataProvider(_loc3_);
         _loc7_ = _loc3_.length > 0;
         this.emptyScreen.visible = !_loc7_;
         this.listComponent.visible = this.stackComponent.visible = _loc7_;
         return param1;
      }

      private function listDataChangeHandler(param1:Event) : void {
         var _loc2_:TechniqueListVehicleVO = this.listComponent.selectedItem;
         if(_loc2_)
         {
            this.stackComponent.updateLabel(_loc2_.userName,_loc2_.typeIconPath);
            requestDataS({"vehicleId":_loc2_.id});
         }
         else
         {
            this.stackComponent.updateLabel("",null);
         }
      }

      override protected function applyResizing() : void {
         if(layoutManager)
         {
            layoutManager.setDimension(currentDimension.x,currentDimension.y);
         }
         this.x = Math.round(currentDimension.x / 2 - centerOffset);
         var _loc1_:Number = Math.min(currentDimension.x,ProfileConstants.MIN_APP_WIDTH);
         this.emptyScreen.x = _loc1_ - this.emptyScreen.width >> 1;
         this.listComponent.setSize(currentDimension.x,currentDimension.y - this.listComponent.y);
         this.stackComponent.setViewSize(_loc1_ - this.stackComponent.x,currentDimension.y - this.stackComponent.y);
      }

      override public function as_responseDossier(param1:String, param2:Object) : void {
         super.as_responseDossier(param1,param2);
         if(battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_ALL)
         {
            this.emptyScreen.text = App.utils.locale.makeString(PROFILE.SECTION_TECHNIQUE_EMPTYSCREENLABEL_BATTLETYPE_ALL);
         }
         else
         {
            if(battlesType == PROFILE.PROFILE_DROPDOWN_LABELS_TEAM)
            {
               this.emptyScreen.text = App.utils.locale.makeString(PROFILE.SECTION_TECHNIQUE_EMPTYSCREENLABEL_BATTLETYPE_TEAM);
            }
            else
            {
               DebugUtils.LOG_WARNING("Battle type is not implemented!",battlesType);
            }
         }
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(CURRENT_DIMENSION_INVALID)) && (currentDimension))
         {
            this.applyResizing();
         }
      }

      public function as_responseVehicleDossier(param1:Object) : void {
         if(param1 != null)
         {
            this.stackComponent.updateTankData(new ProfileVehicleDossierVO(param1));
         }
         else
         {
            this.stackComponent.updateTankData(new ProfileVehicleDossierVO({}));
         }
      }

      override protected function onDispose() : void {
         if(this.listComponent)
         {
            this.listComponent.removeEventListener(TechniqueListComponent.DATA_CHANGED,this.listDataChangeHandler);
            this.listComponent.dispose();
            this.listComponent = null;
         }
         if(this.stackComponent)
         {
            this.stackComponent.dispose();
            this.stackComponent = null;
         }
         if(this.emptyScreen)
         {
            if(this.emptyScreen.parent)
            {
               this.emptyScreen.parent.removeChild(this.emptyScreen);
            }
            this.emptyScreen = null;
         }
         super.onDispose();
      }
   }

}