# frozen_string_literal: true

# name: notebook
# about: notebook is a fork of the notebook tutorial plugin https://github.com/kleinfreund/notebook
# version: 0.7.3
# authors: kleinfreund, unixneo
# url: https://github.com/unixneo/notebook-neo

enabled_site_setting :notebook_enabled

register_asset 'stylesheets/notebook.css'

load File.expand_path('../app/note_store.rb', __FILE__)


after_initialize do
  load File.expand_path('../app/controllers/notebook_controller.rb', __FILE__)
  load File.expand_path('../app/controllers/notes_controller.rb', __FILE__)
  
  if SiteSetting.notebook_debug?
    File.open("./log/notebook_log.txt", "a") { |f| f.write "#{Time.now} - Initialized notebook plugin - after_initialize plugin.rb\n" }
  end

  
  Discourse::Application.routes.append do
    get '/notebook' => 'notebook#index'

    get '/notes' => 'notes#index'
    put '/notes/:note_id' => 'notes#update'
    delete '/notes/:note_id' => 'notes#destroy'
  end
end
