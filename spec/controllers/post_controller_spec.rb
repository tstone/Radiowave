require "spec_helper"

describe PostsController do
  describe "index" do
    it "should get all the blog posts" do
      get :index
      assigns(:posts).should be_present
    end
  end

  describe "show" do
    it "should get the specified the blog posts" do
      BlogPost.should_receive(:find).with("example").and_return("post")
      get :show, id: "example"
      assigns(:post).should be_present
    end

    it "should get the previous blog post, relative to the specified id" do
      BlogPost.should_receive(:prev).with("example").and_return("prev")
      get :show, id: "example"
      assigns(:prev_post).should be_present
    end

    it "should get the next blog post, relative to the specified id" do
      BlogPost.should_receive(:next).with("example").and_return("next")
      get :show, id: "example"
      assigns(:next_post).should be_present
    end
  end
end
