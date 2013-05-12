require "spec_helper"

describe PostsController do
  describe "index" do
    it "should get all the blog posts" do
      get :index
      assigns(:posts).should be_present
    end
  end

  describe "show" do
    it "should get all the blog posts" do
      BlogPost.stub(:find).and_return(OpenStruct.new(title: "Example", slug: "example"))
      get :show, id: "example"
      assigns(:post).should be_present
    end
  end
end
