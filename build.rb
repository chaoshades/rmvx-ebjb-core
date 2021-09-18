module EBJB_Core
  # Build filename
  FINAL   = "build/EBJB_Core.rb"
  # Source files
  TARGETS = [
	"src/Script_Header.rb",
    "src/Core_Config.rb",
    "src/RPG Objects/RPG_Element.rb",
    "src/User Controls/UserControl.rb",
    "src/User Controls/UCLabelIconsList.rb",
    "src/User Controls/UCControlsSwitchableList.rb",
    "src/User Controls/UCLabelIconsSwitchableList.rb",
    "src/User Controls/UCLabelIconControlsSwitchableList.rb",
    "src/User Controls/UCLabelIcon.rb",
    "src/User Controls/UCLabelValue.rb",
    "src/User Controls/UCLabelIconValue.rb",
    "src/User Controls/UCCharacterGraphic.rb",
    "src/User Controls/UCCharacterFace.rb",
    "src/User Controls/UCEnemyGraphic.rb",
    "src/User Controls/UCBackgroundImage.rb",
    "src/User Controls/UCIcon.rb",
    "src/User Controls/UCNumericUpDown.rb",
    "src/User Controls/UCBar.rb",
    "src/User Controls/UCGraph.rb",
    "src/User Controls/UCImageBorder.rb",
    "src/Basic Controls/Control.rb",
    "src/Basic Controls/CDrawingObject.rb",
    "src/Basic Controls/CLabel.rb",
    "src/Basic Controls/CImage.rb",
    "src/Basic Controls/CResizableImage.rb",
    "src/Basic Controls/CRectangle.rb",
    "src/Basic Controls/CPolygon.rb",
    "src/Basic Controls/CTriangle.rb",
    "src/Basic Controls/CCircle.rb",
    "src/Basic Controls/CLine.rb",
    "src/Basic Controls/CEllipse.rb",
    "src/Windows/Window_Base.rb",
    "src/Windows/Window_Scrollable.rb",
    "src/Windows/Window_Info_Help.rb",
    "src/Windows/Window_Details.rb",
    "src/Windows/Window_ItemDetails.rb",
    "src/Windows/Window_EquipDetails.rb",
    "src/Windows/Window_SkillDetails.rb",
    "src/Windows/Window_Logo.rb",
    "src/Windows/Window_Confirmation.rb",
    "src/Windows/Window_Selectable Addon.rb",
    "src/Windows/Window_Selectable_Headers.rb",
    "src/Windows/Window_Custom_Selectable.rb",
    "src/Windows/Window_Selectable_Multiple.rb",
    "src/Scenes/Sub_Scene_Base.rb",
    "src/Scenes/Scene_Title.rb",
    "src/User Interface/Font.rb",
    "src/User Interface/Color.rb",
    "src/User Interface/Bitmap Addon.rb",
    "src/User Interface/Vocab.rb",
    "src/Misc Objects/GraphElement.rb",
    "src/Misc Objects/CursorPosition.rb",
    "src/Misc Objects/Filter.rb",
    "src/Misc Objects/Comparer.rb",
    "src/Misc Objects/BaseItemComparer.rb",
    "src/Misc Objects/SkillComparer.rb",
    "src/Misc Objects/ItemComparer.rb",
    "src/Misc Objects/BaseItemFilter.rb",
    "src/Misc Objects/UsableItemFilter.rb",
    "src/Misc Objects/ItemFilter.rb",
    "src/Misc Objects/SkillFilter.rb",
    "src/Misc Objects/WeaponFilter.rb",
    "src/Misc Objects/ArmorFilter.rb",
    "src/Other Scripts/RequireDefinition.rb",
  ]
end

def ebjb_build
  final = File.new(EBJB_Core::FINAL, "w+")
  EBJB_Core::TARGETS.each { |file|
    src = File.open(file, "r+")
    final.write(src.read + "\n")
    src.close
  }
  final.close
end

ebjb_build()