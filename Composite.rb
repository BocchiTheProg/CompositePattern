#Component class
class Component
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def get_size
    0
  end
end

#Leaf class
class MyFile < Component
  attr_writer :size

  def initialize(name, size)
    super(name)
    @size = size
  end

  def get_size
    @size
  end
end

#Composite class
class Folder < Component
  attr_accessor :components

  def initialize(name)
    super
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

#testing
file1 = MyFile.new("ThisIsFile.txt", 124)
file2 = MyFile.new("SomeGame", 842721)
puts file1.name
puts file1.get_size
file1.size =9923
puts file1.get_size
puts file2.name
puts file2.get_size
#puts file2.size
folder1 = Folder.new("FolderOfFiles")
puts folder1.name
puts folder1.get_size
folder1.add(file1)
folder1.add(file2)
puts folder1.get_size
folder1.remove(file1)
puts folder1.get_size
folder2 = Folder.new("BiggerFolder")
file3 = MyFile.new("AnotherFile", 4000)
puts folder2.name
puts folder2.add(file3)
puts folder2.add(folder1)
puts folder2.get_size
folder2.components.first.size=1111
puts folder2.get_size
