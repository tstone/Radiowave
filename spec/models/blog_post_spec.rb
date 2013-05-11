require "spec_helper"

describe BlogPost do
  it "should allow assignment of attributes" do
    subject.set_attributes(title: "Test", slug: "test")
    subject.title.should == "Test"
    subject.slug.should == "test"
  end

  xit "should allow the user to specify a default for enabling comments" do
  end

  context "initializing from a file" do

    context "with all attributes specified" do
      subject(:path) { Rails.root.join("spec/fixtures/post1.md") }
      subject(:post) { BlogPost.from_file(path) }

      its(:comments) { should == true }
      its(:date) { should == Date.parse("May 18, 2012") }
      its(:slug) { should == "totally-custom-slug" }
      its(:tags) { should =~ ["simple", "easy", "sample"] }
      its(:title) { should == "Example Markdown Post" }

      it "should render the body to HTML" do
        Redcarpet::Markdown.any_instance.stub(:render).and_return("<html>")
        post = BlogPost.from_file(path)
        post.body.should == "<html>"
      end
    end

    context "with no attributes specified" do

    end

  end
end
