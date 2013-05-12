
class MemoryStore

  def initialize(data, model)
    @list = data
    build_table(data)
    inject_data_store(model)
  end

  def all
    @list
  end

  def find(id)
    @table[id.to_s]
  end

  private # --------------------------------------------------------------------------------

  def inject_data_store(model)
    store = self
    (class << model; self; end).instance_eval { define_method(:_data_store) { store } }
  end

  def build_table(data)
    @table = {}
    data.each do |row|
      id = row.id.to_s
      @table[id] = row
    end
  end

end
