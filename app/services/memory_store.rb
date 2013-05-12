
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

  private # --------------------------------------------------------------------------------

  def build_table(data)
    @table = {}
    data.each do |row|
      id = row.id.to_s
      @table[id] = row
    end
  end

end
