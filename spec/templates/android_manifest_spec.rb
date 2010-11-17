require 'spec_helper'

describe Confetti::Template::AndroidManifest do
  include HelpfulPaths

  before :all do
    AndroidTemplate = Confetti::Template::AndroidManifest
  end

  it "should inherit from the base template" do
    AndroidTemplate.superclass.should be Confetti::Template::Base
  end

  it "should have the template_file \"android.mustache\" in the confetti/templates dir" do
    AndroidTemplate.template_file.should == "#{ templates_dir }/android_manifest.mustache"
  end

  describe "templated attributes" do
    subject { @template = AndroidTemplate.new }

    it { should respond_to :package_name }
    it { should respond_to :class_name }
  end
end
