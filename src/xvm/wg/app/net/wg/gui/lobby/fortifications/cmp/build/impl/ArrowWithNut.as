package net.wg.gui.lobby.fortifications.cmp.build.impl
{
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.gui.lobby.fortifications.cmp.build.IArrowWithNut;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.utils.ITweenAnimator;
   import flash.display.DisplayObject;
   import net.wg.gui.lobby.fortifications.utils.impl.TweenAnimator;


   public class ArrowWithNut extends UIComponentEx implements IArrowWithNut
   {
          
      public function ArrowWithNut() {
         super();
      }

      public var nutMc:UILoaderAlt;

      private var _content:IUIComponentEx = null;

      private var _isExport:Boolean = true;

      private var _nutMcStartY:Number = 0;

      public function show() : void {
         this.removeAllAnims();
         var _loc1_:ITweenAnimator = this.getTweenAnimator();
         if(this._isExport)
         {
            _loc1_.addMoveUpAnim(this.nutMc,this._nutMcStartY,null);
            _loc1_.addMoveUpAnim(DisplayObject(this.content),0,null);
         }
         else
         {
            _loc1_.addMoveDownAnim(this.nutMc,this._nutMcStartY,null);
            _loc1_.addMoveDownAnim(DisplayObject(this.content),0,null);
         }
         _loc1_.addFadeInAnim(this.nutMc,null);
         _loc1_.addFadeInAnim(DisplayObject(this.content),null);
      }

      public function hide() : void {
         this.removeAllAnims();
         var _loc1_:ITweenAnimator = this.getTweenAnimator();
         if(this._isExport)
         {
            _loc1_.addMoveDownAnim(this.nutMc,this._nutMcStartY,null);
            _loc1_.addMoveDownAnim(DisplayObject(this.content),0,null);
         }
         else
         {
            _loc1_.addMoveUpAnim(this.nutMc,this._nutMcStartY,null);
            _loc1_.addMoveUpAnim(DisplayObject(this.content),0,null);
         }
         _loc1_.addFadeOutAnim(this.nutMc,null);
         _loc1_.addFadeOutAnim(DisplayObject(this.content),null);
      }

      public function get isExport() : Boolean {
         return this._isExport;
      }

      public function set isExport(param1:Boolean) : void {
         this._isExport = param1;
      }

      public function get isShowed() : Boolean {
         return (this.nutMc.visible) && this.nutMc.alpha == 1;
      }

      public function get content() : IUIComponentEx {
         return this._content;
      }

      public function set content(param1:IUIComponentEx) : void {
         this._content = param1;
      }

      override protected function onDispose() : void {
         if(this._content)
         {
            this._content.dispose();
            this._content = null;
         }
         if(this.nutMc)
         {
            this.nutMc.dispose();
            this.nutMc = null;
         }
         this.removeAllAnims();
         super.onDispose();
      }

      override protected function configUI() : void {
         super.configUI();
         this.nutMc.source = RES_ICONS.MAPS_ICONS_LIBRARY_FORTIFICATION_NUT;
         this._nutMcStartY = this.nutMc.y;
      }

      private function removeAllAnims() : void {
         this.getTweenAnimator().removeAnims(this.nutMc);
         this.getTweenAnimator().removeAnims(DisplayObject(this.content));
      }

      private function getTweenAnimator() : ITweenAnimator {
         return TweenAnimator.instance;
      }
   }

}