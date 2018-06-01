#!/usr/bin/env python
from handlers.base import BaseHandler
from google.appengine.api import users
from models.topic import Topic

class TopicHandler(BaseHandler):
    def get(self):
        return self.render_template("topic_add.html")

    def post(self):
        logged_user=users.get_current_user()

        if not logged_user:
            return self.write("Please login before")

        title_value = self.request.get("title")
        text_value = self.request.get("text") #title y text se pone porque son los nombres que tenemos en el type html, para el get.

        if "<script>" in text_value:
            return self.write("No Hack")

        if not text_value:
            return self.write("Required") #por si modifican el htrml quitando el campo required, que no puedan mandar datos vacios

        if not title_value:
            return self.write("Required") #por si modifican el htrml quitando el campo required, que no puedan mandar datos vacios

        new_topic = Topic(
            title=title_value,
            content=text_value, #hacemos un topic, donde el titulo recogido del html pertenece al title en la base de datos, igual con el content
            author_email=logged_user.email(), #guarda el email con el que se hace el login
        )

        new_topic.put() #manda a la base de datos

        #return self.write("Topic added succesfully") #nos sale este mensaje cuando creamos el topic
        return self.redirect_to("topic-detail", topicid=new_topic.key.id()) #Otra forma de hacerlo es posible, si o no
