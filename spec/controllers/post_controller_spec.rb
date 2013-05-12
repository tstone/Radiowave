require "spec_helper"

describe PostsController do
  describe "index" do
    it "should get the first page of blog posts" do
      BlogPost.should_receive(:page).with(0, 10).and_return((1..10).to_a)
      get :index
      assigns(:posts).should be_present
    end

    it "should get the second page of blog posts" do
      BlogPost.should_receive(:page).with(10, 10).and_return((10..20).to_a)
      get :index, page: 2
      assigns(:posts).should be_present
    end

    it "should get the nth page of blog posts" do
      BlogPost.should_receive(:page).with(490, 10).and_return((490..500).to_a)
      get :index, page: 50
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
