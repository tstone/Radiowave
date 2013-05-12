module DataStorable

  def method_missing(method, *args, &block)
    if respond_to? :_data_store
      _data_store.send(method, *args, &block)
    else
      super
    end
  end

end
