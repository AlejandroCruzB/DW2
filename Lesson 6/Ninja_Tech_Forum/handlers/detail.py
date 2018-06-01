#!/usr/bin/env python
from handlers.base import BaseHandler
from models.topic import Topic

class DetailHandler(BaseHandler):
    def get(self, topicid):
        topic = Topic.get_by_id(int(topicid))
        params = {"topic": topic}
        return self.render_template("detail.html", params=params)