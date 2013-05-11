require "spec_helper"

describe MemoryStore do
  it "should define a _data_store method on the given model" do
    model = Class.new
    MemoryStore.new([], model)
    model.should respond_to :_data_store
  end
end
