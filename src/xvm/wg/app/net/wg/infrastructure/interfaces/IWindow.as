package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.controls.Button;
   import scaleform.clik.utils.Constraints;
   import flash.display.MovieClip;
   import scaleform.clik.utils.Padding;


   public interface IWindow extends IWrapper, IDraggable, IDisposable
   {
          
      function get windowContent() : IAbstractWindowView;

      function getTitleBtnEx() : ITextContainer;

      function getTitleBtn() : Button;

      function getCloseBtn() : Button;

      function setMaxWidth(param1:Number) : void;

      function setMaxHeight(param1:Number) : void;

      function getMinWidth() : Number;

      function setMinWidth(param1:Number) : void;

      function getMinHeight() : Number;

      function setMinHeight(param1:Number) : void;

      function setTitleIcon(param1:String) : void;

      function getConstraints() : Constraints;

      function updateSize(param1:Number, param2:Number, param3:Boolean=false) : void;

      function getBackground() : MovieClip;

      function getIconMovie() : MovieClip;

      function setSize(param1:Number, param2:Number) : void;

      function setWindowContent(param1:IAbstractWindowView) : void;

      function get useBottomBtns() : Boolean;

      function set useBottomBtns(param1:Boolean) : void;

      function set title(param1:String) : void;

      function get contentPadding() : Object;

      function set contentPadding(param1:Object) : void;

      function get formBgPadding() : Padding;

      function set formBgPadding(param1:Padding) : void;
   }

}