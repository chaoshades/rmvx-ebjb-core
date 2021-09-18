#==============================================================================
# ** Require Definition
#------------------------------------------------------------------------------
#  Definition of the require function to use other Ruby libraries
#==============================================================================

@@required_files = []
$: ||= ["./"]

def require(filename)
  if File.extname(filename) == "" then
    filename = filename + ".rb"
  end
  if @@required_files.include?(filename) then
    return false
  else
    @@required_files << filename
    file = $:.dup.find {|path|
      if path[-1,1] != "/" then path << "/" end
      File.exist?(path+filename)
    }
    if file then File.open(file+filename, "r") {|f| eval(f.read)} else raise LoadError end
    return true
  end
end
