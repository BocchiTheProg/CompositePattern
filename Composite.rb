#Component module
module Component
  def get_size
    0
  end

  # It is possible to include Composite methods in Component
  # def add(component)
  #   puts "#{self.class} not implementing this method :("
  #   #raise NotImplementedError, "Error"
  # end
  #
  # def remove(component)
  #   puts "#{self.class} not implementing this method :("
  #   #raise NotImplementedError, "Error"
  # end
end

#Leaf class
class MyFile
  include Component
  attr_accessor :name
  attr_writer :size

  def initialize(name, size)
    @name = name
    @size = size
  end

  def get_size
    @size
  end
end

#Composite class
class Folder
  include Component
  attr_accessor :name, :components

  def initialize(name)
    @name = name
    @components = []
  end

  def add(component)
    @components.append(component)
  end

  def remove(component)
    @components.delete(component)
  end

  def get_size
    @components.sum {|component| component.get_size}
  end
end

#User code (methods)
def find_size(component)
  puts "The size of #{component.name} is #{component.get_size} bytes."
  component.get_size
end

def add_component(component1, component2)
  puts "Add component #{component2.name} to component #{component1.name}"
  component1.add(component2)
end

def remove_component(component1, component2)
  puts "Remove component #{component2.name} from component #{component1.name}"
  component1.remove(component2)
end

#Testing
puts "--Working with MyFile(Leaf)--"
file1 = MyFile.new("SomeTextFile", 5000)
file2 = MyFile.new("SomeGame", 790000)
find_size(file1)
find_size(file2)
puts "--Working with Folder(Composite)--"
folder1 = Folder.new("FolderForTextAndGames")
find_size(folder1)
puts "-Adding Components(MyFiles) to created Folder-"
add_component(folder1, file1)
add_component(folder1, file2)
find_size(folder1)
puts "-Removing Component(MyFile) from created Folder-"
remove_component(folder1, file1)
find_size(folder1)
#Returning removed Component(MyFile)
folder1.add(file1)
puts "--Working with multiple Folders(Composite) and Files(Leafs)--"
folder2 = Folder.new("MainFolder")
file3 = MyFile.new("JustFile", 7500)
find_size(folder2)
add_component(folder2, file3)
add_component(folder2, folder1)
find_size(folder2)

##Example which will cause error if not including Composite methods in Component
# add_component(file1, file2)
