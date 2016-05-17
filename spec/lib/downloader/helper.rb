module Spec
  module Downloader
    module Helper
      def prepare_download(success = true, additional_params = {})
        content = double(:content, to_sym: '')
        communication = double(:http, request: true, success?: success, content: content)
        communication_class = double(:communication_class, new: communication)
        file = double(:file)
        allow(file).to receive(:write)
        allow(File).to receive(:open).and_yield(file)
        allow(Logger).to receive(:new).and_return(double(:logger, info: true))

        downloader_initialize_params = {host: '', destination: '', communication_class: communication_class}
        if additional_params[:downloader_initialize_params]
          downloader_initialize_params.merge!(additional_params[:downloader_initialize_params])
        end

        # dynamically instantiate class under test
        downloader = Object.const_get("::#{described_class}").new(downloader_initialize_params)

        return content, file, downloader
      end
    end
  end
end