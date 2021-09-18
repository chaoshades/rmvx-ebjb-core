module EBJB_Core_Ext
  # Build filename
  FINAL   = "build/EBJB_Core_Ext.rb"
  # Source files
  TARGETS = [
    "src/External Scripts/Y6_Core_Engine.rb",
    "src/External Scripts/Zlib_PNG_File.rb",
    "src/External Scripts/FIX_gradient_fill_rect.rb",
    "src/External Scripts/Window_Command Addon.rb",
  ]
end

def ebjb_build_ext
  final = File.new(EBJB_Core_Ext::FINAL, "w+")
  EBJB_Core_Ext::TARGETS.each { |file|
    src = File.open(file, "r+")
    final.write(src.read + "\n")
    src.close
  }
  final.close
end

ebjb_build_ext()