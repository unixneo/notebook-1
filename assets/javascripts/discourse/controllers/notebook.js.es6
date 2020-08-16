import discourseComputed from "discourse-common/utils/decorators";
export default Ember.Controller.extend({
  @discourseComputed()
  isPermitted() {
    if (
      Discourse.User.current() == null &&
      Discourse.SiteSettings.notebook_show_guests == false
    ) {
      return false;
    } else {
      return true;
    }
  },
  init() {
    this._super();
    this.set("notes", []);
    this.fetchNotes();
    if (Discourse.SiteSettings.notebook_debug == true) {
      console.log("Ember.Controller.extend: init");
    }
  },
  fetchNotes() {
    var ascending = false;
    if (Discourse.SiteSettings.notebook_ascending !== "undefined") {
      ascending = Discourse.SiteSettings.notebook_ascending;
    }

    this.store
      .findAll("note")
      .then((result) => {
        for (const note of result.content) {
          this.notes.pushObject(note);
        }
        this.notes.reverse();
      })
      .catch(console.error);
  },

  actions: {
    createNote(content) {
      if (!content) {
        return;
      }

      var da_user = "";
      if (Discourse.User.current() == null) {
        da_user = "guest";
      } else {
        da_user = Discourse.currentUser.username;
      }

      var now = new moment();
      var my_time = now.format("HH:mm:ss");
      da_user = "[" + my_time + "] " + da_user + ": ";

      const noteRecord = this.store.createRecord("note", {
        id: Date.now(),
        content: da_user + content,
      });

      noteRecord
        .save()
        .then((result) => {
          this.notes.pushObject(result.target);
          this.set("note", "");
          this.notes.reverse();
        })
        .catch(console.error);
      this.notes.reverse();
    },
    deleteNote(note) {
      this.store
        .destroyRecord("note", note)
        .then(() => {
          this.notes.removeObject(note);
        })
        .catch(console.error);
    },
  },
});
