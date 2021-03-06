module Confetti
  module Template
    class IosInfo < Base
      ORIENTATIONS_MAP = {
        :landscape => [
          "UIInterfaceOrientationLandscapeLeft",
          "UIInterfaceOrientationLandscapeRight"
        ],
        :portrait => [
          "UIInterfaceOrientationPortrait",
          "UIInterfaceOrientationPortraitUpsideDown"
        ],
        :default => [
          "UIInterfaceOrientationPortrait",
          "UIInterfaceOrientationPortraitUpsideDown",
          "UIInterfaceOrientationLandscapeLeft",
          "UIInterfaceOrientationLandscapeRight"
        ]
      }

      STATUS_BARS = {
        :default              => "UIStatusBarStyleDefault",
        :"black-translucent"  => "UIStatusBarStyleBlackTranslucent",
        :"black-opaque"       => "UIStatusBarStyleBlackOpaque"
      }

      def icons
        @config.plist_icon_set
      end

      def bundle_identifier
        @config.package
      end

      def short_bundle_version
        @config.version_string
      end

      def bundle_version
        @config.ios_cfbundleversion || @config.version_string
      end

      def product_name
        @config.name.name
      end

      def output_filename
        "Info.plist"
      end

      def devices 
        nibs = ["NSMainNibFile"]

        @config.preference_set.each do |preference|
          next unless preference.name
          nibs << "NSMainNibFile~ipad" if preference.name.match /^universal$/
        end

        nibs
      end

      def app_orientations
        ORIENTATIONS_MAP[@config.orientation(:ios)]
      end

     def exit_on_suspend?
        @config.preference("exit-on-suspend", :ios) == :true
     end

      def fullscreen?
        @config.preference(:fullscreen, :ios) == :true
      end

      def url_schemes
        result = []
        
        @config.url_scheme_set.each { |url_scheme|
          result << {
            :name => url_scheme.name || @config.package,
            :role => %w{Editor Viewer Shell None}.find{|u| u == url_scheme.role} || "None",
            :schemes => url_scheme.schemes
          }
        }
        
        result
      end

      def prerendered_icon?
        @config.preference("prerendered-icon", :ios) == :true
      end

      def statusbar_style
        pref = @config.preference("ios-statusbarstyle", :ios)
        if pref
          STATUS_BARS[pref]
        end
      end
    end
  end
end
