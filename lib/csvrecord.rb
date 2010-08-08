module Magic
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods    
    def read
      data = File.new("#{self.to_s.downcase}.csv")
      data.gets
      
      array = data.collect do |line|
        values = line.split(",")
        new(*values)
      end
      
      data.close
      array
    end
  end
end

class CsvRecord
  def self.make(file)
    raise "Not a csv file" unless file.end_with? "csv"
    
    data = File.new(file)
    header = data.gets.chomp.split(",")
    data.close
    
    create_class(file.sub(".csv", '')) do
      include Magic
      
      class_eval do
        define_method(:initialize) do |*values| 
          header.each_with_index do |accessor, i|
            self.class.class_eval { attr_accessor accessor.downcase.strip.to_sym }
            instance_variable_set("@#{accessor.downcase.strip}", values[i].strip)
          end
        end
      end
    end
  end
  
  def self.create_class(class_name, &block)
    klass = Class.new &block
    Object.const_set class_name.capitalize, klass
  end  
end

CsvRecord.make("contact.csv")
records = Contact.read

records.each do |contact|
  puts contact.firstname + " " + contact.lastname
end
