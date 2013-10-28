package net.wg.gui.lobby.profile.pages.awards
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.lobby.profile.components.AwardsTileListBlock;
   import net.wg.gui.lobby.profile.data.ProfileAchievementVO;
   import net.wg.utils.ILocale;
   import __AS3__.vec.*;
   import flash.events.Event;
   import scaleform.clik.constants.InvalidationType;


   public class AwardsMainContainer extends UIComponent
   {
          
      public function AwardsMainContainer() {
         super();
         addEventListener(Event.RESIZE,this.blockResizeHandler,false,0,true);
      }

      private static function applyBlockData(param1:AwardsTileListBlock, param2:Array) : void {
         var _loc6_:* = false;
         var _loc7_:ProfileAchievementVO = null;
         var _loc8_:* = 0;
         var _loc9_:* = false;
         var _loc3_:Array = param1.dataProvider;
         var _loc4_:int = _loc3_?_loc3_.length:0;
         var _loc5_:int = param2?param2.length:0;
         if(_loc4_ != _loc5_)
         {
            _loc6_ = true;
         }
         else
         {
            _loc8_ = 0;
            while(_loc8_ < _loc5_)
            {
               _loc7_ = ProfileAchievementVO(param2[_loc8_]);
               _loc9_ = _loc7_.isEquals(_loc3_[_loc8_]);
               if(!_loc9_)
               {
                  _loc6_ = true;
                  break;
               }
               _loc8_++;
            }
         }
         if(_loc6_)
         {
            param1.dataProvider = param2;
         }
      }

      private var _gapBetweenBlocks:uint = 20;

      public var blockBattleHeroes:AwardsTileListBlock;

      public var blockHonors:AwardsTileListBlock;

      public var blockEpicAwards:AwardsTileListBlock;

      public var blockGroupAwards:AwardsTileListBlock;

      public var blockCommemoratives:AwardsTileListBlock;

      public var blockStageAwards:AwardsTileListBlock;

      public var blockSpecialAwards:AwardsTileListBlock;

      private var _allMedalsData:Array;

      private var blocks:Vector.<AwardsTileListBlock>;

      override protected function configUI() : void {
         var _loc2_:AwardsTileListBlock = null;
         super.configUI();
         var _loc1_:ILocale = App.utils.locale;
         this.blockBattleHeroes.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_BATTLEHEROES);
         this.blockHonors.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_HONORARY);
         this.blockEpicAwards.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_EPIC);
         this.blockGroupAwards.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_GROUP);
         this.blockCommemoratives.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_MEMORY);
         this.blockStageAwards.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_STAGE);
         this.blockSpecialAwards.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_SPECIAL);
         new Vector.<AwardsTileListBlock>(7)[0] = this.blockBattleHeroes;
         new Vector.<AwardsTileListBlock>(7)[1] = this.blockHonors;
         new Vector.<AwardsTileListBlock>(7)[2] = this.blockEpicAwards;
         new Vector.<AwardsTileListBlock>(7)[3] = this.blockGroupAwards;
         new Vector.<AwardsTileListBlock>(7)[4] = this.blockCommemoratives;
         new Vector.<AwardsTileListBlock>(7)[5] = this.blockStageAwards;
         new Vector.<AwardsTileListBlock>(7)[6] = this.blockSpecialAwards;
         this.blocks = new Vector.<AwardsTileListBlock>(7);
         for each (_loc2_ in this.blocks)
         {
            _loc2_.visible = false;
            _loc2_.addEventListener(Event.RESIZE,this.blockResizeHandler,false,0,true);
         }
      }

      private function blockResizeHandler(param1:Event) : void {
         param1.stopPropagation();
         invalidate(InvalidationType.SIZE);
      }

      override protected function draw() : void {
         var _loc1_:uint = 0;
         var _loc2_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:AwardsTileListBlock = null;
         var _loc5_:uint = 0;
         var _loc6_:* = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this.blocks.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               if(this._allMedalsData)
               {
                  applyBlockData(this.blocks[_loc2_],this._allMedalsData[_loc2_]);
               }
               else
               {
                  applyBlockData(this.blocks[_loc2_],[]);
               }
               _loc2_++;
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc3_ = this._gapBetweenBlocks;
            _loc5_ = this.blocks.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ = this.blocks[_loc6_];
               _loc4_.y = this._gapBetweenBlocks;
               _loc4_.visible = (_loc4_.dataProvider) && _loc4_.dataProvider.length > 0;
               if(_loc4_.visible)
               {
                  _loc4_.y = _loc3_;
                  _loc3_ = _loc3_ + Math.ceil(_loc4_.height + this._gapBetweenBlocks);
               }
               _loc6_++;
            }
            _height = _loc3_ - this._gapBetweenBlocks;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }

      public function set data(param1:Array) : void {
         this._allMedalsData = param1;
         invalidateData();
      }

      override public function dispose() : void {
         var _loc1_:AwardsTileListBlock = null;
         while(this.blocks.length > 0)
         {
            _loc1_ = this.blocks.splice(this.blocks.length-1,1)[0];
            _loc1_.removeEventListener(Event.RESIZE,this.blockResizeHandler);
            _loc1_.dispose();
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            _loc1_ = null;
         }
         this._allMedalsData = null;
         super.dispose();
      }

      public function set gapBetweenBlocks(param1:uint) : void {
         this._gapBetweenBlocks = param1;
         invalidateSize();
      }
   }

}