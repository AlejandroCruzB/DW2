#!/usr/bin/env python
from handlers.base import BaseHandler
from google.appengine.api import users, memcache
from models.comment import Comment
from models.topic import Topic
import uuid

class CommentHandler(BaseHandler):
    def post(self, topicid):
        user = users.get_current_user()

        if not user:
            return self.write("Please, login before")

        csrf_token = self.request.get("paco")
        mem_token = memcache.get(key=csrf_token)

        if not mem_token:
            return self.write("This website es protected")

        comment_value = self.request.get("comment")

        if "<script>" in comment_value:
            return self.write("No Hack script")

        if not comment_value:
            return self.write("Required")

        topic = Topic.get_by_id(int(topicid))

        new_comment = Comment(
            content=comment_value,
            author_email=user.email(),
            topicid=topic.key.id(),
            topic_title=topic.title
        )

        new_comment.put()

        return self.redirect_to("topic-detail", topicid=topic.key.id())

    def get(self, topicid):
        topic_value = Topic.get_by_id(int(topicid))
        comment = Comment.query(Comment.topicid == topic_value.key.id(), Comment.deleted == False).order(Comment.created).fetch()

        csrf_token = str(uuid.uuid4())
        memcache.add(key=csrf_token, value=True, time=600)

        context = {"topic": topic_value, "comment": comment, "csrf_token": csrf_token}
        return self.render_template("detail.html", params=context)