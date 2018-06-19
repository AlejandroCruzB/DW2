#!/usr/bin/env python
from handlers.base import BaseHandler
from models.topic import Topic
from models.comment import Comment
import uuid
from google.appengine.api import users, memcache


class DetailHandler(BaseHandler):
    def get(self, topicid):
        topic = Topic.get_by_id(int(topicid))
        comment = Comment.query(Comment.topicid == topic.key.id(), Comment.deleted == False).order(Comment.created).fetch()

        csrf_token = str(uuid.uuid4())
        memcache.add(key=csrf_token, value=users.get_current_user(), time=600)

        context = {"topic": topic, "comment": comment, "csrf_token": csrf_token}
        return self.render_template("detail.html", params=context)