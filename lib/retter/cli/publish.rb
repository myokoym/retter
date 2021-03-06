module Retter
  class CLI::Publish < Thor::Group
    class_attribute :root_path, :publish_proc

    include CLI::Hooks

    def publish
      return unless publish_proc

      Dir.chdir root_path do
        instance_eval &publish_proc
      end
    end

    Retter.on_initialize do |config|
      self.root_path    = config.root
      self.publish_proc = config.publisher

      -> { }
    end
  end
end
