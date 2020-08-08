# name: notebook
# version: 0.7.2

enabled_site_setting :notebook_enabled

register_asset 'stylesheets/notebook.css'

load File.expand_path('../app/note_store.rb', __FILE__)


after_initialize do
  load File.expand_path('../app/controllers/notebook_controller.rb', __FILE__)
  load File.expand_path('../app/controllers/notes_controller.rb', __FILE__)
  
  if SiteSetting.notebook_debug?
    File.open("./log/log.txt", "a") { |f| f.write "#{Time.now} - Initiated notebook plugin\n" }
  end

  
  Discourse::Application.routes.append do
    get '/notebook' => 'notebook#index'

    get '/notes' => 'notes#index'
    put '/notes/:note_id' => 'notes#update'
    delete '/notes/:note_id' => 'notes#destroy'
  end
end
