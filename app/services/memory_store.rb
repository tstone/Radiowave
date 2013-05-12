
class MemoryStore

  def initialize(data, model)
    @data = data
    store = self
    (class << model; self; end).instance_eval { define_method(:_data_store) { store } }
  end

  def [](i)
    @data[i]
  end

  def length
    @data.length
  end

  def all
    @data
  end

  alias :size :length
  alias :count :length

end
