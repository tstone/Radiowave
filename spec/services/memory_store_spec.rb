require "spec_helper"

describe MemoryStore do
  let(:data) {[ OpenStruct.new(id: 1, title: "1"), OpenStruct.new(id: 2, title: "2") ]}
  let(:store) {
    C = Class.new
    C.class.send(:include, MemoryStore)
    C.initialize_store(data)
    C
  }

  it "should return all of the models" do
    store.all.should =~ data
  end

  it "should find models by identifier" do
    store.find(1).title.should == "1"
  end

end
