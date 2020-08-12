class NotesController < ApplicationController
  def after_initialize
      File.open("./log/notebook_log.txt", "a") { |f| f.write "#{Time.now} - Called NotesControllerr < ApplicationController after_initialize\n" }
  end

  def index
    if SiteSetting.notebook_debug?
      File.open("./log/notebook_log.txt", "a") { |f| f.write "#{Time.now} - Called NotesController#index\n" }
      Rails.logger.info 'Called NotesController#index'
    end
    
    notes = NoteStore.get_notes()

    render json: { notes: notes.values }
  end

  def update
    if SiteSetting.notebook_debug?
      File.open("./log/notebook_log.txt", "a") { |f| f.write "#{Time.now} - Called NotesController#update\n" }
      Rails.logger.info 'Called NotesController#update'
    end
    note_id = params[:note_id]
    note = {
      'id' => note_id,
      'content' => params[:note][:content]
    }

    NoteStore.add_note(note_id, note)

    render json: { note: note }
  end

  def destroy
    if SiteSetting.notebook_debug?
      Rails.logger.info 'Called NotesController#destroy'
      File.open("./log/notebook_log.txt", "a") { |f| f.write "#{Time.now} - Called NotesController#destroy\n" }
    end
    NoteStore.remove_note(params[:note_id])

    render json: success_json
  end
end
