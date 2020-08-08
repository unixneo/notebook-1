class NotebookController < ApplicationController
  def index
    if SiteSetting.notebook_debug?
      File.open("./log/log.txt", "a") { |f| f.write "#{Time.now} - Called NotebookController < ApplicationController index\n" }
    end
  end
end
