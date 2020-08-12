class NoteStore
  class << self
    def get_notes
      if SiteSetting.notebook_debug?
        File.open("./log/notebook_log.txt", "a") { |f| f.write "#{Time.now} - Called Get PluginStore.get('notebook', 'notes')\n" }
      end
      PluginStore.get('notebook', 'notes') || {}
    end

    def add_note(note_id, note)
      notes = get_notes()
      notes[note_id] = note
      if SiteSetting.notebook_debug?
        File.open("./log/notebook_log.txt", "a") { |f| f.write "#{Time.now} - Called Add PluginStore.set('notebook', 'notes', notes)\n" }
      end
      PluginStore.set('notebook', 'notes', notes)

      note
    end

    def remove_note(note_id)
      notes = get_notes()
      notes.delete(note_id)
      if SiteSetting.notebook_debug?
        File.open("./log/notebook_log.txt", "a") { |f| f.write "#{Time.now} - Called Delete PluginStore.set('notebook', 'notes', notes)\n" }
      end
      PluginStore.set('notebook', 'notes', notes)
    end
  end
end
