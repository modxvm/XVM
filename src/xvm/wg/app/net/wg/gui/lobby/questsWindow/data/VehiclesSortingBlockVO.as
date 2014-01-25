package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class VehiclesSortingBlockVO extends DAAPIDataClass
   {
          
      public function VehiclesSortingBlockVO(param1:Object) {
         this._vehicles = [];
         this._headerElements = [];
         this._nationFilterData = [];
         this._tankFilterData = [];
         this._levelFilterData = [];
         super(param1);
      }

      private var _linkage:String = "";

      private var _checkBoxLabel:String = "";

      private var _tableID:String = "";

      private var _hasHeader:Boolean;

      private var _showInHangarCB:Boolean;

      private var _showNotInHangarCB:Boolean;

      private var _cbSelected:Boolean;

      private var _vehicles:Array;

      private var _headerElements:Array;

      private var _nationFilterData:Array;

      private var _tankFilterData:Array;

      private var _levelFilterData:Array;

      public function get hasHeader() : Boolean {
         return this._hasHeader;
      }

      public function set hasHeader(param1:Boolean) : void {
         this._hasHeader = param1;
      }

      public function get showInHangarCB() : Boolean {
         return this._showInHangarCB;
      }

      public function set showInHangarCB(param1:Boolean) : void {
         this._showInHangarCB = param1;
      }

      public function get cbSelected() : Boolean {
         return this._cbSelected;
      }

      public function set cbSelected(param1:Boolean) : void {
         this._cbSelected = param1;
      }

      public function get vehicles() : Array {
         return this._vehicles;
      }

      public function set vehicles(param1:Array) : void {
         this._vehicles = param1;
      }

      public function get headerElements() : Array {
         return this._headerElements;
      }

      public function set headerElements(param1:Array) : void {
         this._headerElements = param1;
      }

      public function get nationFilterData() : Array {
         return this._nationFilterData;
      }

      public function set nationFilterData(param1:Array) : void {
         this._nationFilterData = param1;
      }

      public function get tankFilterData() : Array {
         return this._tankFilterData;
      }

      public function set tankFilterData(param1:Array) : void {
         this._tankFilterData = param1;
      }

      public function get levelFilterData() : Array {
         return this._levelFilterData;
      }

      public function set levelFilterData(param1:Array) : void {
         this._levelFilterData = param1;
      }

      public function get linkage() : String {
         return this._linkage;
      }

      public function set linkage(param1:String) : void {
         this._linkage = param1;
      }

      public function get tableID() : String {
         return this._tableID;
      }

      public function set tableID(param1:String) : void {
         this._tableID = param1;
      }

      public function get checkBoxLabel() : String {
         return this._checkBoxLabel;
      }

      public function set checkBoxLabel(param1:String) : void {
         this._checkBoxLabel = param1;
      }

      public function get showNotInHangarCB() : Boolean {
         return this._showNotInHangarCB;
      }

      public function set showNotInHangarCB(param1:Boolean) : void {
         this._showNotInHangarCB = param1;
      }
   }

}