require "spec_helper"

 describe BlogPostScanner do
  let(:posts_path) { Rails.root.join("spec/fixtures").to_s }
  let(:fixture_files) { Dir[posts_path + "/*"] }
  subject(:scanner) { BlogPostScanner.new(posts_path) }

  it "should be testing against at least one fixture file" do
    fixture_files.length.should > 0
  end

  it "should scan a directory for markdown files, including sub-directories, calling the given block once each" do
    counter = 0
    scanner.scan { counter += 1 }
    counter.should == fixture_files.length
  end

  it "should return one populated blog post model for each blog post file, sorted by newest first" do
    posts = scanner.scan_and_parse
    posts.length.should == fixture_files.length
    posts.each do |post|
      post.should be_a_kind_of BlogPost
      post.title.should_not be_empty
    end
  end

  it "should attach a store of parsed blog posts to the BlogPost model" do
    scanner.scan_and_store
    BlogPost.all.length.should == 3
  end

end
