class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method(name) do
        instance_variable_get("@#{name}")
      end #each
    end #get

    names.each do |name|
      define_method("#{name}=")  do |elem|
      instance_variable_set("@#{name}", elem)
    end #each
  end #set
end # def
end # class
