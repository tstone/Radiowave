require "spec_helper"

describe BlogPost do
  let(:fixture1) { Rails.root.join("spec/fixtures/post1.md") }
  let(:fixture2) { Rails.root.join("spec/fixtures/subfolder/post2.md") }

  it "should allow assignment of attributes" do
    subject.set_attributes(title: "Test", slug: "test")
    subject.title.should == "Test"
    subject.slug.should == "test"
  end

  it "should find posts that include a given tag" do
    posts = BlogPost.find_with_tag("simple")
    posts.length.should == 1
    posts.first.slug.should == "totally-custom-slug"
  end

  it "should find posts by searching with a free text query" do
    posts = BlogPost.search("inline code")
    posts.length.should == 1
    posts.first.slug.should == "totally-custom-slug"
  end

  it "should allow the user to specify a default for enabling comments" do
    Rails.application.config.settings.stub(:comments).and_return(false)
    BlogPost.new.comments.should == false
  end

  context "initializing from a file" do

    context "with all attributes specified" do
      subject(:post) { BlogPost.from_file(fixture1) }

      its(:comments) { should == true }
      its(:date) { should == Date.parse("May 18, 2012") }
      its(:slug) { should == "totally-custom-slug" }
      its(:tags) { should =~ ["simple", "easy", "sample"] }
      its(:title) { should == "Example Markdown Post" }

      it "should render the body to HTML" do
        Redcarpet::Markdown.any_instance.stub(:render).and_return("<html>")
        post = BlogPost.from_file(fixture1)
        post.body.should == "<html>"
      end
    end

    context "with no attributes specified" do
      subject(:post) do
        File.stub(:ctime).and_return(Date.parse("May 18, 2012"))
        BlogPost.from_file(fixture2)
      end

      its(:comments) { should == true }
      its(:date) { should == Date.parse("May 18, 2012") }
      its(:slug) { should == "post2" }
      its(:tags) { should =~ [] }
      its(:title) { should == "Post2" }
    end

  end
end
