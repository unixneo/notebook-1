class NotebookController < ApplicationController
  def after_initialize
      File.open("./log/notebook_log.txt", "a") { |f| f.write "#{Time.now} - Called NotebookController < ApplicationController after_initialize\n" }
  end
  def index
    if SiteSetting.notebook_debug?
      File.open("./log/notebook_log.txt", "a") { |f| f.write "#{Time.now} - Called NotebookController < ApplicationController index\n" }
    end
  end
end
