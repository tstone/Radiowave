
class MemoryStore

  def initialize(data, model)
    @data = data
    (class << model; self; end).instance_eval { define_method(:_data_store) { self } }
  end

  def [](i)
    @data[i]
  end

  def length
    @data.length
  end

end
