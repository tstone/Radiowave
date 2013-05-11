require "spec_helper"

 describe BlogPostScanner do
  let(:posts_path) { Rails.root.join("spec/fixtures").to_s }
  subject(:scanner) { BlogPostScanner.new(posts_path) }

  context "using the default store" do
    it "should return one blog post model for each blog post file in a given directory" do
      file_count = Dir[posts_path + "/*"].length
      posts = scanner.scan_and_parse
      posts.length.should > 0
      posts.length.should == file_count
    end
  end

end
