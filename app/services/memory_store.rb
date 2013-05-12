
module MemoryStore

  def initialize_store(data)
    @list = data
    build_table(data)
  end

  def all
    @list
  end

  def find(id)
    @table[id.to_s]
  end

  def next(id)
    i = model_index_from_id(id)
    @list[i+1]
  end

  def prev(id)
    i = model_index_from_id(id)
    @list[i-1]
  end

  private # --------------------------------------------------------------------------------

  def model_index_from_id(id)
    counter = -1
    @list.detect do |model|
      counter += 1
      model.id == id
    end
    counter
  end

  def build_table(data)
    @table = {}
    data.each do |row|
      id = row.id.to_s
      @table[id] = row
    end
  end

end
