#!/usr/bin/env python
from handlers.base import BaseHandler
from google.appengine.api import users, memcache #ponemos aqui memcache para no repetir from google.appengine.api import memcache
from models.topic import Topic
from models.comment import Comment
import uuid #genera un token aleatorio

class TopicHandler(BaseHandler):
    def get(self):
        logged_user = users.get_current_user()

        if not logged_user:
            return self.write("Please login before.")

        csrf_token = str(uuid.uuid4()) #token aleatorio
        memcache.add(key=csrf_token, value=logged_user.email(), time=600) #600 segundos que dura el cache para que se borre
        #en value que estaba en true, lo cambiamos por logged_user.email(), el parentesis porque llama al metodo, para que cuando se relacione la key con un email que ha hecho el login

        context = {"csrf_token": csrf_token}

        return self.render_template("topic_add.html", params=context) #ponemos context para no poner en params=params

    def post(self):
        user = users.get_current_user() #ponemos user para ver que no tiene poque ser siempre logged_user

        if not user:
            return self.write("Please login before")

        csrf_token = self.request.get("paco")
        mem_token = memcache.get(key=csrf_token) #variable que recoge la key nueva

        if not mem_token or mem_token != user.email(): #como la variable memcache tiene el valor true, ponemos si no es true que pase esto
            #tambien ponemos que si el token es diferente al email, que de error
            return self.write("This website is protected agains CRSF attack :)")



        title_value = self.request.get("title")
        text_value = self.request.get("text")

        if "<script>" in text_value:
            return self.write("No Hack")

        if not text_value:
            return self.write("Required")

        if not title_value:
            return self.write("Required")

        new_topic = Topic(
            title=title_value,
            content=text_value,
            author_email=user.email(),
        )

        new_topic.put()


        return self.redirect_to("topic-detail", topicid=new_topic.key.id())
