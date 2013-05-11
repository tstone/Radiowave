require "spec_helper"

describe BlogPost do
  xit "should allow the user to specify a default for enabling comments" do
  end

  context "initializing from a file" do
    context "with all attributes specified" do
      subject(:post) { BlogPost.from_file(Rails.root.join("spec/fixtures/post1.md")) }
      its(:title) { should == "Example Markdown Post" }
    end
  end
end
