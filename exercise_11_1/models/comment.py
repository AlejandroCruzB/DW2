from google.appengine.ext import ndb
from google.appengine.api import taskqueue

class Comment(ndb.Model):
    content = ndb.TextProperty()
    author_email = ndb.StringProperty()
    topicid = ndb.IntegerProperty()
    topic_title = ndb.StringProperty()
    created = ndb.DateTimeProperty(auto_now_add=True)
    update = ndb.DateTimeProperty(auto_now=True)
    deleted = ndb.BooleanProperty(default=False)

    @classmethod
    def create(cls, content, user, topic):
        new_comment = cls(
            content=content,
            author_email=user.email(),
            topicid=topic.key.id(),
            topic_title=topic.title
        )
        new_comment.put()


        taskqueue.add(url='/task/email-new-comment',
                      params={"topic_author_email": topic.author_email,
                              "topic_title": topic.title,
                              "topicid": topic.key.id()
                              })


        return new_comment