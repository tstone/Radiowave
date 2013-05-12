require "spec_helper"

describe MemoryStore do
  let(:data) {[ OpenStruct.new(id: 1, title: "1"), OpenStruct.new(id: 2, title: "2") ]}
  let(:store) { MemoryStore.new(data, BlogPost) }

  it "should define a _data_store method on the given model" do
    model = Class.new
    MemoryStore.new([], model)
    model.should respond_to :_data_store
  end

  it "should return all of the models" do
    store.all.should =~ data
  end

  it "should find models by identifier" do
    store.find(1).title.should == "1"
  end

end
