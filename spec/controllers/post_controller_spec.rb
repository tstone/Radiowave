require "spec_helper"

describe PostsController do
  before do
    Rails.application.config.settings.stub(:count).and_return(10)
  end

  describe "index" do
    it "should get the first page of blog posts" do
      BlogPost.should_receive(:page).with(0, 10).and_return([faux_blog_post])
      get :index
      assigns(:posts).should be_present
    end

    it "should get the second page of blog posts" do
      BlogPost.should_receive(:page).with(10, 10).and_return([faux_blog_post])
      get :index, page: 2
      assigns(:posts).should be_present
    end

    it "should get the nth page of blog posts" do
      BlogPost.should_receive(:page).with(490, 10).and_return([faux_blog_post])
      get :index, page: 50
      assigns(:posts).should be_present
    end

    it "should fetch the theme view" do
      subject.should_receive(:themed_view_path).with("index").and_call_original
      get :index
    end
  end

  describe "show" do
    let(:post) { faux_blog_post }
    before do
      BlogPost.stub(:find).with("example").and_return(post)
    end

    it "should get the specified the blog posts" do
      get :show, id: "example"
      assigns(:post).id.should == post.id
    end

    it "should get the previous blog post, relative to the specified id" do
      prev_post = faux_blog_post(title: "Next Post")
      BlogPost.should_receive(:prev).with("example").and_return(prev_post)
      get :show, id: "example"
      assigns(:prev_post).id.should == prev_post.id
    end

    it "should get the next blog post, relative to the specified id" do
      next_post = faux_blog_post(title: "Next Post")
      BlogPost.should_receive(:next).with("example").and_return(next_post)
      get :show, id: "example"
      assigns(:next_post).id.should == next_post.id
    end
  end
end
