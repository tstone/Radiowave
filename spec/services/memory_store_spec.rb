require "spec_helper"

describe MemoryStore do
  let(:data) do
    [ mock_blog_post(title: "Post 1", slug: "post1"),
      mock_blog_post(title: "Post 2", slug: "post2"),
      mock_blog_post(title: "Post 3", slug: "post3") ]
  end

  let(:store) do
    unless defined? MemoryStoreTestObject
      MemoryStoreTestObject = Class.new
      MemoryStoreTestObject.class.send(:include, MemoryStore)
      MemoryStoreTestObject.initialize_store(data)
    end
    MemoryStoreTestObject
  end

  it "should return all of the models" do
    store.all.map(&:id) =~ data.map(&:id)
  end

  it "should return a given page of models" do
    page = store.page(1, 1)
    page.length.should == 1
    page.first.title.should == "Post 2"
  end

  it "should find models by identifier" do
    store.find("post1").id.should == "post1"
    store.find("post1").title.should == "Post 1"
  end

  it "should get the next model" do
    store.next("post1").id.should == "post2"
  end

  it "should get the previous model" do
    store.prev("post1").id.should == "post3"
  end
end
