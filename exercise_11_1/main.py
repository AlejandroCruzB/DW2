#!/usr/bin/env python
import webapp2
from handlers.main import MainHandler
from handlers.cookie import CookieAlertHandler
from handlers.topic import TopicHandler
from handlers.detail import DetailHandler
from handlers.comment import CommentHandler
from workers.email_new_comment import EmailNewCommentWorker



app = webapp2.WSGIApplication([
    webapp2.Route('/', MainHandler, name="main-page"),
    webapp2.Route('/set-cookie', CookieAlertHandler, name='set-cookie'),
    webapp2.Route('/topic/add', TopicHandler, name="topic-add"),
    webapp2.Route('/topic/<topicid:\d+>', DetailHandler, name="topic-detail"),
    webapp2.Route('/topic/<topicid:\d+>/comment/add', CommentHandler, name="comment"),
    webapp2.Route('/task/email-new-comment', EmailNewCommentWorker, name="task-email-new-comment")
], debug=True)
