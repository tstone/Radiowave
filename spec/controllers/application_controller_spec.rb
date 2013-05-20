require "spec_helper"

describe ApplicationController do

  context "with themes," do
    before { teardown_test_theme }

    let(:test_theme) { "test_theme" }
    let(:test_theme_path) {  }

    describe "#themed_view_path" do
      it "should use the specified view from the theme if given in the settings" do
        write_theme_file("views/post.html.erb", "article= post.body")
        Rails.application.config.settings.stub(:theme).and_return(test_theme)
        subject.themed_view_path("post").should == "/lib/themes/#{test_theme}/views/post.html.erb"
      end

      it "should use the default view if the specified theme does not include that view" do
        Rails.application.config.settings.stub(:theme).and_return(test_theme)
        subject.themed_view_path("post").should == "/lib/themes/default/views/post.html.slim"
      end

      it "should use the default view if the specified theme does not include that view" do
        Rails.application.config.settings.stub(:theme).and_return("default")
        subject.themed_view_path("post").should == "/lib/themes/default/views/post.html.slim"

        Rails.application.config.settings.stub(:theme).and_return(nil)
        subject.themed_view_path("post").should == "/lib/themes/default/views/post.html.slim"
      end

      it "should use the name of the controller if not ApplicationController" do
        write_theme_file("views/posts/show.html.erb", "article= post.body")
        subject.stub(:controller_name).and_return("posts")
        Rails.application.config.settings.stub(:theme).and_return(test_theme)
        subject.themed_view_path("show").should == "/lib/themes/#{test_theme}/views/posts/show.html.erb"
      end
    end

    describe "#themed_layout_path" do
      it "should use the specified layout from the theme if given in the settings" do
        write_theme_file("views/layouts/application.html.erb", "body")
        Rails.application.config.settings.stub(:theme).and_return(test_theme)
        subject.themed_layout_path.should == "/lib/themes/#{test_theme}/views/layouts/application.html.erb"
      end

      it "should use the default layout if the specified theme does not include that layout" do
        Rails.application.config.settings.stub(:theme).and_return(test_theme)
        subject.themed_layout_path.should == "/lib/themes/default/views/layouts/application.html.slim"
      end

      it "should use the default view if the specified theme does not include that view" do
        Rails.application.config.settings.stub(:theme).and_return("default")
        subject.themed_layout_path.should == "/lib/themes/default/views/layouts/application.html.slim"

        Rails.application.config.settings.stub(:theme).and_return(nil)
        subject.themed_layout_path.should == "/lib/themes/default/views/layouts/application.html.slim"
      end
    end
  end


end
