module Searchable

  extend ActiveSupport::Concern

  module ClassMethods
    def search(data)
      query = all
      self.search_operators.each_pair do |attribute, operator|
        if operator.is_a? Hash
          query = self.search_with_scope(data, attribute, query)
        else
          query = self.search_attribute(self.table_name, attribute, operator, data[attribute], query)
        end
      end 
      query   
    end
    
    protected

    def search_with_scope(data, scope, query)
      self.search_operators[scope].each_pair do |attribute, operator|
        attribute_name = self.get_scoped_attribute(scope, attribute)
        query = self.search_attribute(scope, attribute, operator, data[attribute_name], query)
      end
      query
    end

    def get_scoped_attribute(scope, attribute)
      "#{scope.to_s.singularize}_#{attribute}"
    end

    def search_attribute(scope,attribute,operator,value,query)
      unless value.blank?
        if operator.eql? 'between'
          query = self.search_between(scope,attribute,operator,value,query) 
        else
          value = "%#{value}%" if operator.eql? 'ilike'      
          query = query.where("#{scope}.#{attribute} #{operator} ?", value_for_attribute(value, attribute))
        end     
      end
      query
    end

    def search_between(scope,attribute,operator,value,query)
      unless value[:start].blank? or value[:end].blank?
        query = query.where("#{scope}.#{attribute} #{operator} ? AND ?", self.value_for_attribute(value[:start], attribute), self.value_for_attribute(value[:end], attribute))  
      end
      query
    end

    def value_for_attribute(value, attribute)
      if(self.time_attributes.include? attribute)
        value = Time.parse(value)
      end
      value
    end
    
  end
end