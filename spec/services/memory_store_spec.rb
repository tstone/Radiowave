require "spec_helper"

describe MemoryStore do
  let(:data) {[ OpenStruct.new(id: 1, title: "1"), OpenStruct.new(id: 2, title: "2") ]}
  let(:store) {
    unless defined? MemoryStoreTestObject
      MemoryStoreTestObject = Class.new
      MemoryStoreTestObject.class.send(:include, MemoryStore)
      MemoryStoreTestObject.initialize_store(data)
    end
    MemoryStoreTestObject
  }

  it "should return all of the models" do
    store.all.should =~ data
  end

  it "should find models by identifier" do
    store.find(1).title.should == "1"
  end

end
