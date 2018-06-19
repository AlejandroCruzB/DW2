#!/usr/bin/env python
from handlers.base import BaseHandler
from models.topic import Topic


class MainHandler(BaseHandler):
    def get(self):
        topic = Topic.query(Topic.deleted == False).fetch()
        context = {"topic": topic}
        return self.render_template("main.html", params=context)
