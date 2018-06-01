from google.appengine.ext import ndb

class Comment(ndb.Model):
    content = ndb.TextProperty()
    author_email = ndb.StringProperty()
    topic_id = ndb.IntegerProperty() #corresponde al id que genera directamente el datastore(NoSQL)
    topic_title = ndb.StringProperty()
    created = ndb.DateTimeProperty(auto_now_add=True)
    update = ndb.DateTimeProperty(auto_now=True)
    deleted = ndb.BooleanProperty(default=False)