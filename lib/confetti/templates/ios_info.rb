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
          "UIInterfaceOrientationLandscapeLeft",
          "UIInterfaceOrientationLandscapeRight",
          "UIInterfaceOrientationPortrait",
          "UIInterfaceOrientationPortraitUpsideDown"
        ]
      }

      def bundle_identifier
        @config.package
      end

      def bundle_version
        @config.version_string
      end

      def product_name
        @config.name.name
      end

      def output_filename
        "Info.plist"
      end

      def app_orientations
        ORIENTATIONS_MAP[@config.orientation]
      end
    end
  end
end
