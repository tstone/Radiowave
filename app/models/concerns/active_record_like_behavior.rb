
module ActiveRecordLikeBehavior

  def set_attributes(values)
    values.each do |k,v|
      instance_variable_set("@#{k}".to_sym, v)
    end
    return self
  end

end
